FROM debian:bullseye-slim as builder

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install -y wget && \
  wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/beacon-chain-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/beacon-chain && \
  chmod +x  /usr/local/bin/beacon-chain

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/prysm.yaml -O /config/config.yaml
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/genesis_42.json -O /config/genesis.ssz

FROM debian:bullseye-slim

COPY --from=builder /config /config
COPY --from=builder /usr/local/bin/beacon-chain /usr/local/bin/beacon-chain

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
