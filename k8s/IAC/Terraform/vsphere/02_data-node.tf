module "master_nodes_qa1" {
  source = "../modules/rancher/custom_templates/"
  instance_count    = "2"
  vm_template       = "Centos7-Packer2"
  num_cpus          = "2"
  ram               = "2048" // in MB
  disk_size         = "20" // in GB
  hostname          = "yanivomc-master"
  domain            = "tlv.io"
  static_ip_subnet  = "172.68.1.0/24"
  dns_server_list   = ["8.8.8.8","192.168.1.1"]
  ipv4_gateway      = "192.168.1.168"
  rancher_server    = "${var.rancher_server}"
  rancher_agent_token    = "${var.rancher_agent_token}"
  node_controlplane = "--controlplane"
  node_etcd         = "--etcd"
  node_worker       = ""
}
