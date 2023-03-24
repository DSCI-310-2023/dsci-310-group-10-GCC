FROM --platform=linux/x86_64 rocker/verse:4.2.0

WORKDIR /home/rstudio

# you can use remotes::install_version() as well instead of using renv

COPY --chown=rstudio:rstudio renv.lock .
COPY --chown=rstudio:rstudio renv renv
COPY --chown=rstudio:rstudio .Rprofile .

RUN mkdir dsci_project

USER rstudio
RUN Rscript -e "renv::restore()"
USER root