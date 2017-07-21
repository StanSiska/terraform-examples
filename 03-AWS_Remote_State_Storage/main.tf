provider "aws" {
  region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform_s3_bucket" {
  # Pick some globally unique name
  bucket = "terraform-s3-bucket"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
