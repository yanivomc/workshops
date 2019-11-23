# INSTALL HELM:
1. Run script 
~~~
sudo apt update
sudo apt install snapd
sudo snap install core
sudo snap install helm --classic


kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --tiller-image [Tiller image if running without internet]--wait
helm repo update
helm search mysql [validate]
~~~

# INSTALL CONSUL:
#### From consul folder
~~~
$ helm install --name consulqa --values ./values-custom.yaml .
-----
IF error:
failed: namespaces "default" is forbidden: User "system:serviceaccount:kube-system:default" cannot get resource "namespaces"

Run RBAC permission:
$ kubectl create -f rbac-config.yaml
$ helm init --service-account tiller --history-max 200 --upgrade
-----
~~~
Once all pods are up and running,
Expose the service
~~~
$ kubectl port-forward [consul server pod] 8080:8500
~~~

# INSTALL VAULT:
# Vault Helm Chart
Update Consul SERVICE NAME (from CONSUL) in the vault custom-values
#### Installing Helm for vault
 helm install --name vault --values ./custom-vaules.yaml  --set='VAULT_SEAL_TYPE=transit' .

#### Initialize
~~~ 
$ kubectl exec -ti vault-0 ash 
$ vault operator init -n 3 -t 3
#### Unseal vault
$vault operator unseal <unsealkey>
#### Login vault
$ vault login
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


# Configure k8s auth method with VAULT
****
### The files for the following are located under ./scripts 
###### Vault cli should be installed on the machine where we are going to run all of the following commads

1. Once Vault is installed and configured we need to run the integration AUTH k8s<>vault. 
1.1 Create serviceAccount for the integration with VAULT
 (located inde vault/scripts/k8sVaultAuthintegration/rbac/vault-rbac)
~~~
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: vault-serviceaccount

---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: vault-clusterrolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:auth-delegator
subjects:
  - kind: ServiceAccount
    name: vault-serviceaccount
    namespace: default

---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: vault-secretadmin-role
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["*"]

---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: vault-secretadmin-rolebinding
subjects:
- kind: ServiceAccount
  name: vault-serviceaccount
roleRef:
  kind: Role
  name: vault-secretadmin-role
  apiGroup: rbac.authorization.k8s.io
~~~

1.2 to accomplish this we need to run the file "k8sintegration_vault.sh" or its content manualy



####Authentication with an Init Container
The first example will show the usage of the vault-kubernetes-authenticator image (auther for short). The auther runs in an init container, authenticates to Vault using the service account vault-serviceaccount and writes the Vault authentication token to /home/vault/.vault-token.


1.3 Run test deployment (located in vault/scripts/k8sVaultAuthintegration/) and see if the integration works.
Where kubectl runs - Run:
~~~
export VAULT_ADDR=http://vaultqa:8200
envsubst < inittest.yaml | k apply -f -
~~~
*NOTE*: i'm using envsubst to replace the env variable inside the file with the EXPORT variables we created earlied for VAULT and K8S host address 

Expected outcome 
~~~   
k logs -f vault-init-test-55bb9b77db-287j2
2019/10/05 17:16:07 successfully authenticated to vault
2019/10/05 17:16:07 successfully stored vault token at /home/vault/.vault-token
~~~   


# Deploying krb5 application with VAULT secret
****
1. Add KV for yanivomc and a secret to it
~~~
vault secrets enable -path=yanivomc kv
# Default lease (when client will check for update is 30m) if we wish to lower it we can set ttl argument to a lower number (10s, 10m ,1h....)
vault kv put yanivomc/krb5/password ttl=30m password=123456  
~~~
2. Deploy application: located under ./krb5_deployment/test-app/deployment.yaml
Run the following where kubctl is
~~~
export VAULT_ADDR=http://vaultqa:8200
# Location of the secret managed for this application 
export CONSULPREFIX=yanivomc/krb5/password 
# PERIOD_SECONDS is  for rekinit to refresh and renew the it's token
export PERIOD_SECONDS=1890
envsubst < deployment.yaml | k apply -f -
~~~