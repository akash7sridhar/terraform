#Deploys  through Helm
resource "helm_release" "hello-works" {
  name = "hello-world"
  namespace = var.namespace
  chart =  "./charts/hello-world"
  timeout   = 600

  values = [
    file("./charts/hello-world/values.yaml") 
     ]

   depends_on = [
      null_resource.config_kubectl
   ]
}
