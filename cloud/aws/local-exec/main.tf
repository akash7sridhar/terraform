locals {
  name            = "akash"
  cluster_version = "1.21"
  region          = "ap-south-1"
}

resource "null_resource" "config_kubectl" {
  provisioner "local-exec" {
   command = "mkdir ${local.name}-${local.region}"

  }

}