#Deploy Kubernetes dashboard from remote repository

resource "helm_release" "elasticsearch" {
  name = "elasticsearch"
  namespace = var.namespace
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  timeout   = 300

}

resource "helm_release" "kibana" {
  name = "kibana"
  namespace = var.namespace
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  timeout   = 300

  values = [
      file("./charts/EFK-fluentbit/kibana/kibana-values.yaml")
  ]

}

