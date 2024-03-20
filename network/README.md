## Network Org
VPC and subnets are essential but often run in their own space and ran by a dedicated team. 

I keep things apart just to emulate that part of the work. 

## Terraform + SOPs
To run the dev environment network the commands looks like this:
```sh
# Stand up network
sops exec-file --filename tmp.json ../env/dev.enc.tfvars.json 'terraform apply --var-file={}'
# Destroy Env
sops exec-file --filename tmp.json ../env/dev.enc.tfvars.json 'terraform destroy --var-file={}'
```

These commands will decrypt the json file in the env folder with sops, call a command (`terraform`), and pass it the decrypted envs file. 

Previously, I was using Terragrunt as a wrapper but, it seems like this new feature came out a few years ago that lets me run barebones. 

## Important
Each time we bring this section of the environment up and down we need to update the values file.
The subnet-id's will be unique and in the case of a managed network would normally not change. 

### Note
The `{}` is redirected input/file from `SOPS`. 
[ref](https://github.com/getsops/sops/pull/761)

### Resources
References to resrouces
[subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
[s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)