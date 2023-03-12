#' convert_to_num:
#'
#' Converts columns that can be coerced to numeric type in a data frame to numeric type.
#'
#' @param df The dataframe containing columns to be converted
#' @param cols A vector of column names to be converted to numeric type
#'
#' @return A dataframe containing converted numeric columns
#'
#' @export
#'
#' @example
#' df1 = data.frame(c_to_n = c('1','2'))
#' convert_to_num(df1, 'c_to_n')



convert_to_num <- function(df, cols){
    for (col in cols){
        df[[col]] <- as.numeric(df[[col]])
    }
    return(df)
}
