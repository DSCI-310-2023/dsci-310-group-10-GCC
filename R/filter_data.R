library(dplyr)
library(purrr)

#' Filter data function
#'
#' This function calculates metrics based on a given algorithm
#' (e.g. mean, range, etc.) on the used dataset (e.g. fire_train)
#' filters the data by a given column name and a value and by a 
#' column range
#'
#' @param col_to_filter_by Name of the column which should be used
#' for filtering the data.
#' 
#' @param subset The filtering condition which the targeted function
#' should follow.
#'
#' @param alg  The filtering algorithm which the targeted function
#' should follow.
#'
#' @param start_col The start of the column range which should be
#' selected from the data.
#' 
#' @param end_col The end of the column range which should be
#' selected from the data.
#'
#' @return Return the data filtered by the parameters above.
#'
#' @export
#'
#' @example
#' filter_data("fire", range)
filter_data <- function(data, col_to_filter_by, subset,
    start_col, end_col, alg) {
    filtered_data <- data %>%
        filter({{col_to_filter_by}} == {{subset}}) %>%
        select({{start_col}}:{{end_col}}) %>%
        map_df({{alg}})
    return(filtered_data)
}