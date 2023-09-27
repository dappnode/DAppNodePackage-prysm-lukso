#!/bin/bash

WALLET_DIR="/root/.eth2validators"

# Copy auth-token in runtime to the prysm token dir
mkdir -p ${WALLET_DIR}
cp /auth-token ${WALLET_DIR}/auth-token

exec -c validator \
  --datadir=/data \
  --wallet-dir="$WALLET_DIR" \
  --chain-config-file="$CHAIN_CONFIG_FILE_PATH" \
  --monitoring-host 0.0.0.0 \
  --beacon-rpc-provider="beacon-chain.prysm-lukso.dappnode:4000" \
  --beacon-rpc-gateway-provider="beacon-chain.prysm-lukso.dappnode:3500" \
  --validators-external-signer-url="http://web3signer.web3signer-lukso.dappnode:9000" \
  --grpc-gateway-host=0.0.0.0 \
  --web \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain=http://0.0.0.0:3500 \
  --graffiti="$GRAFFITI" \
  --accept-terms-of-use \
  --verbosity $LOG_VERBOSITY \
  --enable-doppelganger \
  ${EXTRA_OPTS}
