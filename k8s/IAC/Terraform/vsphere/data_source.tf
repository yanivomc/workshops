data "vsphere_datacenter" "dc" {
  #name = "dc1" //vsphere
  name = "yanivomc"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster-pool"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network-internal" {
  name          = "internal"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}




data "vsphere_compute_cluster" "compute_cluster" {
  name          = "center"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


output "resource_pool" {
  value = "${data.vsphere_compute_cluster.compute_cluster.resource_pool_id}"
}