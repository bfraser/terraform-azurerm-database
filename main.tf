# provider "azurerm" {
#   subscription_id = "REPLACE-WITH-YOUR-SUBSCRIPTION-ID"
#   client_id       = "REPLACE-WITH-YOUR-CLIENT-ID"
#   client_secret   = "REPLACE-WITH-YOUR-CLIENT-SECRET"
#   tenant_id       = "REPLACE-WITH-YOUR-TENANT-ID"
# }

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_sql_database" "db" {
  name                             = "${var.db_name}"
  resource_group_name              = "${azurerm_resource_group.rg.name}"
  location                         = "${var.location}"
  edition                          = "${var.db_edition}"
  collation                        = "${var.collation}"
  server_name                      = "${azurerm_sql_server.server.name}"
  create_mode                      = "Default"
  requested_service_objective_name = "${var.service_objective_name}"
  tags                             = "${var.tags}"
}

resource "azurerm_sql_server" "server" {
  name                         = "${var.db_name}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.rg.name}"
  location                     = "${var.location}"
  version                      = "${var.server_version}"
  administrator_login          = "${var.sql_admin_username}"
  administrator_login_password = "${var.sql_password}"
  tags                         = "${var.tags}"
}

resource "azurerm_sql_firewall_rule" "firewall_rules" {
  count               = "${length(var.firewall_rules)}"
  name                = "${var.firewall_rule_prefix}${lookup(var.firewall_rules[count.index], "name", count.index)}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server.name}"
  start_ip_address    = "${lookup(var.firewall_rules[count.index], "start_ip")}"
  end_ip_address      = "${lookup(var.firewall_rules[count.index], "end_ip")}"
}

resource "azurerm_sql_virtual_network_rule" "vnet_rules" {
  count               = "${var.vnet_rule_count}"
  name                = "${var.vnet_rule_name_prefix}${lookup(var.vnet_rules[count.index], "name", count.index)}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  server_name         = "${azurerm_sql_server.server.name}"
  subnet_id           = "${lookup(var.vnet_rules[count.index], "subnet_id")}"
}
