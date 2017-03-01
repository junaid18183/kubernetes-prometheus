resource "kubernetes_service" "grafana" {
   name = "grafana"
   namespace = "${var.namespace}"
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
   namespace = "${var.namespace}"
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
resource "kubernetes_ingress" "grafana" {
   name = "grafana"
   namespace = "${var.namespace}"
   spec = <<SPEC
  rules:
  - host: grafana.ijuned.com
    http:
      paths:
      - path: /
        backend:
          serviceName: grafana
          servicePort: 3000
SPEC
}
#----------------------------------------------------------------
