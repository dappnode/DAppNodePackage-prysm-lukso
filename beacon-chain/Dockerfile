ARG UPSTREAM_VERSION

FROM prysmaticlabs/prysm-beacon-chain:${UPSTREAM_VERSION}

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && apt install -y wget 
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/prysm.yaml -O /config/config.yaml
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/genesis_42.json -O /config/genesis.ssz

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

