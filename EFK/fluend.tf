################################################################################
# Deploy Fluentd
################################################################################


resource "kubectl_manifest" "fluentd-elasticsearch-output-configmap" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentd/fluentd-elasticsearch-output-configmap.yaml")
}

resource "helm_release" "fluentd" {
  name = "fluentd"
  namespace = var.namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "fluentd"
  timeout   = 300
  
  set {
    name  = "image.repository"
    value = "georgegoh/fluentd"
  }

  set {
    name  = "image.tag"
    value = "1.10.4-debian-10-r2-rewrite_tag_filter"
  }

  set {
    name  = "forwarder.enabled"
    value = "false"
  }

  set {
    name  = "aggregator.enabled"
    value = "true"
  }

  set {
    name  = "aggregator.replicaCount"
    value = "1"
  }

  set {
    name  = "aggregator.port"
    value = "24224"
  }

  set {
    name  = "aggregator.configMap"
    value = "fluentd-elasticsearch-output"
  }

  depends_on = [
    kubectl_manifest.fluentd-elasticsearch-output-configmap
  ]

}