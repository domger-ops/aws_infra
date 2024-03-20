resource "aws_s3_bucket" "example" {
    bucket = "sudoing-remote-state"

  tags = {
        Name        = "terraform"
        Environment = "init"
    }
}

resource "aws_kms_key" "crypt" {
    description             = "SOPs encryption"
    deletion_window_in_days = 10
}

resource "aws_dynamodb_table" "terraform-lock" {
    for_each        = var.tables
    
    name            = "${each.key}-tfstate"
    read_capacity   = 5
    write_capacity  = 5
    hash_key        = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        "Name" = each.value.tag
    }
}