resource "helm_release" "csi_secrets_store" {
    name        = "secrets-store-csi-driver"
    chart       = "secrets-store-csi-driver"
    repository  = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    namespace   = "kube-system"

}

resource "helm_release" "ascp" {
    name        = "csi-secrets-store-provider-aws"
    chart       = "csi-secrets-store-provider-aws"
    repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    namespace   = "kube-system"
}
