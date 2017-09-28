FROM nodesource/node:8

ADD https://github.com/ethereum/solidity/releases/download/v0.4.14/solc-static-linux /usr/bin/
ADD https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 /usr/bin/jq
RUN chmod +x /usr/bin/solc-static-linux /usr/bin/jq
