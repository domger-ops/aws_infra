# IAM policy Stuffs
resource "aws_iam_role" "dev" {
    for_each = var.iam_roles

    name               = each.key
    assume_role_policy = file("${path.root}/policies/${each.value.policy_name}.json")
}

resource "aws_iam_role_policy_attachment" "dev" {
    for_each = var.policy_attachments

    policy_arn = each.value.policy_arn
    role       = aws_iam_role.dev[each.value.role].name
    # Note: remove vpc-resource-controller-policy from dev env file to disable
    # Optionally, enable Security Groups for Pods
    # Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
}

resource "aws_cloudwatch_log_group" "default" {
    for_each = var.clusters
    # The log group name format is /aws/eks/<cluster-name>/cluster
    # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
    name              = "/aws/eks/${each.key}/cluster"
    retention_in_days = each.value.retention
}

## EKS Cluster Stuffs 
resource "aws_eks_cluster" "dev" {
    for_each = var.clusters

    name     = each.key
    role_arn = aws_iam_role.dev[each.value.role].arn

    enabled_cluster_log_types = ["api", "audit"]

    vpc_config {
        subnet_ids = each.value.subnet_ids
        endpoint_private_access = true
        endpoint_public_access  = true
        # Restrict the control plane to only my public ip (or work vpn?)
        public_access_cidrs     = each.value.public_access
    }

    access_config {
        # We really want API! 
        authentication_mode                         = "API_AND_CONFIG_MAP"
        bootstrap_cluster_creator_admin_permissions = true
    }

    depends_on = [aws_cloudwatch_log_group.default]
}
