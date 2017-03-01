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
