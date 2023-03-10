library(dplyr)
library(forcats)
library(readr)
library(GGally)
library(purrr)
library(rsample)
library(RColorBrewer)
library(recipes)
library(parsnip)
library(tune)
library(workflows)
library(yardstick)
library(here)

options(repr.matrix.max.rows = 6)

set.seed(123)

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

# Copy the dataset from ipynb file for testing
fire_url <- "data/Algerian_forest_fires_dataset_UPDATE.csv"
# this takes the bajaja region
forest_fire_bejaia <- read_csv(fire_url, skip = 1, n_max = 122)
# this takes the sidi region
forest_fire_sidi <- read_csv(fire_url, skip = 126)

forest_fire_sidi[44, 10] <- "14.6"
forest_fire_sidi[44, 11] <- 9
forest_fire_sidi[44, 12] <- 12.5
forest_fire_sidi[44, 13] <- "10.4"
forest_fire_sidi[44, 14] <- "fire"

# because of the parsing error, these columns were saved as
# <chr> instead of <dbl>. We need to change it back:
forest_fire_sidi <-  forest_fire_sidi %>%
    mutate(DC = as.numeric(DC)) %>%
    mutate(FWI = as.numeric(FWI))

#combine both datasets together:
forest_fires <- rbind(forest_fire_sidi, forest_fire_bejaia)

#change Classes into a factor because it's the one we want to predict
forest_fires <- forest_fires %>%
    mutate(Classes = as_factor(Classes))

set.seed(123)
#We don't want the date columns: our explanation will be given later!
forest_fires <- forest_fires %>%
    select(Temperature:Classes)

# we'll take 75% of the observations and place it on the training set,
#    we use the prop = 0.75 argument to do this
# we also use the strata argument to set which column will be the
# prediction variable.

fire_split <- initial_split(forest_fires, prop = 0.75, strata = Classes)
fire_train <- training(fire_split)

# Testing
library(testthat)
testthat::expect_equal(nrow(fire_training_fn("fire", range)), 2)
testthat::expect_equal(nrow(fire_training_fn("fire", mean)), 1)