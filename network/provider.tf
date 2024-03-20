terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    
    backend "s3" {
        bucket         = "sudoing-remote-state"
        key            = "remote-state-dev.tfstate"
        region         = "us-west-1"
        encrypt        = true
        dynamodb_table = "network-tfstate"
    }
}

provider "aws" {
    shared_config_files      = ["/Users/dev/.aws/config"]
    shared_credentials_files = ["/Users/dev/.aws/credentials"]
    region = "us-west-1"
}

