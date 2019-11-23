# # Create a new rancher2 rke Cluster 
# No longer in use as we dont have DHCP in our Vcenter.
# provision is made by custom run 


# resource "rancher2_cluster" "qa-custom" {
#   count = 0
#   name = "qa-yanivomc"
#   description = "yanivomc qa local env"
#   rke_config {
#     network {
#       plugin = "canal"
#     }
#     private_registries {
#       url = "rancher-qa.devopshift.com",
#       # user = "admin"
#       # password = "nuva3131"
#       #is_default  = "true"
#     }
#     }
#   }



# # Create a new rancher2 Node Pool master
# resource "rancher2_node_pool" "master-qa" {
#   count = 0
#   cluster_id =  "${rancher2_cluster.qa-custom.id}"
#   name = "master-${count.index}"
#   hostname_prefix =  "master-qa-${count.index}"
#   node_template_id = "${rancher2_node_template.k8s-qa-master.id}"
#   quantity = 3
#   control_plane = true
#   etcd = true
#   worker = false
# }



# resource "rancher2_node_pool" "node-qa" {
#   count = 0
#   cluster_id =  "${rancher2_cluster.qa-custom.id}"
#   name = "sf-qa-node-${count.index}"
#   hostname_prefix =  "node-${count.index}"
#   node_template_id = "${rancher2_node_template.k8s-qa-node-small.id}"
#   quantity = 3
#   control_plane = false
#   etcd = false
#   worker = true
# }