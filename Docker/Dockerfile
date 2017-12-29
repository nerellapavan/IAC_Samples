FROM python:3.6-alpine
#Builds an image that runs Packer and also has python, pip, and AWS CLI installed.

ENV PACKER_VERSION 1.1.3

RUN apk add --update bash curl wget coreutils && rm -rf /var/cache/apk/*

#Install packer...
RUN wget -q "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    unzip -d /usr/local/bin packer_${PACKER_VERSION}_linux_amd64.zip

#Install pip and AWS CLI
RUN pip install --upgrade pip awscli

#Make utils as a workplace dir and add to your PATH
RUN mkdir /utils
ENV PATH=/utils:$PATH
RUN chmod -R 755 /utils/

##############
#The following is an example of how you could preload files and have them automatically run the packer build
ADD packer.json /utils/packer.json
#
ADD configure.sh /utils/configure.sh
##############


CMD tail -f /dev/null