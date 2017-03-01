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
