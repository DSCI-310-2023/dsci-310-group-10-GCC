forest_fires.csv: src/01_data_loading.R
	Rscript src/01_data_loading.R

fire_test.csv fore_train.csv fire_training_mean_fire.csv fire_training_mean_not_fire.csv fire_training_range_not_fire.csv fire_training_range_fire.csv: src/02_data_processing.R
	Rscript src/02_data_processing.R