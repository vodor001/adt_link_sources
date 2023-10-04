FROM ubuntu:latest

RUN apt update
RUN apt install python3 python3-pip -y

##################################################
# Ubuntu setup
##################################################

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    unzip \
    nano \
    git \ 
    g++ \
    gcc \
    htop \
    zip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

##################################################
# ODTP setup
##################################################

COPY odtp.requirements.txt /tmp/odtp.requirements.txt
RUN pip install -r /tmp/odtp.requirements.txt


#######################################################################
# PLEASE INSTALL HERE ALL SYSTEM DEPENDENCIES RELATED TO YOUR TOOL
#######################################################################




######################################################################
# ODTP COMPONENT CONFIGURATION. 
# DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING.
######################################################################

##################################################
# ODTP Preparation
##################################################

RUN mkdir /odtp \
    /odtp/odtp-config \
    /odtp/odtp-app \
    /odtp/odtp-volume \
    /odtp/odtp-workdir \
    /odtp/odtp-output 

# This last 2 folders are specific from odtp-eqasim
RUN mkdir /odtp/odtp-workdir/cache \
    /odtp/odtp-workdir/output 

# This copy all the information for running the ODTP component
COPY odtp.yml /odtp/odtp-config/odtp.yml

COPY ./app /odtp/odtp-app
WORKDIR /odtp
## How to share the config file as user? Maybe placing in volume? 
ENTRYPOINT ["bash", "/odtp/odtp-app/startup.sh"]