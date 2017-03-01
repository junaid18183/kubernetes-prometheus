#----------------------------------------------------------------
resource "kubernetes_service" "node-exporter" {
   name = "node-exporter"
   namespace = "${kubernetes_namespace.monitoring.name}"
   annotations {
     name = "prometheus.io/scrape"
     value = "true"
   }
   spec = <<SPEC
  clusterIP: None
  ports:
  - name: scrape
    port: 9100
    protocol: TCP
  selector:
    app: node-exporter
  type: ClusterIP
SPEC
}
#----------------------------------------------------------------
resource "kubernetes_daemonset" "node-exporter" {
   name = "node-exporter"
   namespace = "${kubernetes_namespace.monitoring.name}"
  spec = <<SPEC
  template:
    metadata:
      labels:
        app: node-exporter
      name: node-exporter
    spec:
      containers:
      - image: prom/node-exporter
        name: node-exporter
        ports:
        - containerPort: 9100
          hostPort: 9100
          name: scrape
      hostNetwork: true
      hostPID: true
SPEC
}
