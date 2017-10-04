FROM ubuntu:xenial
USER root

RUN apt-get update
RUN apt-get upgrade -q -y
RUN apt-get dist-upgrade -q -y
RUN apt-get install -y sudo
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN add-apt-repository ppa:ethereum/ethereum-dev
RUN apt-get update
RUN apt-get -y install ethereum solc 
RUN apt-get install -y python-pip python-dev libyaml-dev libssl-dev
RUN apt-get install -y curl
RUN apt-get install -y git
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
RUN apt-get install -y nodejs

WORKDIR /tmp
RUN git clone https://github.com/ethereumjs/testrpc.git
WORKDIR /tmp/testrpc
RUN npm install -g .

 # Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8545

CMD testrpc --domain=0.0.0.0 --accounts 100 --gasLimit 0x7A1200 console