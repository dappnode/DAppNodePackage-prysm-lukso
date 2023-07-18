#!/bin/bash

VALIDATOR_PORT=3500
WEB3SIGNER_API="http://web3signer.web3signer-${NETWORK}.dappnode:9000"
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
  --validators-external-signer-url="$WEB3SIGNER_API" \
  --rpc-host 0.0.0.0 \
  --grpc-gateway-host=0.0.0.0 \
  --grpc-gateway-port="$VALIDATOR_PORT" \
  --grpc-gateway-corsdomain=http://0.0.0.0:"$VALIDATOR_PORT" \
  --graffiti="$GRAFFITI" \
  --suggested-fee-recipient="${FEE_RECIPIENT_ADDRESS}" \
  --web \
  --accept-terms-of-use \
  --enable-doppelganger \
  --verbosity $LOG_VERBOSITY \
  ${EXTRA_OPTS}