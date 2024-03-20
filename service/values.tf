variable "clusters" {
    type = map
    default = {
         cluster99 = {
            keys = "values"
        }
    }
}

variable "iam_roles" {
    type = map
    default = {
         iam_role99 = {
            keys = "values"
        }
    }
}

variable "policy_attachments" {
    type = map
    default = {
         policy_attachments99 = {
            keys = "values"
        }
    }
}

variable "cloudwatch_log_group" {
    type = map
    default = {
         cloudwatch_log_group99 = {
            keys = "values"
        }
    }
}
