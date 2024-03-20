# Tables for remote state
variable "tables" {
    type = map
    default = {
        network = {
            tag = "init - network"
        }
    }
}