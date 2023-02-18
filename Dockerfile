FROM jupyter/r-notebook:latest

RUN Rscript -e "install.packages('remotes', repos='http://cran.us.r-project.org')"

RUN Rscript -e "remotes::install_version('dplyr', '1.1.0', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('forcats', '1.0.0', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('readr', '2.1.4', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('purrr', '1.0.1', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('rsample', '1.1.1', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('GGally', '2.1.2', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('RColorBrewer', '1.1.3', repos = 'http://cran.us.r-project.org')"