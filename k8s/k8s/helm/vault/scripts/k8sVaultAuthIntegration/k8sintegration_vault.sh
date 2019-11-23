export INTERNAL_IP=https://kubernetes:443 # make sure consul in installed and injected for this env to work
export VAULT_ADDR=http://vaultqa:8200 # make sure consul in installed and injected for this env to work

# Enable and configure the Kubernetes auth method ( UI / CMD)
# For details, see: 
# - https://www.vaultproject.io/docs/auth/kubernetes.html
# - https://www.vaultproject.io/api/auth/kubernetes/index.html
vault auth enable kubernetes
vault write auth/kubernetes/config \
    kubernetes_host=https://${INTERNAL_IP}:4443 \
    kubernetes_ca_cert=@/etc/kubernetes/pki/ca.crt # we can paste this in the UI once enabled
vault write auth/kubernetes/role/vault-demo-role \
    bound_service_account_names=vault-serviceaccount \
    bound_service_account_namespaces=default \
    policies=vault-demo-policy \
    ttl=1h

# create a secret enginge v1 for setting TTL (but without version OR use v2 with TTL default for 4 minutes)
vault secrets enable -path=secret kv

# Create a policy for demo purposes
cat <<EOF | vault policy write vault-demo-policy -
path "sys/mounts" { capabilities = ["read"] }
path "secret/data/demo/*" { capabilities = ["read"] }
path "secret/metadata/demo/*" { capabilities = ["list"] }
EOF

# Write some demo secret
vault kv put secret/demo/most-used-password password=123456
vault kv put secret/demo/first one=1234567890 two=2345678901
vault kv put secret/demo/second green=lantern poison=ivy
vault kv put secret/demo/greek/alpha philosopher=plato
vault kv put secret/demo/greek/beta god=zeus
vault kv put secret/demo/greek/gamma mountain=olympus
