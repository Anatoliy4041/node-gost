FROM node:8

RUN apt-get update && \
    apt-get install lsb-core -y

RUN mkdir -p /csp-4.0
WORKDIR /csp-4.0
ADD csp-4.0/ /csp-4.0 

RUN dpkg -i cprocsp-cpopenssl-64_4.0.0-4_amd64.deb
RUN dpkg -i cprocsp-cpopenssl-base_4.0.0-4_all.deb
RUN dpkg -i cprocsp-cpopenssl-devel_4.0.0-4_all.deb

RUN dpkg -i lsb-cprocsp-base_4.0.0-4_all.deb
RUN dpkg -i lsb-cprocsp-rdr-64_4.0.0-4_amd64.deb
RUN dpkg -i lsb-cprocsp-capilite-64_4.0.0-4_amd64.deb
RUN dpkg -i lsb-cprocsp-kc2-64_4.0.0-4_amd64.deb

RUN dpkg -i cprocsp-curl-64_4.0.0-4_amd64.deb
RUN dpkg -i cprocsp-cpopenssl-gost-64_4.0.0-4_amd64.deb

ADD https://github.com/ethereum/solidity/releases/download/v0.4.14/solc-static-linux /usr/bin/
ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/bin/jq
RUN chmod +x /usr/bin/solc-static-linux /usr/bin/jq
