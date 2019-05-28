variable "resource_group_name" {
  default = "mssqlResourceGroup"
}

variable "location" {
  default = "westus2"
}

variable "db_name" {
  default = "mydatabase"
}

variable "sql_admin_username" {
  default = "azureuser"
}

variable "sql_password" {
  default = "P@ssw0rd12345!"
}

variable "fw_rule_prefix" {}

variable "fw_rules" {
  type = "list"
}
