library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(ggplot2)

source(here("R/plot_fn.R"))

forest_fires <- read_csv(here("results/analysis_data/forest_fires.csv"))
fire_train <- read_csv(here("results/analysis_data/fire_train.csv"))
accuracies <- read_csv(here("results/analysis_data/accuracies.csv"))
prediction_table <- read_csv(here("results/analysis_data/prediction_table.csv"))

fire_train_plot <- fire_train %>%
  ggpairs(aes(color = Classes))

scatter_plot <- plot_scatter_graph(
  data = fire_train, plot_width = 8.9,
  plot_height = 6, x_axis_data = ISI, y_axis_data = BUI,
  x_axis_label = "Initial Spread Index", y_axis_label = "presence of fire",
  text_size = 20, color = Classes, color_label = "presence of fire"
)

line_plot <- plot_line_graph(
  data = accuracies, plot_width = 10,
  plot_height = 10, x_axis_data = neighbors, y_axis_data = mean,
  x_axis_label = "Neighbors", y_axis_label = "Accuracy Estimate"
)

options(repr.plot.width = 8, repr.plot.height = 8)
cb_palette <- c(
  "#E69F00", "#56B4E9", "#009E73", "#F0E442",
  "#0072B2", "#D55E00", "#CC79A7", "#999999"
)

# plot final conclusion plot
wkflw_plot <-
  ggplot() +
  geom_point(
    data = forest_fires,
    mapping = aes(x = ISI, y = BUI, color = Classes),
    alpha = 0.75
  ) +
  geom_point(
    data = prediction_table,
    mapping = aes(x = ISI, y = BUI, color = Classes),
    alpha = 0.02, size = 5.
  ) +
  labs(color = "IS there fire?") +
  scale_color_manual(labels = c(
    "Forest fire present",
    "Forest fire not present"
  ), values = cb_palette)

# Saving all the graphs
ggsave(here("results/analysis_data/classification_regions.png"),
  plot = wkflw_plot,
  device = "png"
)
ggsave(here("results/analysis_data/correlation_graph.png"),
  plot = fire_train_plot,
  device = "png", width = 20, height = 20
)
ggsave(here("results/analysis_data/scatter_plot.png"), plot = scatter_plot, device = "png")
ggsave(here("results/analysis_data/line_plot.png"), plot = line_plot, device = "png")
