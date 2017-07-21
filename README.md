# Terraform 
## Basics
Masterless tool for deploying infrastructure. <br>
Terraform code is written in the HashiCorp's Configuration Language (HCL) with extension .tf although handles also JSON configurations with extension .tf.json. 

## Commands
```
terraform plan   - verificaties config, performs sanity check, output similar to diff
terraform apply  - creates infrastructure
terraform destroy - remove all created resources

terraform output - displays predefined outputs
terraform show   - displays current config
terraform graph  - generates graph in DOT syntax 
```
Open graph output in [GraphVizOnline](http://dreampuf.github.io/GraphvizOnline/) to visualize dependencies.
## Configuration Examples

### 01 - AWS Simple Example
Basic definitions for provider, using variables, tags, interpolation, first look to heredoc syntax
  
### 02 - AWS Cluster with ELB
Autoscaling groups, lifecycles definitions, Elastic Load Balancers, Healthchecks


