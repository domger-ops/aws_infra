output "vpc_id" {
    value = {for k in  aws_vpc.dev: k.tags.name => k.id}

}

output "subnetworks" {
    value = {for k in  aws_subnet.dev: k.tags.name => k.id}
}
