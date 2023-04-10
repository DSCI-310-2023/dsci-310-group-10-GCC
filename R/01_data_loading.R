library(tidyverse)
library(here)
library(docopt)

doc <- "
Loads forest fire data from given input directory input_dir, cleans it,
and puts it into output directory output_dir

Usage: src/01_data_loading.R --input_dir=<input_dir>  --out_dir=<output_dir>

Options:
--input_dir=<input_dir>		Relative path to project root (including filename)
to raw data
--out_dir=<output_dir>		Path to directory relative to project root
where the results should be saved
"

opt <- docopt(doc)
input_dir <- opt[["--input_dir"]]
output_dir <- opt[["--out_dir"]]

# Loading Package
library(FFire)

# Loading URL
forest_fires <- df_load(
  url =
    here(input_dir),
  skip1 = as.integer(1),
  skip2 = as.integer(126),
  n_max1 = 122,
  n_max2 = Inf,
  error_line = as.integer(44),
  error_record = 10:14,
  correct_bef_error_record = as.integer(9),
  val_corrected = list("14.6", 9, 12.5, "10.4", "fire"),
  error_col = c("DC", "FWI"),
  predicted_factor = "Classes"
)

write_csv(forest_fires, here(output_dir, "forest_fires.csv"))
