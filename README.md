# dsci-310-group-10-GCC

## Contributors
- [miniatureseal](https://github.com/miniatureseal)
- [jh22d](https://github.com/jh22d)
- [Rz02](https://github.com/Rz02)

Team Contract: "https://docs.google.com/document/d/1mg8IGLf3wtWFVM-_ZApg03Z35te-7wXVeA3zK4PfNCk/edit#heading=h.kwgdq5on8tby"

## Short project summary

Forest fires are a type of uncontrolled and unwanted fire that usually have a negative impact. 
In 2007, forest fires in the Atlas Mountains, located on the northern coast of Algeria, killed several people as it spread rapidly due to hot, dry winds.

In this project, `the problem we're willing to solve` is:
- Can we predict forest fires given the weather conditions by using $k$ nearest neighbours? 

For DSCI310 project which based on this previous project created in DSCI100, we intend to realize trustworthy and reproducive workflows
according to the lectures' content and any extra relevant resource.


## How to run the project

### Running the project via docker
To run the project in docker ensure that you have the latests version of docker installed. 
Clone the project into your local environment using 
`git clone https://github.com/miniatureseal/dsci-310-group-10-GCC.git`

Download the latest docker image of the project using 
`docker pull miniatureseal/dsci-310-group-10-GCC`

Then naviagte to the root directory of the project and run
`docker run --r--user root -v $(pwd):/home/jovyan/work -p 8888:8888 dsci-310-group-10-gcc`

Navigate to `/work/forest_fire_prediction.ipynb` and run the notebook.


### Running the project in the local environment
To run the project in your local environment you need to have RStudio and R installed. You will need to install the following packages with the specified versions to run it:
- `plyr`: 1.1.0
- `forcats`: 1.0.0
- `readr`: 2.1.4
- `GGally`: 2.1.2
- `purrr`: 1.0.1
- `rsample`: 1.1.1
- `RColorBrewer`: 1.1.3

For example you can install RStudio from here: https://posit.co/download/rstudio-desktop/
In addition you also need to install jupyter notebook. For instructions have a look into the following link:
https://docs.jupyter.org/en/latest/install/notebook-classic.html

Now start jupyter notebook, navigate to the `forest_fire_prediction.ipynb` file and run it.
If the steps above were followed as described the notebook should run without any issues.

## License
This project is licensed under the MIT license.
