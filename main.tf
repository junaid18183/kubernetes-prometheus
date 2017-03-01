provider "kubernetes" {
    endpoint = "http://127.0.0.1:8001"
#    Either local proxy or remote API with certs
#    endpoint = "https://xxx.xxx.xxx.xxx"
#    ca_cert = "ca.pem"
#    client_cert = "admin.pem"
#    client_key = "admin-key.pem"
}
#----------------------------------------------------------------
resource "kubernetes_namespace" "monitoring" {
   name = "monitoring"
   }
#----------------------------------------------------------------
module "ingress-controller" {
  source = "./ingress-controller"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
module "grafana" {
  source = "./grafana"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
module "state-metrics" {
  source = "./state-metrics"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
module "node-exporter" {
  source = "./node-exporter"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
module "alertmanager" {
  source = "./alertmanager"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
module "prometheus" {
  source = "./prometheus"
  namespace = "${kubernetes_namespace.monitoring.name}"
}
#----------------------------------------------------------------
