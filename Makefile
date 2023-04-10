all: results/analysis.html results/analysis.pdf

results/analysis.html results/analysis.pdf: results/analysis.Rmd results/analysis_data/forest_fires.csv results/analysis_data/fire_train.csv results/analysis_data/fire_training_range_fire.csv results/analysis_data/fire_training_range_not_fire.csv results/analysis_data/accuracies.csv results/analysis_data/fire_test_predictions.csv results/analysis_data/correlation_graph.png results/analysis_data/scatter_plot.png results/analysis_data/line_plot.png results/analysis_data/classification_regions.png
	Rscript -e "rmarkdown::render('results/analysis.Rmd', output_dir='results/', c('bookdown::html_document2', 'bookdown::pdf_document2'))"

results/analysis_data/forest_fires.csv: R/01_data_loading.R
	Rscript R/01_data_loading.R --input_dir="data/Algerian_forest_fires_dataset_UPDATE.csv" --out_dir="results/analysis_data"

results/analysis_data/fire_test.csv results/analysis_data/fire_train.csv results/analysis_data/fire_training_mean_fire.csv results/analysis_data/fire_training_mean_not_fire.csv results/analysis_data/fire_training_range_not_fire.csv results/analysis_data/fire_training_range_fire.csv: R/02_data_processing.R results/analysis_data/forest_fires.csv
	Rscript R/02_data_processing.R --input_dir="results/analysis_data/forest_fires.csv" --out_dir="results/analysis_data"

results/analysis_data/accuracies.csv results/analysis_data/fire_test_predictions.csv results/analysis_data/prediction_table.csv: R/03_table_generation.R results/analysis_data/fire_train.csv results/analysis_data/fire_test.csv 
	Rscript R/03_table_generation.R --input_dir_load_fire_train="results/analysis_data/fire_train.csv" --input_dir_load_fire_test="results/analysis_data/fire_test.csv" --input_dir_load_forest_fire="results/analysis_data/forest_fires.csv" --out_dir="results/analysis_data"

results/analysis_data/correlation_graph.png results/analysis_data/scatter_plot.png results/analysis_data/line_plot.png results/analysis_data/classification_regions.png: R/04_data_visualization.R results/analysis_data/forest_fires.csv results/analysis_data/accuracies.csv results/analysis_data/fire_train.csv results/analysis_data/prediction_table.csv
	Rscript R/04_data_visualization.R --input_dir_load_forest_fire="results/analysis_data/forest_fires.csv" --input_dir_load_fire_train="results/analysis_data/fire_train.csv" --input_dir_load_accuracies="results/analysis_data/accuracies.csv" --input_dir_prediction_table="results/analysis_data/prediction_table.csv" --out_dir="results/analysis_data"

.PHONY: run
run:
	pwd
	docker run --rm -it --user root -p 8787:8787 -v $$(pwd):/home/rstudio -e PASSWORD="asdf" miniatureseal/dsci-310-group-10-gcc:latest

.PHONY: run_windows
run_windows:
	pwd
	docker run --rm -it --user root -p 8787:8787 -v /$$(pwd)://home//rstudio -e PASSWORD="asdf" miniatureseal/dsci-310-group-10-gcc:latest

.PHONY: test
test:
	Rscript -e "testthat::test_dir('tests/testthat')"

.PHONY: clean
clean:
	find results/ -type f ! -name '.gitkeep' ! -name 'analysis.Rmd' -delete