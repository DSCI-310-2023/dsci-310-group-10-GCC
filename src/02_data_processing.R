# This file is responsible for the test and training data split,
# as well as for some simple statistics on the training data
library(tidyverse)
library(tidymodels)
library(here)

# Set seed to ensure consistens split
options(repr.matrix.max.rows = 6)
set.seed(123)


# Load needed R function files
source(here("src/R/fire_training_fn.R"))

forest_fires <- read_csv(here("results/forest_fires.csv"))

#We don't want the date columns: our explanation will be given later!
forest_fires <- forest_fires %>%
    select(Temperature:Classes)

# we'll take 75% of the observations and place it on the training set,
# we use the prop = 0.75 argument to do this
# we also use the strata argument to set
# which column will be the prediction variable.
fire_split <- initial_split(forest_fires, prop = 0.75, strata = Classes)
fire_train <- training(fire_split)
fire_test <- testing(fire_split)

# we calculate some important values:
fire_training_range_fire <- fire_training_fn("fire", range)
fire_training_range_not_fire <- fire_training_fn("not fire", range)

#this shows the average values of the numerical columns when there is fire
fire_training_mean_fire <- fire_training_fn("fire", mean)
fire_training_mean_not_fire <- fire_training_fn("not fire", mean)

write_csv(fire_train, here("results/fire_train.csv"))
write_csv(fire_test, here("results/fire_test.csv"))

write_csv(fire_training_range_fire, here("results/fire_training_range_fire.csv"))
write_csv(fire_training_range_not_fire, here("results/fire_training_range_not_fire.csv"))
write_csv(fire_training_mean_fire, here("results/fire_training_mean_fire.csv"))
write_csv(fire_training_mean_not_fire, here("results/fire_training_mean_not_fire.csv"))