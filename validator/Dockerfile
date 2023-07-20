
FROM debian:bullseye-slim as builder

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install -y wget && \
  wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/validator-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/validator && \
  chmod +x  /usr/local/bin/validator

ENV CHAIN_CONFIG_FILE_PATH /configs/mainnet/shared/config.yaml

RUN mkdir -p "$(dirname ${CHAIN_CONFIG_FILE_PATH})"

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/config.yaml -O ${CHAIN_CONFIG_FILE_PATH}

FROM debian:bullseye-slim

ENV CHAIN_CONFIG_FILE_PATH /configs/mainnet/shared/config.yaml

COPY --from=builder /configs /configs
COPY --from=builder /usr/local/bin/validator /usr/local/bin/validator

COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]