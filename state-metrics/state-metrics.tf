resource "kubernetes_deployment" "state-metrics" {
   name = "state-metrics"
   namespace = "${kubernetes_namespace.monitoring.name}"
   spec = <<SPEC
     replicas: 1
     template:
       metadata:
         labels:
           app: kube-state-metrics
           version: "v0.3.0"
       spec:
         containers:
         - name: kube-state-metrics
           image: gcr.io/google_containers/kube-state-metrics:v0.3.0
           ports:
           - containerPort: 8080
           imagePullPolicy: Always

SPEC
}
#----------------------------------------------------------------
resource "kubernetes_service" "state-metrics" {
   name = "state-metrics"
   namespace = "${kubernetes_namespace.monitoring.name}"
   annotations {
     name = "prometheus.io/scrape"
     value = "true"
   }
   spec = <<SPEC
  ports:
  - name: kube-state-metrics
    port: 8080
    protocol: TCP
  selector:
    app: kube-state-metrics
SPEC
}
