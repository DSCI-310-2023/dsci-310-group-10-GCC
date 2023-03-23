library(ggplot2)

#' Line plot function
#' 
#' This function plots a line graph given the data and the column names to 
#' visualize and enables to customize the graphs axis labels and plot dimensions
#'
#' @param data The data which should be visualized
#' @param plot_width The width of the plot
#' @param plot_height The height of the plot
#' @param x_axis_data The column name of the passed data which should be 
#' displayed on the x axis
#' @param y_axis_data The column name of the passed data which should be 
#' displayed on the y axis
#' @param x_axis_label Label which will be displayed in the plot for the x axis
#' @param y_axis_label Label which will be displayed in the plot for the y axis
#'
#' @return The generated plot
#'
#' @export
#' 
#' @example 
#' plot_line_graph(data=accuracies, plot_width=10, plot_height=10, x_axis_data=neighbors, 
#'                            y_axis_data=mean, x_axis_label="Neighbors", y_axis_label="Accuracy Estimate")
plot_line_graph <- function(data, plot_width, plot_height, x_axis_data, 
                            y_axis_data, x_axis_label, y_axis_label) {
  # Check if all parameters are passed
  # Adapted from https://stackoverflow.com/questions/38758156/r-check-if-any-missing-arguments
  defined <- ls()
  passed <- names(as.list(match.call())[-1])
  
  if (any(!defined %in% passed)) {
    stop(paste("missing values for", paste(setdiff(defined, passed), collapse=",
                                           ")))
  }

  options(repr.plot.width=plot_width, repr.plot.height=plot_height)
  
  return(ggplot(data, aes(x = {{x_axis_data}}, y = {{y_axis_data}})) +
    geom_point() +
    geom_line() +
    labs(x = x_axis_label, y = y_axis_label))
}



#' Scatter plot function
#'
#' This function plots a scatter graph given the data and the column names to 
#' visualize and enables to customize the graphs axis labels and plot dimensions
#'
#' @param data The data which should be visualized
#' @param plot_width The width of the plot
#' @param plot_height The height of the plot
#' @param x_axis_data The column name of the passed data which should be 
#' displayed on the x axis
#' @param y_axis_data The column name of the passed data which should be 
#' displayed on the y axis
#' @param x_axis_label Label which will be displayed in the plot for the x axis
#' @param y_axis_label Label which will be displayed in the plot for the y axis
#' @param text_size Text size applied for all text in the plot
#' @param color Name of the label column of the dataset
#' @param color_label Defines labels for each of the colors
#'
#' @return The generated plot
#'
#' @export
#'
#' @example
#' plot_scatter_graph(data=fire_train, plot_width=8.9, plot_height=6, x_axis_data=ISI, 
#'                             y_axis_data=BUI, x_axis_label="Initial Spread Index", y_axis_label="presence of fire", 
#'                             text_size=20, color=Classes, color_label="presence of fire")
plot_scatter_graph <- function(data, plot_width, plot_height, x_axis_data, 
                               y_axis_data, x_axis_label, y_axis_label, 
                               text_size, color, color_label) {
  
  # Check if all parameters are passed
  # Adapted from https://stackoverflow.com/questions/38758156/r-check-if-any-missing-arguments
  defined <- ls()
  passed <- names(as.list(match.call())[-1])
  
  if (any(!defined %in% passed)) {
    stop(paste("missing values for", paste(setdiff(defined, passed), collapse=",
                                           ")))
  }
  
  options(repr.plot.width=plot_width, repr.plot.height=plot_height)
  
  return(ggplot(data, aes(x = {{x_axis_data}}, y = {{y_axis_data}}, color = {{color}})) + 
    geom_point() +
    labs(x = x_axis_label, y = y_axis_label, color = color_label) +
    theme(text = element_text(size=text_size)))
}