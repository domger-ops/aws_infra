# aws_infra
AWS Infra for portfolio project

## Folder Structure
* env - enviromental variables (dev, prod) 
* init - first boot items (state bucket, iam user)
* network - networking items usually live outside of inidivual projects (when not using service mesh or vpc connect)
* service - service we are deploying

## First Time Run
*This section of the read me is dedicated to first time steps which do not need to be repeated.*

This setup assumes you are beginning from a brand new AWS account. 

Create an organization. Using organizations allow for billing, least priviledge, 

* Login to aws and go to `IAM Identity Center` and create a new organization. 
* Confirm the identity source
* Create the first user and superAdmin group
* Create permission set to AdministratorAccess
* Assign users or groups to the org
* Use the new SSO server and login the new user
* Create a token for the TF

## Remote State 
We provision a couple different `DynamoDB` tables and an `s3` bucket to store our TF state so others can jump in on the fun. :D 

## Secrets Management
I use `Mozilla SOPs` and `KMS` to encrypt secrets. 
The init process revolves around configuring these import items before the rest of the environment. 

[ref](https://medium.com/@javier.vlopez/using-mozilla-sops-terraform-provider-c48f65b73ca)

#### Logs
* Day 1 - Setup the aws org, sso, user, init folder and remote backend
* Day 2 - Configure SOPs with Terraform tfvars for env/secrets, forloops, network
* Day 3 - Setup my first EKS cluster with basic IAM
* Day 4 - Dive into securing EKS + logging setup
* Day 5 - Do the do -- if its the same, access policies
