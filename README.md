# odtp-component-template
This is a template that facilitates the development of new odtp-components

Please follow the next steps to adapt your tool. 

## Use of the template

Depending on the type of tool you may want to follow one of these procedure.

### Scripts in a repository (or tool under development)

1. Identify which parameters would you like to expose. 
3. Configure the Dockerfile to pull your repo and install all needed dependencies.
4. Configure dependencies in requirements.txt if the dependencies offered in the repo are not compatible with the docker image.
5. Configure the app/app.sh file to run the tool
6. (Optional) Make use of config_templates if your tool requires the generation of a config file. 
7. Describe all the metadata in odtp.yml
8. Publish your tool in the ODTP Zoo. 

### Tool published in PIP/Conda/R

TO BE DONE

### Adding Semantic Context.

TO BE DONE

## Testing the component. 

This component can be tested in isolation with the following instructions.

1. Prepare manually a folder called volume containing the input files/folder needed:

2. Create your `.env` file with the parameters. **If you do not have MONGODB and/or S3 activated omit this step, and just provide the scenario as environmental variable.**

```
PARAMETER_A=A
PARAMETER_B=B
MONGODB_CLIENT=mongodb://.....
S3_SERVER=https://....
S3_ACCESS_KEY=Q0ISQ....
S3_SECRET_KEY=OoPthI....
S3_BUCKET_NAME=13301....
```

3. Build the dockerfile. **PLEASE MODIFY THE NAME OF THE TOOL**

```
docker build -t odtp-app .
```

4. Run the following command. **PLEASE MODIFY THE NAME OF THE TOOL**

```
docker run -it --rm -v {PATH_TO_YOUR_VOLUME}:/odtp/odtp-volume --env-file .env odtp-app
```

## Changelog

- v.0.2.0
    - Compatible with ODTP v.0.2.0 only with platform / components
    - Compatible with configuration text files
    - Improved loging system
    - Accepting Digital Twins, Executions, and steps, metadata.
    - Including component versioning in `odtp.yml` 

- v.0.1.0
    - Compatible with ODTP v.0.1.0 only with platform / components
    - Compatible with configuration text files

## Development

Developed by SDSC/CSFM