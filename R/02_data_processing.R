# This file is responsible for the test and training data split,
# as well as for some simple statistics on the training data
library(tidyverse)
library(tidymodels)
library(here)
library(docopt)

# Set seed to ensure consistens split
options(repr.matrix.max.rows = 6)
set.seed(123)

doc <- "
Loads forest fire data from given input directory input_dir, cleans it,
and puts it into output directory output_dir

Usage: src/02_data_processing.R --input_dir=<input_dir>  --out_dir=<output_dir>

Options:
--input_dir=<input_dir>		Relative path to project root (including filename)
to raw data
--out_dir=<output_dir>		Path to directory relative to project root
where the results should be saved
"

opt <- docopt(doc)
input_dir <- opt[["--input_dir"]]
output_dir <- opt[["--out_dir"]]

# Load needed R function files
library(FFire)
forest_fires <- read_csv(here(input_dir))

# We don't want the date columns: our explanation will be given later!
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
fire_training_range_fire <- filter_data(
  fire_train, Classes, "fire",
  Temperature, FWI, range
)
fire_training_range_not_fire <- filter_data(
  fire_train, Classes, "not fire",
  Temperature, FWI, range
)

# this shows the average values of the numerical columns when there is fire
fire_training_mean_fire <- filter_data(
  fire_train, Classes, "fire",
  Temperature, FWI, mean
)
fire_training_mean_not_fire <- filter_data(
  fire_train, Classes, "not fire",
  Temperature, FWI, mean
)

write_csv(fire_train, here(output_dir, "fire_train.csv"))
write_csv(fire_test, here(output_dir, "fire_test.csv"))

write_csv(
  fire_training_range_fire,
  here(output_dir, "fire_training_range_fire.csv")
)
write_csv(
  fire_training_range_not_fire,
  here(output_dir, "fire_training_range_not_fire.csv")
)
write_csv(
  fire_training_mean_fire,
  here(output_dir, "fire_training_mean_fire.csv")
)
write_csv(
  fire_training_mean_not_fire,
  here(output_dir, "fire_training_mean_not_fire.csv")
)
