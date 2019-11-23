# #Data source for VM template

# # VM Template configuration variables:
# // TODO: Create module of this
# variable "instance_count" {
#   description = "Number of CPUS per VM"
#   default = "2"
# }
# variable "num_cpus" {
#   description = "Number of CPUS per VM"
#   default = "2"
# }

# variable "ram" {
#   description = "Ammount of RAM per VM in MB"
#   default = "2048"
# }


# variable "disk_size" {
#   description = "SDA Disk size in GB"
#   default = "20"
# }


# variable "hostname" {
#   description = "hostname for VM[s]"
#   default = "yanivomc-master"
# }


# variable "domain" {
#   description = "domain name for VM[s]"
#   default = "tlv.io"
# }


# variable "static_ip_subnet" {
#   description = "subnet for VM[s]"
#   default = "172.68.1.0/24"
# }
# variable "dns_server_list" {
#   description = "dns server list "
#   type = "list"
#   default = ["8.8.8.8","192.168.1.1"]
# }

# variable "ipv4_gateway" {
#   description = "default gateway ip "
#   default = "192.168.1.168"
# }

# # VM Template configuration variables:

# variable "rancher_server" {}
# variable "rancher_agent_token" {}

# variable "node_controlplane" {
#   description = "default gateway ip "
#   # = "--controlplane"
#   default = "--controlplane"
  
# }

# variable "node_etcd" {
#   description = "default gateway ip "
#   # = "--etcd"
#   default = "--etcd"
# }

# variable "node_worker" {
#   description = "default gateway ip "
#   # = "--worker"
#   default = ""
# }



# // END Variables Configuration 

# data "vsphere_virtual_machine" "master-template-small" {
#   name = "Centos7-Packer2" // Template to be used
#   datacenter_id = "${data.vsphere_datacenter.dc.id}"
# }

# resource "vsphere_virtual_machine" "master-node-vm-small" {
#   count            = "${var.instance_count}"  // Number of nodes we wish to create of this type
#   name             =  "${var.hostname}-${count.index}"
#   resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
#   datastore_id     = "${data.vsphere_datastore.datastore.id}"
#   wait_for_guest_net_routable = false
  
#   num_cpus = "${var.num_cpus}"
#   memory   = "${var.ram}"
#   guest_id = "centos7_64Guest"

#   network_interface {
#     #network_id = "${data.vsphere_network.network.id}"
#     network_id = "${data.vsphere_network.network-internal.id}"
#   }

#   disk {
#     label = "disk0"
#     size  = "${var.disk_size}"
#   }

#   #Included a clone attribute in the resource
#   clone {
#     template_uuid = "${data.vsphere_virtual_machine.master-template-small.id}"

#     customize {
#       linux_options{
#         host_name = "${var.hostname}-${count.index}"
#         domain = "${var.domain}"
#       }
#       network_interface {
#         #ipv4_address = "172.68.1.1${count.index}"
#         ipv4_address = "${cidrhost("${var.static_ip_subnet}", count.index + 1)}"
#         ipv4_netmask = "24"
        
#         # dns_suffix_list = ["winterfell.lan"]
#         dns_server_list = "${var.dns_server_list}"
#       }
#       ipv4_gateway = "${var.ipv4_gateway}"
      
      
#     }
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.2.4 --server ${var.rancher_server} --token ${var.rancher_agent_token} ${var.node_controlplane} ${var.node_etcd} ${var.node_worker}"
#     ]
#   }

# }
