# Vault Helm Chart
Update Consul SERVICE NAME (from CONSUL) in the vault custom-values
#### Installing Helm for vault
 helm install --name vault --values ./custom-vaules.yaml  --set='VAULT_SEAL_TYPE=transit' .

#### Initialize
~~~ 
$ kubectl exec -it vault-0 -- vault operator init -n 1 -t 1
~~~ 

#### Unseal vault
~~~  
 $ kubectl exec -it vault-0 -- vault operator unseal <unsealkey>
~~~   


#### Login vault
~~~  
 $ kubectl exec -it vault-0 -- vault login
~~~   


#### Validate pods are up
~~~  
 $ k get pods vault-0
~~~   

#### Browse VAULT UI
~~~  
 $ kubectl port-forward vault-0 8200:8200
 browse http://localhost:8200
~~~   

#### Configure Vault auth method integration with K8S
~~~   
kubectl exec -it vault-0 -- vault secrets enable -path=secret kv
# This will enable secrets with V1 support ( No versioning )
~~~   
# Configure k8s auth method with VAULT
****
### The files for the following are located under ./scripts

1. Once Vault is installed and configured we need to run the integration AUTH k8s<>vault. 
1.1 to accomplish this we need to run the content of the file "k8sintegration_vault.sh"
****

# Authentication with an Init Container
This example will show the usage of the vault-kubernetes-authenticator image (auther for short). The auther runs in an init container, authenticates to Vault using the service account vault-serviceaccount and writes the Vault authentication token to /home/vault/.vault-token.



~~~ 
 $ envsubst < 01-init-example | k apply -f -
~~~   
*NOTE*: i'm using envsubst to replace the env variable inside the file with the EXPORT variables we created earlied for VAULT and K8S host address 

Expected outcome 
~~~   
k logs -f vault-init-test-55bb9b77db-287j2                                                                                     ✔ | 2.4.1 Ruby | kubernetes-admin@kudo ⎈
2019/10/05 17:16:07 successfully authenticated to vault
2019/10/05 17:16:07 successfully stored vault token at /home/vault/.vault-token
~~~   
