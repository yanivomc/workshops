#!/bin/bash
set -eo pipefail
shopt -s nullglob

#envconsul -no-prefix -vault-token $(cat $VAULT_TOKEN_PATH) -vault-addr=$VAULT_ADDR -log-level debug -secret kv-yanivomc/test  sleep 5600
envconsul -no-prefix -vault-token $(cat $VAULT_TOKEN_PATH) -vault-addr=$VAULT_ADDR -log-level debug -secret $CONSULPREFIX  "$@"