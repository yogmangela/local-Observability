provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "eu-west-2"

  endpoints {
    s3         = "http://localhost:4566"
    opensearch = "http://localhost:4566"
    logs       = "http://localhost:4566"
    sts        = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "observability-logs"
  force_destroy = true
}

# provider "aws" {
#   s3_use_path_style = true  # 🔹 Forces Terraform to use path-style requests
# }

resource "aws_opensearch_domain" "opensearch" {
  domain_name    = "observability-cluster"
  engine_version = "OpenSearch_2.3"

  cluster_config {
    instance_type = "t3.small.search"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }

  encrypt_at_rest {
    enabled = true
  }

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "es:*",
      "Resource": "arn:aws:es:us-east-1:000000000000:domain/observability-cluster/*"
    }
  ]
}
POLICY
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name = "/aws/observability/logs"
  retention_in_days = 7
}