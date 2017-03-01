resource "kubernetes_deployment" "ingress-controller" {
   name = "ingress-controller"
   namespace = "${kubernetes_namespace.monitoring.name}"
   labels { k8s-app = "default-http-backend" }
   spec = "${file("deploy-ingress-controller.yml")}"
}
#----------------------------------------------------------------
