FROM debian:bullseye-slim as builder

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install -y wget && \
  wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/beacon-chain && \
  chmod +x  /usr/local/bin/beacon-chain

ENV LUKSO_CONFIG_PATH /configs/mainnet
ENV GENESIS_FILE_PATH ${LUKSO_CONFIG_PATH}/shared/genesis.ssz
ENV CHAIN_CONFIG_FILE_PATH ${LUKSO_CONFIG_PATH}/shared/config.yaml

RUN mkdir -p ${LUKSO_CONFIG_PATH}/prysm && \
  mkdir -p ${LUKSO_CONFIG_PATH}/shared

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/genesis.ssz -O ${GENESIS_FILE_PATH}
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/config.yaml -O ${CHAIN_CONFIG_FILE_PATH}

FROM debian:bullseye-slim

ENV GENESIS_FILE_PATH /configs/mainnet/shared/genesis.ssz
ENV CHAIN_CONFIG_FILE_PATH /configs/mainnet/shared/config.yaml

RUN apt update && apt install ca-certificates -y

COPY --from=builder /configs /configs
COPY --from=builder /usr/local/bin/beacon-chain /usr/local/bin/beacon-chain

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
