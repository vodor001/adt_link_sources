# ODTP Component Template
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

# Acknowledgments, Copyright, and Licensing
## Acknowledgments and Funding
This work is part of the broader project **O**pen **D**igital **T**win **P**latform of the **S**wiss **M**obility **S**ystem (ODTP-SMS) funded by Swissuniversities CHORD grant Track B - Establish Projects. ODTP-SMS project is a joint endeavour by the Center for Sustainable Future Mobility - CSFM (ETH Zürich) and the Swiss Data Science Center - SDSC (EPFL and ETH Zürich). 
The Swiss Data Science Center (SDSC) develops domain-agnostic standards and containerized components to manage digital twins. This includes the creation of the Core Platform (both back-end and front-end), Service Component Integration Templates, Component Ontology, and the Component Zoo template. 
The Center for Sustainable Future Mobility (CSFM) develops mobility services and utilizes the components produced by SDSC to deploy a mobility digital twin platform. CSFM focuses on integrating mobility services and collecting available components in the mobility zoo, thereby applying the digital twin concept in the realm of mobility.
 
## Copyright
Copyright © 2023-2024 Swiss Data Science Center (SDSC), www.datascience.ch. All rights reserved.
The SDSC is jointly established and legally represented by the École Polytechnique Fédérale de Lausanne (EPFL) and the Eidgenössische Technische Hochschule Zürich (ETH Zürich). This copyright encompasses all materials, software, documentation, and other content created and developed by the SDSC.

## Intellectual Property (IP) Rights
The Open Digital Twin Platform (ODTP) is the result of a collaborative effort between ETH Zurich (ETHZ) and the École Polytechnique Fédérale de Lausanne (EPFL). Both institutions hold equal intellectual property rights for the ODTP project, reflecting the equitable and shared contributions of EPFL and ETH Zürich in the development and advancement of this initiative.  
 
## Licensing
The Service Component Integration Templates within this repository are licensed under the BSD 3-Clause "New" or "Revised" License. This license allows for broad compatibility and standardization, encouraging open use and contribution. For the full license text, please see the LICENSE file accompanying these templates.

### Distinct Licensing for Other Components
- **Core Platform**: Open-source under AGPLv3.
- **Ontology**: Creative Commons Attribution-ShareAlike (CC BY-SA).
- **Component Zoo Template**: BSD-3 license.

### Alternative Commercial Licensing
Alternative commercial licensing options for the core platform and other components are available and can be negotiated through the EPFL Technology Transfer Office (https://tto.epfl.ch) or ETH Zürich Technology Transfer Office (https://ethz.ch/en/industry/transfer.html).

## Ethical Use and Legal Compliance Disclaimer
Please note that this software should not be used to deliberately harm any individual or entity. Users and developers must adhere to ethical guidelines and use the software responsibly and legally. This disclaimer serves to remind all parties involved in the use or development of this software to engage in practices that are ethical, lawful, and in accordance with the intended purpose of the software.
