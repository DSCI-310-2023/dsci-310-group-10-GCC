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

1. Ensure that you have the [latest version of docker](https://docs.docker.com/get-docker/) installed. Run docker.
2. Clone the project into your local environment using `git clone https://github.com/miniatureseal/dsci-310-group-10-GCC.git` in Terminal.
3. Download the latest docker image of the project using  `docker pull miniatureseal/dsci-310-group-10-gcc:latest` in Terminal.
4. Navigate to the root directory of the project using  `cd dsci-310-group-10-GCC` in Terminal.
5. To run the container for this project, in Terminal, run
    - `make run`
    or if you use Windows and have issues running the command above try
    - `make run_windows`. Ensure that you run the command on Windows from git bash.
6. Open up the URL `localhost:8787`. You should see a login mask. Enter `rstudio` in the user field and `asdf` in the password field and press login.
7. Open up the Terminal in the bottom left panel and run `make all`. This runs the analysis and generates two output files in the folder `results/`, one is an `.html` file and the other one a `.pdf` file. Please note that this step may take some time, as libraries for the latex pdf generation need to be loaded in the background.
8. Open the preferred file in the `/results` folder and read the report.

You can freely edit and interact with the code in the docker container.

### Running the project locally

To run the project in your local environment you need to have RStudio 4.1.3 and R installed. You will need the following libraries to run everything:

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

`make test`

### Makefile details

The Makefile contains many different commands which can be run. All of the commands should be run from the root directory of the project. These three are of most interest:

- `make all`: Runs all the needed scripts to generate the final analysis file. The output reports will be generated in the `results/` folder
- `make run`: Runs the project in a docker container, so that there is no need to install all the needed dependencies. Only docker is needed! A description how docker can be installed can be found above.
- `make run_windows`: Same as `make run`, but for windows users. In some cases the `make run` command may run into issues on windows systems. In case that that happens just run this command.
- `make clean`: Deletes all files in the `results/` folder

In case that a file is missing which would be needed for the analysis you can always run:

- `make <file_name>`: This will generate the needed file with all its dependencies!

## License

The software provided in this project is offered under the MIT open source license. See the license file for more information.
