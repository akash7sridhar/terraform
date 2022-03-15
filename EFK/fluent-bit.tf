################################################################################
# Deploy FluendBit with kubernetes manifest
################################################################################


resource "kubectl_manifest" "fluent-bit-service-account" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentbit/fluent-bit-service-account.yaml")
}

resource "kubectl_manifest" "fluent-bit-role" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentbit/fluent-bit-role.yaml")

    depends_on = [
      kubectl_manifest.fluent-bit-service-account
    ]
}


resource "kubectl_manifest" "fluent-bit-role-binding" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentbit/fluent-bit-role-binding.yaml")

    depends_on = [
      kubectl_manifest.fluent-bit-role
    ]
}

resource "kubectl_manifest" "fluentbit-configmap" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentbit/fluentbit-configmap.yaml")

    depends_on = [
      kubectl_manifest.fluent-bit-role-binding
    ]
}

resource "kubectl_manifest" "fluentbit-ds" {
    override_namespace = var.namespace
    yaml_body = file("./charts/EFK-fluentbit/fluentbit/fluentbit-ds.yaml")

    depends_on = [
      kubectl_manifest.fluentbit-configmap
    ]
}