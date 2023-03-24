# Library
library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(ggplot2)


options(repr.matrix.max.rows = 6)

source(here("src/R/plot_fn.R"))

# resize so we can see the plots
options(repr.plot.width = 20, repr.plot.height = 20)

# Load data from previous processing steps
fire_train <- read.csv(here("results/fire_train.csv"))
fire_test <- read.csv(here("results/fire_test.csv"))

fire_train_plot <- fire_train %>% 
    ggpairs(aes(color = Classes))

scatter_plot <- plot_scatter_graph(data=fire_train, plot_width=8.9, plot_height=6, x_axis_data=ISI, 
                               y_axis_data=BUI, x_axis_label="Initial Spread Index", y_axis_label="presence of fire", 
                               text_size=20, color=Classes, color_label="presence of fire")

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

# Saving all the graphs
ggsave(here("results/correlation_graph.png"), plot = fire_train_plot, device = "png", width = 20, height = 20)
ggsave(here("results/scatter_plot.png"), plot = scatter_plot, device = "png")
ggsave(here("results/line_plot.png"), plot = line_plot, device = "png")