#----------------------------------------------------------------
resource "kubernetes_deployment" "default-http-backend" {
   name = "default-http-backend"
   namespace = "${kubernetes_namespace.monitoring.name}"
   labels { k8s-app = "default-http-backend" }
   spec = "${file("deploy-default-http-backend.yml")}"
}
#----------------------------------------------------------------
resource "kubernetes_service" "default-http-backend" {
   name = "default-http-backend"
   namespace = "${kubernetes_namespace.monitoring.name}"
   labels { k8s-app = "default-http-backend" }
   spec = "${file("svc-default-http-backend.yml")}"
}
#----------------------------------------------------------------
