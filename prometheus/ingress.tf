#----------------------------------------------------------------
resource "kubernetes_ingress" "prometheus" {
   name = "prometheus"
   namespace = "${var.namespace}"
   spec = <<SPEC
  rules:
  - host: prometheus.ijuned.com
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus
          servicePort: 9090
SPEC
}
#----------------------------------------------------------------
