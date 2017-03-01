provider "kubernetes" {
    endpoint = "http://127.0.0.1:8001"
#    Either local proxy or remote API with certs
#    endpoint = "https://52.91.195.128"
#    ca_cert = "/home/junedm/kubernetes-aws-terraform/secrets/ca.pem"
#    client_cert = "/home/junedm/kubernetes-aws-terraform/secrets/admin.pem"
#    client_key = "/home/junedm/kubernetes-aws-terraform/secrets/admin-key.pem"
}
#----------------------------------------------------------------
