ARG UPSTREAM_VERSION

FROM alpine:3.18.2 as builder

RUN apk update && apk add --no-cache wget

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/prysm.yaml -O /config/config.yaml
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/genesis_42.json -O /config/genesis.ssz

FROM prysmaticlabs/prysm-beacon-chain:${UPSTREAM_VERSION}

COPY --from=builder /config /config

COPY jwtsecret.hex /jwtsecret
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
