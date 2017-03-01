#----------------------------------------------------------------
resource "kubernetes_deployment" "prometheus" {
   name = "prometheus"
   namespace = "${var.namespace}"
   spec = <<SPEC
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 0
      maxUnavailable: 1
    type: RollingUpdate
  selector:
    matchLabels:
      app: prometheus
  template:
    metadata:
      name: prometheus
      labels:
        app: prometheus
    spec:
      containers:
      - name: prometheus
        image: quay.io/coreos/prometheus:latest
        args:
          - '-storage.local.retention=720h'
          - '-storage.local.memory-chunks=500000'
          - '-config.file=/etc/prometheus/prometheus.yml'
          - '-alertmanager.url=http://alertmanager:9093/alertmanager'
        ports:
        - name: web
          containerPort: 9090
        volumeMounts:
        - name: config-volume
          mountPath: /etc/prometheus
      volumes:
      - name: config-volume
        configMap:
          name: prometheus-configmap
          items:
          - key: prometheus.yml
            path: prometheus.yml

     
SPEC
}
#----------------------------------------------------------------
