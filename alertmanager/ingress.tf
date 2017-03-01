#----------------------------------------------------------------
resource "kubernetes_ingress" "alertmanager" {
   name = "alertmanager"
   namespace = "${var.namespace}"
   spec = <<SPEC
  rules:
  - host: alertmanager.ijuned.com
    http:
      paths:
      - path: /
        backend:
          serviceName: alertmanager
          servicePort: 9093
SPEC
}
#----------------------------------------------------------------
