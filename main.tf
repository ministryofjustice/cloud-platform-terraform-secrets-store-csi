module "irsa" {
  source           = "github.com/ministryofjustice/cloud-platform-terraform-irsa?ref=1.1.0"
  namespace        = "vijay-test"
  eks_cluster_name = "cp-1904-1603"
  role_policy_arns = [aws_iam_policy.secrets-stoer-csi.arn]
}

data "aws_iam_policy_document" "secrets-stoer-csi" {
  # AssumeRole permissions for Prometheus EC2 discovery in
  # nomis-production mod-platform acct.
  statement {
    actions = [
      "sts:AssumeRole",
      "secretsmanager:GetSecretValue", 
      "secretsmanager:DescribeSecret",
      "secretsmanager:List*"
    ]
    resources = [
      "arn:aws:secretsmanager:eu-west-2:754256621582:secret:path/to/secret2-Yoaxia",
    ]
  }
}
resource "aws_iam_policy" "secrets-stoer-csi" {
  name   = "secrets-stoer-csi-new"
  policy = data.aws_iam_policy_document.secrets-stoer-csi.json

  tags = {
    business-unit          = "cp"
    application            = "cp"
    is-production          = "false"
  }
}

resource "helm_release" "csi_secrets_store" {
    name        = "secrets-store-csi-driver"
    chart       = "secrets-store-csi-driver"
    repository  = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    namespace   = "kube-system"

}

resource "helm_release" "ascp" {
    name        = "secrets-store-csi-driver-provider-aws"
    chart       = "secrets-store-csi-driver-provider-aws"
    repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    namespace   = "kube-system"
}
