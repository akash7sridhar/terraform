resource "null_resource" "config_kubectl" {
  provisioner "local-exec" {
   command = "mkdir ${var.file}-${var.region}"

  }

}