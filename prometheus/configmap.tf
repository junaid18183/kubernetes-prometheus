#----------------------------------------------------------------
resource "kubernetes_configmap" "prometheus-configmap" {
   name = "prometheus-configmap"
   namespace = "${var.namespace}"
   labels {
       app = "prometheus"
   }
   data {
  prometheus.yml = "
    global:
      scrape_interval: 15s
    scrape_configs:
    # etcd is living outside of our cluster and we configure
    # it directly.
    - job_name: 'etcd'
      static_configs:
      #target_groups:
      - targets:
        - 52.87.205.29:2379
    - job_name: 'kubernetes_components'
      kubernetes_sd_configs:
        # This configures Prometheus to identify itself when scraping
        # metrics from Kubernetes cluster components.
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      # Prometheus provides meta labels for each monitoring targets. We use
      # these to select targets we want to monitor and to modify labels attached
      # to scraped metrics.
      relabel_configs:
      # Only scrape apiserver and kubelets.
      - source_labels: [__meta_kubernetes_role]
        action: keep
        regex: (?:apiserver|node)
      # Redefine the Prometheus job based on the monitored Kuberentes component.
      - source_labels: [__meta_kubernetes_role]
        target_label: job
        replacement: kubernetes_$1
      # Attach all node labels to the metrics scraped from the components running
      # on that node.
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
    - job_name: 'kubernetes_services'
      kubernetes_sd_configs:
      relabel_configs:
      - source_labels: [__meta_kubernetes_role, __meta_kubernetes_service_annotation_prometheus_io_scrape]
        action: keep
        regex: endpoint;true
      - source_labels: [__meta_kubernetes_service_name]
        target_label: job
      - source_labels: [__meta_kubernetes_namespace]
        target_label: namespace
      - action: labelmap
        regex: __meta_kubernetes_service_label_(.+)
"
}
}
#----------------------------------------------------------------
