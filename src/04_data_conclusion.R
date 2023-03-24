# Library
library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(testthat)

options(repr.matrix.max.rows = 6)

set.seed(123)

# getting the metrics, setting the "real" column to Classes
# and the predicted column .pred_class
fire_test_predictions %>%
  metrics(truth = Classes, estimate = .pred_class) %>%
  filter(.metric == "accuracy")

options(repr.plot.width=8, repr.plot.height=8)
cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442",
               "#0072B2", "#D55E00", "#CC79A7", "#999999")

# create the grid of area/smoothness vals, and arrange in a data frame
# forest_fires$BUI means forest_fire df, BUI column

isi_grid <- seq(min(forest_fires$ISI), max(forest_fires$ISI), length.out = 100)
bui_grid <- seq(min(forest_fires$BUI), max(forest_fires$BUI), length.out = 100)
asgrid <- as_tibble(expand.grid(ISI = isi_grid, BUI = bui_grid))

# use the fit workflow to make predictions at the grid points
knnPredGrid <- predict(knn_fit, asgrid)

# bind the predictions as a new column with the grid points
prediction_table <- bind_cols(knnPredGrid, asgrid) %>% 
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
                    values = cbPalette)

wkflw_plot