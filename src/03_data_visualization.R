# Library
library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(testthat)

options(repr.matrix.max.rows = 6)

# resize so we can see the plots
options(repr.plot.width = 20, repr.plot.height = 20)
# ggpairs was used to do look at our preliminary data analysis,
# so we can see the general picture
# we add the color argument so we can compare the relationship
# between the 2 columns and the classes column
fire_train %>%
    ggpairs(aes(color = Classes))

plot_scatter_graph(data = fire_train, plot_width = 8.9,
                    plot_height = 6, x_axis_data = ISI,
                    y_axis_data = BUI, x_axis_label = "Initial Spread Index",
                    y_axis_label = "presence of fire",
                    text_size = 20,
                    color = Classes, color_label = "presence of fire")

set.seed(123)
# making the 10-fold cross validation,
#    setting the strata (predicted variable) as Classes
fire_vfold <- vfold_cv(fire_train, v = 10, strata = Classes)

# making the recipe, taking the data from the training set
# and ISI and BUI as the variables we use to predict
# note: we will reuse this recipe later
fire_recipe <- recipe(Classes ~ ISI + BUI, data = fire_train) %>%
  step_scale(all_predictors()) %>%
  step_center(all_predictors())

#making the model specification for tuning, setting weight_func to rectangular
# so that each neighbor has equal "say" and neighbors to tune().
knn_tune <- nearest_neighbor(weight_func = "rectangular",
                             neighbors = tune()) %>%
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

accuracies

plot_line_graph(data = accuracies, plot_width = 10, plot_height = 10,
                x_axis_data = neighbors, y_axis_data = mean,
                x_axis_label = "Neighbors", y_axis_label = "Accuracy Estimate")

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
  bind_cols(fire_test)

fire_test_predictions

# getting the confusion matrix,
# setting the "real" column to Classes and the predicted column .pred_class

fire_test_predictions %>%
  conf_mat(truth = Classes, estimate = .pred_class)