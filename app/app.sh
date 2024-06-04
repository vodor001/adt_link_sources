#!/bin/bash

############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE HERE.
############################################################################################

#########################################################
# 1. GITHUB CLONING OF REPO
# Clone the repository of your tool and checkout to one specific commit. 
#########################################################

git clone https://github.com/vodor001/animal_digital_twin.git /odtp/odtp-workdir/adt
cd /odtp/odtp-workdir/adt
git checkout v.0.1.0

#########################################################
# 2. CONFIG FILE CONFIGURATION
# Read placeholders and create config file from Environment  
#########################################################

# python3 /odtp/odtp-component-client/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml

#########################################################
# 3. INPUT FOLDER MANAGEMENT
#########################################################

ln -s /odtp/odtp-input/data /odtp/odtp-workdir/adt/data

#########################################################
# 4. TOOL EXECUTION
# While the output is managed by ODTP and placed in /odtp/odtp-output/
#########################################################
python3 link_sources.py ./data
# COMMAND $PARAMETER_A #PARAMETER_B /odtp/odtp-input/data

#########################################################
# 5. OUTPUT FOLDER MANAGEMENT
# The selected output files generated should be placed in the output folder
#########################################################

# cp -r /odtp/odtp-workdir/adt/data /odtp/odtp-output

############################################################################################
# END OF MANUAL USER APP
############################################################################################
