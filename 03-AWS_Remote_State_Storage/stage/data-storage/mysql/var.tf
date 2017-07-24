// Note that this variable does not have a default. This is intentional. You should not store your
// database password or any sensitive information in plain text. Instead, you should store all secrets
// using a password manager that will encrypt your sensitive data (e.g., 1Password, LastPass, OS X
// Keychain) and expose those secrets to Terraform via environment variables

// For each input variable 'foo' defined in your Terraform configurations, you can provide Terraform the value using the environment variable TF_VAR_foo.
// Linux example: export TF_VAR_db_password="(YOUR_DB_PASSWORD)"

variable "db_password" {
  description = "The password for the database"
}

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