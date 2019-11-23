todo:
1. Configure KUBEDNS for stubDomain with Consul using the script in scripts enable-stub
https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/#configure-stub-domain-and-upstream-dns-servers
2. Set the serivce type in the values to NodePort and set the annotions for the Traefic



NOTES:
when installing consul - use the custom added values for probe deleay 30s or consul will fail to start

## To checkout latest git release:
git checkout $(git describe --abbrev=0 --tags)



### VAULT INSTALLATION 
NOTES for templates: https://www.vaultproject.io/docs/platform/k8s/helm.html



-----
exec /bin/consul connect proxy \
  -http-addr=${HOST_IP}:8500 \
  -service=dashboard \
  -upstream="counting-service-deployment:9001"
