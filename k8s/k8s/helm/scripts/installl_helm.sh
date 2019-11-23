sudo apt update
sudo apt install snapd
sudo snap install core
sudo snap install helm --classic


kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --wait
helm repo update



