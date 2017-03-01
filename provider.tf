provider "kubernetes" {
    endpoint = "http://127.0.0.1:8001"
#    Either local proxy or remote API with certs
#    endpoint = "https://xxx.xxx.xxx.xxx"
#    ca_cert = "ca.pem"
#    client_cert = "admin.pem"
#    client_key = "admin-key.pem"
}
#----------------------------------------------------------------
