# dsci-310-group-10-GCC

## Contributors

- [Jan Zimny](https://github.com/miniatureseal)
- [Jinghan Xu](https://github.com/jh22d)
- [Zicheng Zhao](https://github.com/Rz02)

Team Contract: "https://docs.google.com/document/d/1mg8IGLf3wtWFVM-_ZApg03Z35te-7wXVeA3zK4PfNCk/edit#heading=h.kwgdq5on8tby"

## Short project summary

Forest fires are a type of uncontrolled and unwanted fires that usually have a negative impact. In 2007, forest fires in the Atlas Mountains, located on the northern coast of Algeria, killed several people as they spread rapidly due to hot, dry winds.

In this project, the main question which we want to answer is:
Can we predict forest fires given the weather conditions by using k-nearest neighbours?

For the DSCI310 project which is based on this previous project created in DSCI100, we intend to realize trustworthy and reproductive workflows
according to the lectures' content and any extra relevant resources.

## How to run the project

### Running the project via docker

To run the project in docker, follow the steps below:

1. Ensure that you have the [latest version of docker](https://docs.docker.com/get-docker/) installed.
2. Clone the project into your local environment using `git clone https://github.com/miniatureseal/dsci-310-group-10-GCC.git` in Terminal.
3. Download the latest docker image of the project using  `docker pull miniatureseal/dsci-310-group-10-gcc:latest` in Termianl.
4. Navigate to the root directory of the project using  `cd dsci-310-group-10-GCC` in Terminal.
5. To run the container for this project, in Terminal, run
    - `make run`
    or if you use Windows and have issues running the command above try
    - `make run_windows`. Ensure that you run the command on Windows from git bash.
6. Open up the URL `localhost:8787` in your browser and enter `rstudio` in the user field and `asdf` in the password field.
7. Now, in the RStudio web application, use the bottom righ panel and navigate into the folder `dsci_project`.
8. Open up the terminal in the bottom left panel and run `make all`. This runs the analysis and generates two output files in the folder `results/`, one is an `.html` file and the other one a `.pdf` file.
9. Open the preferred file and read the report.

You can freely edit and interact with the code in the docker container.

### Running the project locally

To run the project in your local environment you need to have RStudio 4.1.3 and R installed. You will need the following libraries to run the scripts locally:

- tidyverse ‘1.3.1’
- tidymodels ‘1.0.0’
- bookdown ‘0.27’
- markdown ‘1.5’
- kknn ‘1.3.1’
- GGally ‘2.1.2’
- here ‘1.0.1’
- testthat ‘3.1.4’
- docopt ‘0.7.1’
- knitr ‘1.39’

If you are running windows, ensure that you have git bash installed.

You can install RStudio from [here](https://posit.co/download/rstudio-desktop/).

If you have the above packages installed, just run `make all` from the root directory of the project.

The make command generates two output files in the folder `results/`, one is an `.html` file and the other one a `.pdf` file.

### Running the test suite

The test suite can be run by running the following command from the root directory of the project:

`Rscript -e "testthat::test_dir('tests/testthat')"`

## License

The software provided in this project is offered under the MIT open source license. See the license file for more information.
