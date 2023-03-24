forest_fires.csv: src/01_data_loading.R
	Rscript src/01_data_loading.R

fire_test.csv fore_train.csv fire_training_mean_fire.csv fire_training_mean_not_fire.csv fire_training_range_not_fire.csv fire_training_range_fire.csv: src/02_data_processing.R
	Rscript src/02_data_processing.R

correlation_graph.png scatter_plot.png line_plot.png: fire_train.csv fire_test.csv 
	Rscript src/03_data_visualization.R

fire_test_predictions.csv classification_regions.png accuracies.csv:forest_fires.csv
	Rscript src/04_data_conclusion.R

.PHONY: rstudio
rstudio:
	docker run -p 8787:8787 -e PASSWORD="asdf" -v .:/home/rstudio/my_project rocker/rstudio:4.1.3

.PHONY: clean
clean:
	rm -rf results