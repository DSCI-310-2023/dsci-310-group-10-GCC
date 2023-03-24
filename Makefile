rmd: results/final_docs/analysis.html results/final_docs/analysis.pdf

results/final_docs/analysis.html results/final_docs/analysis.pdf: src/analysis.Rmd results/forest_fires.csv results/fire_train.csv results/fire_training_range_fire.csv results/fire_training_range_not_fire.csv results/accuracies.csv results/fire_test_predictions.csv results/correlation_graph.png results/scatter_plot.png results/line_plot.png results/classification_regions.png
	Rscript -e "rmarkdown::render('src/analysis.Rmd', output_dir='results/final_docs', c('bookdown::html_document2', 'bookdown::pdf_document2'))"

results/forest_fires.csv: src/01_data_loading.R
	Rscript src/01_data_loading.R --input_dir="data/Algerian_forest_fires_dataset_UPDATE.csv" --out_dir="results"

results/fire_test.csv results/fire_train.csv results/fire_training_mean_fire.csv results/fire_training_mean_not_fire.csv results/fire_training_range_not_fire.csv results/fire_training_range_fire.csv: src/02_data_processing.R results/forest_fires.csv
	Rscript src/02_data_processing.R

results/accuracies.csv results/fire_test_predictions.csv results/prediction_table.csv: results/fire_train.csv results/fire_test.csv 
	Rscript src/03_table_generation.R

results/correlation_graph.png results/scatter_plot.png results/line_plot.png results/classification_regions.png: results/forest_fires.csv results/accuracies.csv results/fire_train.csv results/prediction_table.csv
	Rscript src/04_data_visualization.R

.PHONY: run
run:
	pwd
	docker run --rm -it --user root -p 8787:8787 -v $$(pwd):/home/rstudio -e PASSWORD="asdf" miniatureseal/dsci-310-group-10-gcc:latest

.PHONY: run_windows
run_windows:
	pwd
	docker run --rm -it --user root -p 8787:8787 -v /$$(pwd)://home//rstudio -e PASSWORD="asdf" miniatureseal/dsci-310-group-10-gcc:latest

.PHONY: clean
clean:
	find results/ -type f ! -name '.gitkeep' -delete