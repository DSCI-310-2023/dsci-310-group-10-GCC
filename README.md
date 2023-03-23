# dsci-310-group-10-GCC

## Contributors
- [Jan Zimny](https://github.com/miniatureseal)
- [Jinghan Xu](https://github.com/jh22d)
- [Zicheng Zhao](https://github.com/Rz02)

Team Contract: "https://docs.google.com/document/d/1mg8IGLf3wtWFVM-_ZApg03Z35te-7wXVeA3zK4PfNCk/edit#heading=h.kwgdq5on8tby"


## Short project summary

Forest fires are a type of uncontrolled and unwanted fire that usually have a negative impact. In 2007, forest fires in the Atlas Mountains, located on the northern coast of Algeria, killed several people as it spread rapidly due to hot, dry winds.

In this project, the main question which we want to answer is:
Can we predict forest fires given the weather conditions by using k-nearest neighbours?

For the DSCI310 project which is based on this previous project created in DSCI100, we intend to realize trustworthy and reproductive workflows
according to the lectures' content and any extra relevant resources.


## How to run the project

### Running the project via docker
To run the project in docker, follow the steps below:
1. Ensure that you have the [latest version of docker](https://docs.docker.com/get-docker/) installed. 
2. Clone the project into your local environment using `git clone https://github.com/miniatureseal/dsci-310-group-10-GCC.git` in terminal.
3. Download the latest docker image of the project using  `docker pull miniatureseal/dsci-310-group-10-gcc:latest` in termianl.
4. Navigate to the root directory of the project using  `cd dsci-310-group-10-GCC` in terminal.
5. To run the container for this project, in terminal, run 
    -  `docker run --rm -it --user root -v $(pwd):/home/jovyan/work -p 8888:8888 miniatureseal/dsci-310-group-10-gcc` on unix based systems or mac 
    or  
    -  `docker run --rm -it --user root -v /$(pwd)://home//jovyan//work -p 8888:8888 miniatureseal/dsci-310-group-10-gcc` on windows. Ensure that you run the command in windows from git bash.
6. See the running message which automatically generated in terminal from the command above. Follow the instructions at the end of the message below the section *To access the server, open this file in a browser:*, i.e., copy a given URL into the browser and navigate to the container.
7. In teh browser, go to `/work/forest_fire_prediction.ipynb` and run the notebook.

You can freely edit and interact with the notebook.


### Dependencies
To run the project in your local environment you need to have RStudio 4.1.3 and R installed. The specific versions for the required packages can be found in [environment.yml](https://github.com/miniatureseal/dsci-310-group-10-GCC/blob/main/environment.yml)
If you are running windows, ensure that you have git bash installed.

You can install RStudio from [here](https://posit.co/download/rstudio-desktop/).

In addition you also need to install jupyter notebook. For instructions have a look into the following [link](https://docs.jupyter.org/en/latest/install/notebook-classic.html)

Now start jupyter notebook, navigate to the `forest_fire_prediction.ipynb` file and run it.
If the steps above were followed as described the notebook should run without any issues.

## License
The software provided in this project is offered under the MIT open source license. See the license file for more information.
