ARG UPSTREAM_VERSION

FROM alpine:3.18.2 as builder

RUN apk update && apk add --no-cache wget

RUN mkdir -p /config

# Get Lukso config and genesis for Prysm
RUN wget https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/prysm/validator.yaml -O /config/config.yaml

FROM prysmaticlabs/prysm-validator:${UPSTREAM_VERSION}

COPY --from=builder /config /config
COPY auth-token /auth-token
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]