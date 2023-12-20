#!/bin/bash

############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE HERE.
############################################################################################

#########################################################
# GITHUB CLONING OF REPO
#########################################################

# Actions
# A1 - Clone github
#git clone https://github.com/odtp-org/tool-example.git /odtp/odtp-workdir/tool-example
#cd /odtp/odtp-workdir/tool-example
#git checkout 79b2889

#########################################################
# IF TOOL REQUIRES A CONFIG FILE. GENERATE IT.
# IF MULTIPLE TEMPLATES AVAILABLE ADD IF STATEMENT.
#########################################################

# A2A - Prepare parameters & Config File
# Read placeholders and create config file from Environment  
#
# Not needed as this tool does not requires a config file.
# Variables will be provided when running
# python3 /odtp/odtp-app/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml
#

#########################################################
# IF TOOL REQUIRES A DATA FOLDER, CREATE SYMBOLIC LINK
# FROM VOLUME.
#########################################################

# A2B - Prepare datafolder
#
# NOT NEEDED
# ln -s /odtp/odtp-input/... /odtp/odtp-workdir/...
#

#########################################################
# COMMAND TO RUN THE TOOL
#########################################################

# A3 - Run the tool
# While the output is managed by ODTP and placed in /odtp/odtp-output/


RUN THE TOOL COMMAND Here


# The selected output files generated should be placed in the output folder
cp -r /odtp/odtp-workdir/output/* /odtp/odtp-output

############################################################################################
# END OF MANUAL USER APP
############################################################################################
