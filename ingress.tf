#----------------------------------------------------------------
resource "kubernetes_ingress" "monitor" {
   name = "monitor"
   namespace = "${kubernetes_namespace.monitoring.name}"
   spec = "${file("ingress.yml")}"  # You can have spec in different yml file, or in the same tf file as below
}
#----------------------------------------------------------------
