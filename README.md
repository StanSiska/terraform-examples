# Terraform :rocket: 
## Basics
Masterless tool for deploying infrastructure. <br>
Terraform code is written in the HashiCorp's Configuration Language (HCL) with extension .tf although handles also JSON configurations with extension .tf.json. 
State file (JSON) is used for keeping information about created infrastructure called "terraform.tfstate". Everytime Terraform is run, fetches latest status of EC2 Instances from AWS and compares to .tfstate file to determine needed changes.
 

## Commands
```
terraform console - interactive console for testing Terraform syntax and interpolation functions

terraform plan   - verificaties config, performs sanity check, output similar to diff
terraform apply  - creates infrastructure
terraform destroy - remove all created resources

terraform output - displays predefined outputs
terraform graph  - generates graph in DOT syntax 
terraform show   - displays current config

terraform input  - Import existing infrastructure into Terraform state file, allowing to find current resources to come under Terraform management 
terraform status - advanced options, requires further parameters

terraform remote config - configures erraform Remote State Storage from S3, Azure Storage, HashiCorp's Consul etc.
```
Open graph output in [GraphVizOnline](http://dreampuf.github.io/GraphvizOnline/) to visualize dependencies.

### Interpolation
An **interpolation function** is a function which can be used within Terraform's interpolation syntax.<br>
Syntax: ```${some_function()} ``` </br>
Example:  ```${format(FMT, ARGS, ...)}``` </br>
File Interpolation: ```"${file(PATH)}"``` - reads file at ```PATH``` and returns content as a string

There's number of built in functions to manipulate strings, numbers, lists and maps.

:octocat: Great way how to experiment with interpolation functions: ```terraform console```


### Remote State Storage
It's not desirable to store Remote State Storage files on version system due to visibility of secrets (plaintex) and error prone due to manual activities (push/pull)
Steps:
[x] Create an S3 bucket
[x] Define main.tf configuration 

###  Secrets
DB passwords or any sensitive information shall not be stored in plaintext. Use password manager for data encryption and expose those secrets to Terraform via environment variables. </br>
For each input variable ```foo``` could be provided to Terraform using env. var ```TF_VAR_foo```     

## Configuration Examples
### 01 - AWS Simple Example
Basic definitions for provider, using variables, tags, interpolation, first look to heredoc syntax
  
### 02 - AWS Cluster with ELB
Autoscaling groups, lifecycles definitions, Elastic Load Balancers, Healthchecks

### 03 - Remote State Storage using AWS S3 Bucket
