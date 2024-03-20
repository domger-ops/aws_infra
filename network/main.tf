resource "aws_vpc" "dev" {
    for_each          = var.network
    
    cidr_block        = each.value.cidr_block
    instance_tenancy  = "default"

    tags = {
        name = each.value.tag
    }
}

resource "aws_subnet" "dev" {
    for_each                =   var.subnetworks

    vpc_id                  = aws_vpc.dev[each.value.vpc].id # Creates a dependency to the resouce above
    availability_zone_id    = each.value.az-id
    cidr_block              = each.value.cidr_block

    tags = {
        name = each.value.tag
    }
}