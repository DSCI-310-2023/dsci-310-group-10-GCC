This is a folder keeping all the analytical code for this project.

In this project, we particularly use R to conduct the analysis. 

In this directory,

- 'R/' is a folder which contains all the refactored codes and the testing code.

- 'forest_fire_prediction.ipynb' is with with an R Kernel and it executes the main analysis.

- 'analysis.Rmd' generates the report of the project including the necessary tabels and graphs only. It depends on '01_data_loading.R', '02_data_processing.R', '03_data_visualization.R' and '04_data_conclusion.R'. All the required files to generate the report are integrated by Makefile in the lsat directory.

- '01_data_loading.R', '02_data_processing.R', '03_data_visualization.R' and '04_data_conclusion.R' are successive code for the analysis in order.
