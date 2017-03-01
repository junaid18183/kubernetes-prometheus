#----------------------------------------------------------------
resource "kubernetes_configmap" "alertmanager-configmap" {
   name = "alertmanager-configmap"
   labels {
       app = "prometheus"
   }
   data {
  config.yml = "
    global:
      slack_api_url: 'https://hooks.slack.com/services/XYZ'
      smtp_smarthost: 'your_smtp_host:587'
      smtp_from: 'prometheus@ijuned.com'
      smtp_auth_username: 'your_smtp_username'
      smtp_auth_password: 'Password'
    templates:
    - '/etc/alertmanager/template/*.tmpl'
    route:
      group_by: ['alertname', 'cluster', 'service']
      group_wait: 30s
      group_interval: 1m
      repeat_interval: 1m
      receiver: default-receiver
    inhibit_rules:
    - source_match:
        severity: 'critical'
      target_match:
        severity: 'warning'
      # Apply inhibition if the alertname is the same.
      equal: ['alertname', 'cluster', 'service']
    receivers:
    - name: 'default-receiver'
      slack_configs:
      - channel: '#general'
        text: '{{ .Alerts.Firing }}/{{ .GroupLabels.alertname }}/{{ .GroupLabels.SortedPairs.Values }}'
        send_resolved: true
      email_configs:
      - to: 'juned.memon@reancloud.com'
        send_resolved: true
"
   }
}
#----------------------------------------------------------------
