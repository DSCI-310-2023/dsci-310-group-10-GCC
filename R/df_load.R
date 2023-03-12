source(here("R/convert_to_num.R"))
#' df_load
#'
#' This function load and preprocess a dataset from a CSV file,
#' split the date frame into 2 parts that the first part is nice formatted and the second part need manipulation,
#' correct the wrong row entries in the second part,
#' convert the numeric columns into correct data type,
#' combine the data together.
#'
#' @param url The quoted URL or file path of the CSV file.
#' @param skip1 The number of rows to skip at the beginning of the file for the first splited dataset.
#' @param skip2 The number of rows to skip at the beginning of the file for the second splited dataframe.
#' @param n_max1 The maximum number of rows to read for the first splited dataframe.
#' @param n_max2 The maximum number of rows to read for the second splited dataframe.
#' @param error_line The row index containing errors that need to be corrected.
#' @param error_record A vector of the column indices containing errors that need to be corrected.
#' @param correct_bef_error_record The number of correctly formatted rows before the row containing errors.
#' @param val_corrected list of corrected entries to the error_line.
#' @param error_col A vector of the corrected values for the error columns.
#' @param predicted_factor The quoted column name to be converted to a factor.
#'
#' @return The preprocessed data frame, with missing values corrected and data types converted.
#‘
#' @example
#' df_load(url = 'https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv',
#'         skip1 = 0,
#'         skip2 = 0,
#'         n_max1 = 3,
#'         n_max2 = 2,
#'         error_line = 2,
#'         error_record = 2:4,
#'         correct_bef_error_record = 1,
#'         val_corrected = list(3.5,1.4,0.2,'setosa'),
#'         error_col = c('petal_width'),
#'         predicted_factor = 'species')



df_load <- function(url,skip1, skip2, n_max1, n_max2, error_line, error_record, correct_bef_error_record, val_corrected, error_col, predicted_factor){
    # load and split dataset into 2
    data1 <- read_csv(url, skip = skip1, n_max = n_max1, col_types = NULL, show_col_types = FALSE)
    data2 <- read_csv(url, skip = skip2,n_max = n_max2,col_types = NULL, show_col_types = FALSE)
    
    # correct missing values
    for (i in error_record) {
        index = i - correct_bef_error_record
        data2[error_line, i] <- val_corrected[index]
    }

    # correct the datatype 
    data2 = convert_to_num(df = data2, cols = error_col)

    # combine 2 datasats splited
    data <- rbind(data1, data2)%>%mutate(!!predicted_factor := as_factor(!!sym(predicted_factor)))
    
    return(data)
 
}


