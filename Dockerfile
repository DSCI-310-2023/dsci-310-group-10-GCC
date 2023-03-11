FROM jupyter/r-notebook:latest

RUN Rscript -e "install.packages('remotes', repos='http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('GGally', '2.1.2', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('testthat', '3.1.6', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('here', '1.0.1', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "remotes::install_version('kknn', '1.3.1', repos = 'http://cran.us.r-project.org')"