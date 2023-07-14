ARG UPSTREAM_VERSION

FROM prysmaticlabs/prysm-validator:${UPSTREAM_VERSION}

COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apt update && apt install -y wget 
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/validator.yaml -O /config/config.yaml

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]