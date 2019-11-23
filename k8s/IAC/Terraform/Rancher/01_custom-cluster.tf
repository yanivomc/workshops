resource "rancher2_cluster" "foo-custom" {
  name = "foo-custom"
  description = "Foo rancher2 custom cluster"

  rke_config {
    network {
      plugin = "canal"
    }
  }
}

output "docker-id" {
  value = "${rancher2_cluster.foo-custom.cluster_registration_token}"
}
