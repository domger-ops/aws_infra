## Service / Dept Infra
This folder runs like the network team but belongs to a service or department. 

In this case we will use it to stand up the roles and EKS cluster we need for a service. 

### Use
`BEFORE you run this section it is assumed you have ran stood up the network section and
updated the env file with the new subnet ids.`

Find your public ip address using something like `ipchicken.com` and add it to the public_access section in the cluster config. 

Stand up the cluster:
```sh
# Stand up the cluster
sops exec-file --filename tmp.json ../env/dev.enc.tfvars.json 'terraform apply --var-file={}'
# Bring down the cluster
sops exec-file --filename tmp.json ../env/dev.enc.tfvars.json 'terraform destroy --var-file={}'
```

### Connecting To Your Cluster
When running private you need a bastion server. In GCP there is a setting to restrict access to the control plane to certain ip addresses or ranges. Will need to find a comparable setting or switch to private and tunnel through a bastion. (GCP experience feels better here)
```sh
# Connect kubectl to your cluster
aws eks update-kubeconfig \                                                                  
  --region us-west-1 \
  --name sudo-dev
```

To validate your connection run:
```sh
kubectl cluster-info
```

### Resources
References to resrouces
[subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
[eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#example-iam-role-for-eks-cluster)
[access_entry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_access_entry)