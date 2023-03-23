library(testthat)
library(here)
source(here("src/R/plot_fn.R"))

# Test plot_line_graph
synt_data_plot_line_graph <- data.frame(
  neighbors = c(1, 2, 3),
  mean = c(0.80, 0.85, 0.95)
)

line_plot = plot_line_graph(data=synt_data_plot_line_graph, plot_width=10, 
                            plot_height=10, x_axis_data=neighbors, 
                            y_axis_data=mean, x_axis_label="Neighbors", 
                            y_axis_label="Mean")

testthat::expect_identical(line_plot$labels$y, "Mean")
testthat::expect_identical(line_plot$labels$x, "Neighbors")
testthat::expect_error(print(line_plot), NA)


# Test plot_scatter_graph
synt_data_plot_scatter_graph <- data.frame(
  ISI = c(5.2, 2.1, 5.2),
  BUI = c(10.1, 2.1, 4.2),
  Classes = c("fire", "fire", "no fire")
)

scatter_plot = plot_scatter_graph(data=synt_data_plot_scatter_graph, 
                                  plot_width=10, plot_height=10, x_axis_data=ISI, 
                                  y_axis_data=BUI, x_axis_label="ISI", 
                                  y_axis_label="BUI", text_size=20, color=Classes, 
                                  color_label="Presence of fire")

testthat::expect_identical(scatter_plot$labels$y, "BUI")
testthat::expect_identical(scatter_plot$labels$x, "ISI")
testthat::expect_error(print(scatter_plot), NA)