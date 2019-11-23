
# variable "docker-repos" {
#   description = "description"
#   default = "https://rancher-qa.devopshift.com/nexus/repository/raw/rancher/rancheros-vmare.iso"
# }

# variable "iso-repo" {
#   description = "description"
#   default = "https://rancher-qa.devopshift.com/nexus/repository/raw/rancher/rancheros-vmare.iso"
# }



# resource "rancher2_node_template" "k8s-qa-master" {
#   name = "master-node-qa"
#   description = "master node small for qa"
#   cloud_credential_id = "${rancher2_cloud_credential.foo.id}"
#   vsphere_config {
#     datacenter  = "ha-datacenter"
#     boot2docker_url =  "${var.iso-repo}" // default from RKS os is being used
#     cpu_count  = "3"
#     memory_size = "2048"
#     disk_size  = "30000"
#     #pool = "<ZONE>"
#     #network = ["VM Network"]
#     network = ["VM Network"]
#     datastore = "datastore1"
#     cfgparam = ["disk.enableUUID=true"]

#   }
# }

# resource "rancher2_node_template" "k8s-qa-node-small" {
#   name = "worker-node-qa-small"
#   description = "worker node small for qa"
#   cloud_credential_id = "${rancher2_cloud_credential.foo.id}"
#   vsphere_config {
#     datacenter  = "ha-datacenter"
#     boot2docker_url =  "${var.iso-repo}" // default from RKS os is being used    cpu_count  = "2"
#     memory_size = "2048"
#     disk_size  = "30000"
#     #pool = "<ZONE>"
#     #network = ["VM Network"]
#     network = ["VM Network"]
#     datastore = "datastore1"

#   }
# }
