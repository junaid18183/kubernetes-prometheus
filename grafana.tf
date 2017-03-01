resource "kubernetes_service" "grafana" {
   name = "grafana"
   namespace = "${kubernetes_namespace.monitoring.name}"
   spec = <<SPEC
    selector:
      app: grafana
    ports:
      - name: ui
        protocol: TCP
        port: 3000
        targetPort: 3000
SPEC
}
#----------------------------------------------------------------
resource "kubernetes_deployment" "grafana" {
   name = "grafana"
   namespace = "${kubernetes_namespace.monitoring.name}"
   labels {
       app = "grafana"
   }
   spec = <<SPEC
  replicas: 1
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana
        ports:
        - containerPort: 3000
SPEC
}
#----------------------------------------------------------------
