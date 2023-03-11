
#' data_load: load csv and split it into 2 each skips different numbers of lines
#'
#' This function takes a url, numbers of lines to be skipped in the first dataframe, numbers of lines to be skipped in the second dataframe, the maximum number of rows to read for the first dataframe, an error line, the corresponding corrected values, a vector of the names of numeric columns with non-numeric data type and the predictor as inputs, and returns the tidyed datafrrame that can be trained directly.
#'
#' @param url the URL of the CSV file to read.
#' @param skip1 the number of rows to skip at the beginning of the file in the first dataframe.
#' @param skip2 the number of rows to skip at the beginning of the file in the second dataframe.
#' @param n_max1 the maximum number of rows to read for the first dataframe.
#' @param n_max2 the maximum number of rows to read for the second dataframe.
#' @param error_line the line containing the messy record.
#' @param error_record columns of error entries.
#' @param correct_bef_error_record the number of columns proior to the error columns.
#' @param val_corrected list of corrected entries to the error_line.
#' @param error_col a vector of the names of numeric columns with non-numeric data type.
#' @param predicted_factor a column of the variable to be predicted
#' @return a dataframe with cleaned table.
#'

data_load <- function(url,skip1, skip2, n_max1, n_max2, error_line, error_record, correct_bef_error_record, val_corrected, error_col, predicted_factor){
    # load and split dataset into 2
    data1 <- read_csv(url, skip = skip1, n_max = n_max1, col_types = NULL, show_col_types = FALSE)
    data2 <- read_csv(url, skip = skip2,n_max = n_max2,col_types = NULL, show_col_types = FALSE)
    
    # correct missing values
    for (i in error_record)
    {
        index = i - correct_bef_error_record
        data2[error_line, i] <- val_corrected[index]
    }

    # correct the datatype 
    data2 = convert_to_num(df = data2, cols = error_col)

    #combined 2 datasats splited
    data <- rbind(data1, data2)%>%mutate(predicted_factor = as_factor(!!sym(predicted_factor)))
    
    return(data)
 
}


library(testthat)

df2_test <- data_load(url = 'https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv',
                          skip1 = 0,
                          skip2 = 0,
                          n_max1 = 3,
                          n_max2 = 2,
                          error_line = 2,
                          error_record = 2:4,
                          correct_bef_error_record = 1,
                          val_corrected = list(3.5,1.4,0.2,'setosa'),
                          error_col = c('petal_width'),
                          predicted_factor = 'species')

df2_expect=data.frame(sepal_length = c(5.1,4.9,4.7,5.1,4.9),
                     sepal_width = c(3.5,3.0,3.2,3.5,3.5),
                     petal_length = c(1.4,1.4,1.3,1.4,1.4),
                     petal_width=c(0.2,0.2,0.2,0.2,0.2),
                     species=c('setosa','setosa','setosa','setosa','setosa'),
                     predicted_factor = as_factor(c('setosa','setosa','setosa','setosa','setosa')))

test_that("data frames are identical", {
   expect_equivalent(df2_test, df2_expect)
})