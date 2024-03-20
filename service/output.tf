output "iam_roles" {
    value = {for k in  aws_iam_role.dev: k.name => k.arn}
}

output "policy_attachment" {
    value = {for k in  aws_iam_role_policy_attachment.dev: k.id => k.role}
}

# output "cloudwatch_log_group" {
#     value = {for k in  aws_cloudwatch_log_group.dev: k.id => k.role}
# }

output "eks_cluster" {
    value = {for k in  aws_eks_cluster.dev: k.name => k.id}
}
