#!/bin/bash

if [[ -n $CHECKPOINT_SYNC_URL ]]; then
  EXTRA_OPTS="--checkpoint-sync-url=${CHECKPOINT_SYNC_URL} --genesis-beacon-api-url=${CHECKPOINT_SYNC_URL} ${EXTRA_OPTS}"
else
  EXTRA_OPTS="--genesis-state=/genesis.ssz ${EXTRA_OPTS}"
fi

exec -c beacon-chain \
  --datadir=/data \
  --rpc-host=0.0.0.0 \
  --accept-terms-of-use \
  --chain-config-file=/config.yaml \ 
  --grpc-gateway-host=0.0.0.0 \
  --monitoring-host=0.0.0.0 \
  --p2p-tcp-port=$P2P_TCP_PORT \
  --p2p-udp-port=$P2P_UDP_PORT \
  --execution-endpoint=$HTTP_ENGINE \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain=$CORSDOMAIN \
  --jwt-secret=/jwtsecret \
  $EXTRA_OPTS
