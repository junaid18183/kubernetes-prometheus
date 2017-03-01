#----------------------------------------------------------------
resource "kubernetes_service" "prometheus" {
   name = "prometheus"
   namespace = "${var.namespace}"   
   spec = <<SPEC
  selector:
    app: prometheus
  type: ClusterIP
  ports:
  - name: prometheus
    protocol: TCP
    port: 9090
    targetPort: 9090
SPEC
}
