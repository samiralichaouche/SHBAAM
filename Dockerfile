#*******************************************************************************
#Dockerfile
#*******************************************************************************

#Purpose:
#This file describes the operating system prerequisites for SHBAAM, and is used
#by the Docker software.
#Author:
#Cedric H. David, 2018-2018


#*******************************************************************************
#Usage
#*******************************************************************************
#docker build -t ubuntu:shbaam -f Dockerfile .           #Create image
#docker run --rm --name ubuntu_shbaam -it ubuntu:shbaam  #Run image in container
#docker save -o ubuntu_shbaam.tar ubuntu:shbaam          #Save a copy of image
#docker load -i ubuntu_shbaam.tar                        #Load a saved image


#*******************************************************************************
#Operating System
#*******************************************************************************
FROM ubuntu:trusty


#*******************************************************************************
#Copy files into Docker image (this ignores the files listed in .dockerignore)
#*******************************************************************************
WORKDIR /home/shbaam/
COPY . . 


#*******************************************************************************
#Operating System Requirements
#*******************************************************************************
RUN  apt-get update && \
     apt-get install -y $(grep -v -E '(^#|^$)' requirements.apt) && \
     rm -rf /var/lib/apt/lists/*


#*******************************************************************************
#Python requirements
#*******************************************************************************
RUN  pip install $(grep setuptools requirements.pip) && \
     pip install -r requirements.pip


#*******************************************************************************
#Intended (default) command at execution of image (not used during build)
#*******************************************************************************
CMD  /bin/bash


#*******************************************************************************
#End
#*******************************************************************************
