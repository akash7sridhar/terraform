#Deploys  through Helm
resource "helm_release" "hello-works" {
  name = "hello-world"
  namespace = var.namespace
  chart =  "./charts/hello-world"
  timeout   = 600

  values = [
    file("./charts/hello-world/values.yaml") 
     ]
}

# Deploy Kubernetes dashboard from remote repository

resource "helm_release" "kube-dashboard" {
  name = "kube-dashboard"
  namespace = var.namespace
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  timeout   = 600

}
