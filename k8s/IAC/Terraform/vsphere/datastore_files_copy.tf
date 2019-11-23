# resource "vsphere_file" "ubuntu_disk_upload" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore1"
#   source_file      = "/Users/yanivos/Downloads/rancheros.iso"
#   destination_file = "/files/rancheros.iso"
# }


# resource "vsphere_file" "rancheros_image" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore1"
#   source_file      = "/Users/yanivos/work/repos/yanivomc/IAC/Terraform/vsphere/packer/images/rancheros.tar.gz"
#   destination_file = "/files/rancheros.tar.gz"
# }



# resource "vsphere_file" "vmware-vcsa" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore1"
#   source_file      = "/Users/yanivos/Downloads/VMware-VCSA-all-6.7.0-13643870.iso"
#   destination_file = "/files/VMware-VCSA-all-6.7.0-13643870.iso"
# }


# resource "vsphere_file" "rancheros-vmware" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore1"
#   source_file      = "/Users/yanivos/Downloads/rancheros-vmware-autoformat.iso"
#   destination_file = "/files/rancheros-vmware-autoformat.iso"
# }


# resource "vsphere_file" "alpine-vmware" {
#   datacenter       = "ha-datacenter"
#   datastore        = "datastore1"
#   source_file      = "/Users/yanivos/Downloads/alpine-standard-3.10.0-x86_64.iso"
#   destination_file = "/files/alpine-standard-3.10.0-x86_64.iso"
# }
