resource "aws_kms_key" "a" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
}
resource "aws_kms_alias" "a" {
  name          = "alias/my-key-alias12"
  target_key_id = aws_kms_key.a.key_id
}
resource "aws_kms_key" "oauth_config" {
  description = var.oauth_config_description
  is_enabled  = true
}
resource "aws_kms_ciphertext" "oauth" {
  key_id = aws_kms_key.oauth_config.key_id
  plaintext = <<EOF
{
  "client_id": "e587dbae22222f55da22",
  "client_secret": "8289575d00000ace55e1815ec13673955721b8a5"
}
EOF
}
# resource "aws_kms_custom_key_store" "test" {
#   cloud_hsm_cluster_id  = var.cloud_hsm_cluster_id
#   custom_key_store_name = "kms-custom-key-store-test"
#   key_store_password    = "noplaintextpasswords1"
#   trust_anchor_certificate = file("anchor-certificate.crt")
# }
resource "aws_iam_role" "a" {
  name = var.name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_kms_grant" "a" {
  name              =  "my-grant"
  key_id            = aws_kms_key.a.key_id
  grantee_principal = aws_iam_role.a.arn
  operations        = var.operations
  constraints {
    encryption_context_equals = {
      Department = "Finance"
    }
  }
}
provider "aws" {
  alias  = "primary"
  region = "us-east-1"
}
provider "aws" {
  region = "us-west-2"
}
resource "aws_kms_key" "primary" {
  provider = aws.primary
  description             = var.primary_description
  deletion_window_in_days = var.primary_deletion_window_in_days
  multi_region            = true
}
resource "aws_kms_replica_key" "replica" {
  description             = var.replica_description
  deletion_window_in_days = var.kms_deletion_window_in_days
  primary_key_arn         = aws_kms_key.primary.arn
}