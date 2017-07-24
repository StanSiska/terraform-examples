# Backend configuration doesnt support Interpolation.
# More info on GitHub pages https://github.com/gruntwork-io/terragrunt
terragrunt {
  terraform {
    # Configure Terragrunt to automatically store tfstate files in S3
    backend "s3" {
      bucket = "terraform-s3-bucket"
      key = "terraform-state/terraform.tfstate"
      region = "eu-central-1"
      encrypt = true
      # Configure Terragrunt to use DynamoDB for locking
      lock_table = "my-tf-lock-table"
    }
  }
}