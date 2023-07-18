
FROM debian:bullseye-slim as builder

ARG TARGETARCH
ARG UPSTREAM_VERSION
ENV DOWNLOAD_URL https://github.com/prysmaticlabs/prysm/releases/download

RUN DEBIAN_FRONTEND=noninteractive \
  apt update && apt install -y wget && \
  wget -q ${DOWNLOAD_URL}/${UPSTREAM_VERSION}/validator-${UPSTREAM_VERSION}-linux-${TARGETARCH:-amd64} -O /usr/local/bin/validator && \
  chmod +x  /usr/local/bin/validator

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/validator.yaml -O /config/config.yaml

FROM debian:bullseye-slim

COPY --from=builder /config /config
COPY --from=builder /usr/local/bin/validator /usr/local/bin/validator

COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]