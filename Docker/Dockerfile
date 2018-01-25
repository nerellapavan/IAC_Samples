FROM ubuntu:16.04

RUN  apt-get update && apt-get install -y python3-pip wget zip unzip vim

ENV PACKER_VERSION 1.1.3

RUN wget -q "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    unzip -d /usr/local/bin packer_${PACKER_VERSION}_linux_amd64.zip

RUN mkdir /utils

ENV PATH=/utils:$PATH

COPY ./packer.json /utils/
COPY ./configure.sh /utils/


RUN chmod -R 755 /utils/

CMD ["tail",  "-f", "/dev/null"]