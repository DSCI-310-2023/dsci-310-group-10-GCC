library(tidyverse)
library(here)


options(repr.matrix.max.rows = 6)

set.seed(123)

# R functions
source(here("src/R/convert_to_num.R"))
source(here("src/R/df_load.R"))
source(here("src/R/plot_fn.R"))
source(here("src/R/fire_training_fn.R"))

# Packages
packageVersion("tidyverse")
packageVersion("GGally")
packageVersion("tidymodels")
packageVersion("here")
packageVersion("testthat")
packageVersion("kknn")

class(Inf)

# Loading URL
forest_fires <- df_load(url =
                        here("data/Algerian_forest_fires_dataset_UPDATE.csv"),
                        skip1 = as.integer(1),
                        skip2 = as.integer(126),
                        n_max1 = 122,
                        n_max2 = Inf,
                        error_line = as.integer(44),
                        error_record = 10:14,
                        correct_bef_error_record = as.integer(9),
                        val_corrected = list("14.6", 9, 12.5, "10.4", "fire"),
                        error_col = c("DC", "FWI"),
                        predicted_factor = "Classes")

head(forest_fires)
write_csv(forest_fires, here("results/forest_fires.csv"))