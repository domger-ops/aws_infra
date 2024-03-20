# Notes
Only a main and provider. Because this section only runs once we don't really need to waste time keeping it dry.

## Dependencies
Some things are assumed like:
* SOPs is installed
* AWS is installed
* The org configuration is complete
* A user and token with perms is available
* Terraform-docs are installed for tfvars conversions

## Provider
* Say we need AWS stuff
* Set the credentials
* Set the region

## Resources
* Bucket - remote backend for TF
* KMS Key - encryption using SOPs
* DynamoDB - a couple table for managing state

## Use 
The init state runs before the whole env does in order to give us pre reqs. 

```sh
tf apply --vars-file ../env/init.tfvars
```

## Configure Secrets
When we apply the terraform from the init folder we get kms key which we can use to encrypt all our secrets. When doing this init the first time around the files are unencrypted and require contents before this step. Make sure the env vars exists in the file if you are following these instructions.

Back up the kms key to your env var
```sh
KMS_ARN=$(terraform output aws_kms_key_arn | jq -r)
```

Convert the tfvars to json for SOPS. 
```sh
cd ..
terraform-docs tfvars json network > env/dev.tfvars.json 
```

At this point I'll jump over to the env folder.
```sh
sops --kms ${KMS_ARN} --encrypt env/dev.tfvars.json > env/dev.enc.tfvars.json 
```

We now have encrypted secrets. Move over to the Network folder to start using them.

## Code Style
I like to keep the core code the same across envs and pass the required changes between envs like scaling and unqiue configs to the env var file we pass. The forloops will allow us to mutate the final result and keeps our code dry. It also locks things down a bit so you don't get a huge drift between the environments.

## Resources
Links to resources used
[s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
[dynamo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)
[kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)