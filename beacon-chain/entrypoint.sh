#!/bin/bash

if [[ -n $CHECKPOINT_SYNC_URL ]]; then
  EXTRA_OPTS="--checkpoint-sync-url=${CHECKPOINT_SYNC_URL} --genesis-beacon-api-url=${CHECKPOINT_SYNC_URL} ${EXTRA_OPTS}"
else
  EXTRA_OPTS="--genesis-state=${GENESIS_FILE_PATH} ${EXTRA_OPTS}"
fi

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_LUKSO in
"lukso-geth.dnp.dappnode.eth")
  HTTP_ENGINE="http://lukso-geth.dappnode:8551"
  ;;
"lukso-erigon.dnp.dappnode.eth")
  HTTP_ENGINE="http://lukso-erigon.dappnode:8551"
  ;;
*)
  echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_LUKSO: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_LUKSO"
  HTTP_ENGINE=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_LUKSO
  ;;
esac

exec -c beacon-chain \
  --accept-terms-of-use \
  --datadir=/data \
  --jwt-secret=/jwtsecret \
  --chain-config-file="$CHAIN_CONFIG_FILE_PATH" \
  --execution-endpoint=$HTTP_ENGINE \
  --monitoring-host 0.0.0.0 \
  --grpc-gateway-host 0.0.0.0 \
  --grpc-gateway-port=3500 \
  --grpc-gateway-corsdomain="http://prysm.dappnode" \
  --rpc-host 0.0.0.0 \
  --verbosity $LOG_VERBOSITY \
  --p2p-tcp-port=$P2P_PORT \
  --p2p-udp-port=$P2P_PORT \
  $EXTRA_OPTS