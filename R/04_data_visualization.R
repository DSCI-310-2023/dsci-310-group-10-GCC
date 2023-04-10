library(tidyverse)
library(GGally)
library(tidymodels)
library(here)
library(ggplot2)
library(FFire)
library(docopt)

doc <- "
Loads forest fire data from given input directory input_dir, cleans it,
and puts it into output directory output_dir

Usage: src/04_data_visualization.R --input_dir_load_forest_fire=<input_dir_load_forest_fire> --input_dir_load_fire_train=<input_dir_load_fire_train>  --input_dir_load_accuracies=<input_dir_load_accuracies> --input_dir_prediction_table=<input_dir_prediction_table>  --out_dir=<output_dir>

Options:
--input_dir_load_forest_fire=<input_dir_load_forest_fire>		
Relative path to project root (fire_train) to raw data
--input_dir_load_fire_train=<input_dir_load_fire_train>		
Relative path to project root (fire_test) to raw data
--input_dir_load_accuracies=<input_dir_load_accuracies>		
Relative path to project root (forest_fire) to raw data
--input_dir_prediction_table=<input_dir_prediction_table>		
Relative path to project root (forest_fire) to raw data
--out_dir=<output_dir>		Path to directory relative to project root
where the results should be saved
"

opt <- docopt(doc)
input_dir_load_forest_fire <- opt[["--input_dir_load_forest_fire"]]
input_dir_load_fire_train <- opt[["--input_dir_load_fire_train"]]
input_dir_load_accuracies <- opt[["--input_dir_load_accuracies"]]
input_dir_prediction_table <- opt[["--input_dir_prediction_table"]]
output_dir <- opt[["--out_dir"]]

forest_fires <- read_csv(here(input_dir_load_forest_fire))
fire_train <- read_csv(here(input_dir_load_fire_train))
accuracies <- read_csv(here(input_dir_load_accuracies))
prediction_table <- read_csv(here(input_dir_prediction_table))

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
  labs(color = "Is there fire?") +
  scale_color_manual(labels = c(
    "Forest fire present",
    "Forest fire not present"
  ), values = cb_palette)

# Saving all the graphs
ggsave(here(output_dir, "classification_regions.png"),
  plot = wkflw_plot,
  device = "png"
)
ggsave(here(output_dir, "correlation_graph.png"),
  plot = fire_train_plot,
  device = "png", width = 20, height = 20
)
ggsave(here(output_dir, "scatter_plot.png"), plot = scatter_plot, device = "png")
ggsave(here(output_dir, "line_plot.png"), plot = line_plot, device = "png")
