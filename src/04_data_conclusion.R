library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(ggplot2)

forest_fires <- read_csv(here("results/forest_fires.csv"))

fire_recipe <- recipe(Classes ~ ISI + BUI, data = fire_train) %>%
  step_scale(all_predictors()) %>%
  step_center(all_predictors())

# taking only the accuracies
accuracies <- knn_results %>%
  filter(.metric == "accuracy")

# Save the csv
write_csv(accuracies, here("results/accuracies.csv"))

line_plot <- plot_line_graph(data=accuracies, plot_width=10, plot_height=10, x_axis_data=neighbors, 
                             y_axis_data=mean, x_axis_label="Neighbors", y_axis_label="Accuracy Estimate")

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

# Save the csv
write_csv(fire_test_predictions, here("results/fire_test_predictions.csv"))

options(repr.plot.width = 8, repr.plot.height = 8)
cb_palette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442",
                         "#0072B2", "#D55E00", "#CC79A7", "#999999")

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

# plot a graph
wkflw_plot <-
  ggplot() +
  geom_point(data = forest_fires,
             mapping = aes(x = ISI, y = BUI, color = Classes),
             alpha = 0.75) +
  geom_point(data = prediction_table,
             mapping = aes(x = ISI, y = BUI, color = Classes),
             alpha = 0.02, size = 5.) +
  labs(color = "IS there fire?") +
  scale_color_manual(labels = c("Forest fire present",
                                "Forest fire not present"),
                     values = cb_palette)

ggsave(here("results/classification_regions.png"), plot = wkflw_plot,
       device = "png")