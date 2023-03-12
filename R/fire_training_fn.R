library(dplyr)
library(purrr)

#' Fire Training Function
#'
#' This function gives a data table depends on the calculation format
#' (e.g. mean, range, etc.) and the used dataset (e.g. fire_train)
#'
#' @param subset The filtering condition which the targeted function
#' should follow.
#'
#' @param alg    The filtering algorithm which the targeted function
#' should follow.
#' @return Return the data filtered by the parameters above.
fire_training_fn <- function(subset, alg) {
    fire_training <- fire_train %>%
        filter(Classes == subset) %>%
        select(Temperature:FWI) %>%
        map_df(alg)
    return(fire_training)
}
