# This file prepares all of the data needed for visualization
library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(ggplot2)
library(docopt)

options(repr.matrix.max.rows = 6)

# resize so we can see the plots
options(repr.plot.width = 20, repr.plot.height = 20)

doc <- "
Loads forest fire data from given input directory input_dir, cleans it,
and puts it into output directory output_dir

Usage: src/03_table_generation.R --input_dir_load_fire_train=<input_dir_load_fire_train> --input_dir_load_fire_test=<input_dir_load_fire_test>  --input_dir_load_forest_fire=<input_dir_load_forest_fire>  --out_dir=<output_dir>

Options:
--input_dir_load_fire_train=<input_dir_load_fire_train>		
Relative path to project root (fire_train) to raw data
--input_dir_load_fire_test=<input_dir_load_fire_test>		
Relative path to project root (fire_test) to raw data
--input_dir_load_forest_fire=<input_dir_load_forest_fire>		
Relative path to project root (forest_fire) to raw data
--out_dir=<output_dir>		Path to directory relative to project root
where the results should be saved
"

opt <- docopt(doc)
input_dir_load_fire_train <- opt[["--input_dir_load_fire_train"]]
input_dir_load_fire_test <- opt[["--input_dir_load_fire_test"]]
input_dir_load_forest_fire <- opt[["--input_dir_load_forest_fire"]]
output_dir <- opt[["--out_dir"]]

# Load data from previous processing steps
fire_train <- read.csv(here(input_dir_load_fire_train))
fire_test <- read.csv(here(input_dir_load_fire_test))
forest_fires <- read_csv(here(input_dir_load_forest_fire))

# making the 10-fold cross validation,
#    setting the strata (predicted variable) as Classes
fire_vfold <- vfold_cv(fire_train, v = 10, strata = Classes)

# making the recipe, taking the data from the training set
# and ISI and BUI as the variables we use to predict
fire_recipe <- recipe(Classes ~ ISI + BUI, data = fire_train) %>%
  step_scale(all_predictors()) %>%
  step_center(all_predictors())

# making the model specification for tuning, setting weight_func to rectangular
# so that each neighbor has equal "say" and neighbors to tune().
knn_tune <- nearest_neighbor(
  weight_func = "rectangular",
  neighbors = tune()
) %>%
  set_engine("kknn") %>%
  set_mode("classification")

# k_lots is used to decide the k values we will "try"
# and check the accuracies for
k_lots <- tibble(neighbors = seq(from = 1, to = 50, by = 1))

# making the workflow and fitting the recipe and model,
# and collecting the metrics.
knn_results <- workflow() %>%
  add_recipe(fire_recipe) %>%
  add_model(knn_tune) %>%
  tune_grid(resamples = fire_vfold, grid = k_lots) %>%
  collect_metrics()

# taking only the accuracies
accuracies <- knn_results %>%
  filter(.metric == "accuracy")

# we don't need to make a new recipe,
# since we can reuse the recipe from the last step.

# making the model specification,
# this time specifying the number of neighbors we want
knn_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = 5) %>%
  set_engine("kknn") %>%
  set_mode("classification")

# fitting the spec and recipe to the workflow
knn_fit <- workflow() %>%
  add_recipe(fire_recipe) %>%
  add_model(knn_spec) %>%
  fit(data = fire_train)

# we use the knn_fit to predict the class in fire_test,
# and then we add that .pred_class column to the testing set.
fire_test_predictions <- predict(knn_fit, fire_test) %>%
  bind_cols(fire_test) %>%
  mutate(Classes = as.factor(Classes))

# create the grid of area/smoothness vals, and arrange in a data frame
# forest_fires$BUI means forest_fire df, BUI column
isi_grid <- seq(min(forest_fires$ISI), max(forest_fires$ISI), length.out = 100)
bui_grid <- seq(min(forest_fires$BUI), max(forest_fires$BUI), length.out = 100)
asgrid <- as_tibble(expand.grid(ISI = isi_grid, BUI = bui_grid))

# use the fit workflow to make predictions at the grid points
knn_pred_grid <- predict(knn_fit, asgrid)

# bind the predictions as a new column with the grid points
prediction_table <- bind_cols(knn_pred_grid, asgrid) %>%
  rename(Classes = .pred_class)

# The chart that tells us how many entries are on each factor in Classes
fire_training_count <- fire_train %>%
  group_by(Classes) %>%
  summarise(n = n())

# Getting the confusion matrix, setting the "real" column to Classes,
# and the predicted column .pred_class
fire_test_predictions$Classes <- as.factor(fire_test_predictions$Classes)
fire_test_predictions$.pred_class <-
    as.factor(fire_test_predictions$.pred_class)

confusion_matrix <- fire_test_predictions %>%
  conf_mat(truth = Classes, estimate = .pred_class)

# Save the generated csvs
write_csv(accuracies, here(output_dir, "accuracies.csv"))
write_csv(fire_test_predictions, here(output_dir, "fire_test_predictions.csv"))
write_csv(prediction_table, here(output_dir, "prediction_table.csv"))
write_csv(fire_training_count, here(output_dir, "fire_training_count.csv"))
saveRDS(confusion_matrix, here(output_dir, "confusion_matrix.rds"))