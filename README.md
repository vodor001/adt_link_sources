# odtp-component-template

This is a template that facilitates the development of new `odtp-components`. An `odtp` compatible component is a docker container able to perform a functional unit of computing in the digital twin. You can think of it as a blackbox that takes inputs files and/or parameters and perfom a task. Usually this lead to some files as a result (Ephemeral component), or to a visualization (Interactive component).

Internally a component will run a bash script `./app/app.sh` that must include the commands for running your tool, and managing the input/output logic. While input files are located in the folder `/odtp/odtp-input`, parameters values are represented by environment variables within the component. In this way you can access to them by using `$` before the name of your variable. Finally, the output files generated are requested to be placed in `/odtp/odtp-output/`.

## Internal data structure of a component

When the container is built an specific folder structure is generated:

- `/odtp`: The main folder.
- `/odtp/odtp-component-client`: This is the odtp client that will manage the execution, logging, and input/output functions of the component. It is include as a submodule, and the user doesn't need to modify it.
- `/odtp/odtp-app`: This folder have the content of `/app` folder in this template. It contains the tool execution bash script and the tool configuration files. 
- `/odtp/odtp-workdir`: This is the working directory where the tool repository should be placed and all the middle files such as cache folders.
- `/odtp/odtp-input`: Input folder that is be mounted as volume for the docker container.
- `/odtp/odtp-output`: Output folder that is mounted as volume for the docker container.
- `/odtp/odtp-logs`: Folder reserved for internal loggings. 
- `/odtp/odtp-config`: Folder reserved for odtp configuration. 

## How to create an odtp compatible component using this template?

1. Identify which parameters would you like to expose.
2. Configure the Dockerfile to install all the OS requirements needed for your tool to run. 
    1. (Optional) If your tool requires python, and the dependencies offered in the repo are not compatible with the docker image you can configure custom dependencies in requirements.txt
3. Configure the `app/app.sh` file to:
    1. Clone the repository of your tool and checkout to one specific commit. 
    2. (Optional) If your app uses a config file (i.e. `config.yml` or `config.json`), you need to provide a templace including placeholders for the variables you would like to expose. Placeholders can be defined by using double curly braces wrapping the name of the variable, such as `{{VARIABLE}}`. Then you can run `python3 /odtp/odtp-component-client/parameters.py PATH_TO_TEMPLATE PATH_TO_OUTPUT_CONFIG_FILE` and every placeholder will be replaced by the value in the environment variable.
    3. Copy (`cp -r`) or create symbolic links (`ln -s`) to locate the input files in `/odpt/odtp-input/` in the folder. 
    4. Run the tool. You can access to the parameters as environemnt variables (i.e. `$PARAMETER_A`)
    5. Manage the output exporting. At the end of the component execution all generated output should be located in `/odtp/odtp-output`. Copy all output files into this folder. 
4. Describe all the metadata in odtp.yml
5. Publish your tool in the ODTP Zoo. 

### Semantic Validation

ODTP will be able to validate the input/output files. In order to do this we use SHACL validation. However, the developer should provide a schema of the input/output schema. This section is still under development and it will be available soon. 

## Testing the component

There are 3 main ways in which you can test a component and the different odtp features. 

1. Testing it as a docker container
2. Testing it as a single component using `odtp`
3. Testing it in a `odtp` digital twin execution

When developing we recomend to start by testing the component via docker and then follow with the others.  

### Testing the component as a docker container

The user will need to manually create the input/output folders and build the docker image.

1. Prepare the following folder structure:

```
- testing-folder
    - data-input
    - data-output
```

Place all required input files in `testing-folder/data-input`.

2. Create your `.env` file with the following parameters.

```
# ODTP COMPONENT VARIABLES
PARAMETER-A=.....
PARAMETER-B=.....
```

3. Build the dockerfile. 

```
docker build -t odtp-component .
```

4. Run the following command.

```
docker run -it --rm \ 
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-input \
-v {PATH_TO_YOUR_INPUT_VOLUME}:/odtp/odtp-output \
--env-file .env \
odtp-component
```

This command will run the component. If you want debug some errors and execute the docker in an interactive manner, you can use the flag `--entrypoint bash` when running docker.

Also if your tool is interactive such as an Streamlit app, don't forget to map the ports by using `-p XXXX:XXXX`. 

### Testing the component as part of odtp

To execute the command as part of `odtp` please refer to our `odtp` documentation: 

https://odtp-org.github.io/odtp-manuals/

## Changelog

- v0.3.0
    - Turning `odtp-client` into a separate repository and adding it as a submodule in `odtp-component-client`
    - Updating `app.sh` and tutorial. 

- v0.2.0
    - Compatible with ODTP v.0.2.0 only with platform / components
    - Compatible with configuration text files
    - Improved loging system
    - Accepting Digital Twins, Executions, and steps, metadata.
    - Including component versioning in `odtp.yml` 

- v0.1.0
    - Compatible with ODTP v.0.1.0 only with platform / components
    - Compatible with configuration text files

## Development

Developed by SDSC/CSFM