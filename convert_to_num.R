#' convert_to_num: convert numeric columns into numeric data 
#'
#' This function takes a dataframe and its column names as input and returns dataframe with right numeric datatype.
#'
#' @param df the dataframe containing columns to be converted
#' @param cols a vector of the names of numeric columns with non-numeric data type
#'
#' @return a dataframe with corrected numeric columns
#'


convert_to_num <- function(df, cols){
    for (col in cols){
        df[[col]] <- as.numeric(df[[col]])
    }
    return(df)
}

library(testthat)
df1=data.frame(c_to_n = c('1','2'))
df1_test=convert_to_num(df1, 'c_to_n')
df1_expect=data.frame(c_to_n = c(1,2))

test_that("data frames are identical", {
  expect_equal(df1_test, df1_expect)
})