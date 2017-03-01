#----------------------------------------------------------------
resource "kubernetes_deployment" "default-http-backend" {
   name = "default-http-backend"
   namespace = "${var.namespace}"
   labels { k8s-app = "default-http-backend" }
   spec = <<SPEC
  replicas: 1
  template:
    metadata:
      labels:
        k8s-app: default-http-backend
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: default-http-backend
        # Any image is permissable as long as:
        # 1. It serves a 404 page at /
        # 2. It serves 200 on a /healthz endpoint
        image: gcr.io/google_containers/defaultbackend:1.0
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 30
          timeoutSeconds: 5
        ports:
        - containerPort: 8080
        resources:
          limits:
            cpu: 10m
            memory: 20Mi
          requests:
            cpu: 10m
            memory: 20Mi
SPEC
}
#----------------------------------------------------------------
resource "kubernetes_service" "default-http-backend" {
   name = "default-http-backend"
   namespace = "${var.namespace}"
   labels { k8s-app = "default-http-backend" }
   spec = <<SPEC
  ports:
  - port: 80
    targetPort: 8080
  selector:
    k8s-app: default-http-backend
SPEC
}
#----------------------------------------------------------------
