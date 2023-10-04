#!/bin/bash

#########################################################
# ODTP COMPONENT TEMPLATE
#########################################################

echo "STARTING ODTP COMPONENT"

## ODTP LOGGER in the background
if [ -v MONGODB_CLIENT ]; then
    python3 /odtp/odtp-app/logger.py >> /odtp/odtp-workdir/odtpLoggerDebugging.txt 2>&1 &
else
    echo "MONGODB_CLIENT does not exist"
fi

############################################################################################
# START OF MANUAL CONFIGURATION. 
# ADAPT THE TEMPLATE FROM HERE.
############################################################################################

#########################################################
# GITHUB CLONING OF REPO
#########################################################

# Actions
# A1 - Clone github
git clone https://github.com/eqasim-org/ile-de-france.git /odtp/odtp-workdir/scenario
cd /odtp/odtp-workdir/scenario
git checkout b8968c1

#########################################################
# IF TOOL REQUIRES A CONFIG FILE. GENERATE IT.
# IF MULTIPLE TEMPLATES AVAILABLE ADD IF STATEMENT.
#########################################################

# A2A - Prepare parameters & Config File
# Read placeholders and create config file from Environment  
python3 /odtp/odtp-app/parameters.py /odtp/odtp-app/config_templates/template.yml /odtp/odtp-workdir/config.yml

#########################################################
# IF TOOL REQUIRES A DATA FOLDER, CREATE SYMBOLIC LINK
# FROM VOLUME.
#########################################################

# A2B - Prepare datafolder
ln -s /odtp/odtp-volume/data /odtp/odtp-workdir/data

#########################################################
# COMMAND TO RUN THE TOOL
#########################################################

# A3 - Run the tool
python3 -m tool

#########################################################
# COMPRESS THE OUTPUT FOLDER GENERATED
#########################################################

#  Take output and export it
zip -r output.zip /odtp/odtp-workdir/output

############################################################################################
# END OF MANUAL CONFIGURATION
############################################################################################

#########################################################
# ODTP SNAPSHOT CREATION 
#########################################################

# Take snapshot of workdir
zip -r workdir.zip /odtp/odtp-workdir

## Placing output i back in volume just for debugging
cp output.zip /odtp/odtp-volume/output.zip
cp workdir.zip /odtp/odtp-volume/workdir.zip

## Save Snapshot in s3
mv output.zip /odtp/odtp-output/output.zip
mv workdir.zip /odtp/odtp-output/workdir.zip

if [[ -v S3_SERVER && -v MONGODB_CLIENT ]]; then
    echo "Uploading to S3_SERVER"
    python3 /odtp/odtp-app/s3uploader.py 2>&1 | tee /odtp/odtp-workdir/odtpS3UploadedDebugging.txt  
else
    echo "S3_SERVER does not exist"
fi

## Copying logs
cp /odtp/odtp-workdir/log.txt /odtp/odtp-volume/log.txt


if [ -v MONGODB_CLIENT ]; then
    cp /odtp/odtp-workdir/odtpLoggerDebugging.txt /odtp/odtp-volume/odtpLoggerDebugging.txt
else
    echo "MONGODB_CLIENT doesn't exist. Not copying log files."
fi

if [[ -v S3_SERVER && -v MONGODB_CLIENT ]]; then
    cp /odtp/odtp-workdir/odtpS3UploadedDebugging.txt /odtp/odtp-volume/odtpS3UploadedDebugging.txt
else
    echo "S3_SERVER doesn't exist. Not copying log files."
fi