#----------------------------------------------------------------
resource "kubernetes_service" "alertmanager" {
   name = "alertmanager"
   namespace = "${var.namespace}"
   spec = <<SPEC
  selector:
    app: alertmanager
  type: ClusterIP
  ports:
  - name: alertmanager
    port: 9093
    targetPort: 9093

SPEC
}
#----------------------------------------------------------------
resource "kubernetes_deployment" "alertmanager" {
   name = "alertmanager"
   namespace = "${var.namespace}"
   spec = <<SPEC
  replicas: 1
  template:
    metadata:
      labels:
        app: alertmanager
    spec:
      containers:
      - name: alertmanager
        image: prom/alertmanager:v0.5.1
        ports:
        - containerPort: 9093
        imagePullPolicy: Always
        volumeMounts:
          - mountPath: /etc/alertmanager
            name: alertmanager
      volumes:
        - name: alertmanager
          configMap:
            name: alertmanager-configmap
            items:
              - key: config.yml
                path: config.yml
SPEC
}
