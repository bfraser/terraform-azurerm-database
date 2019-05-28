output "database_name" {
  description = "Database name of the Azure SQL Database created."
  value       = "${azurerm_sql_database.db.name}"
}

output "sql_server_name" {
  description = "Server name of the Azure SQL Database created."
  value       = "${azurerm_sql_server.server.name}"
}

output "sql_server_location" {
  description = "Location of the Azure SQL Database created."
  value       = "${azurerm_sql_server.server.location}"
}

output "sql_server_version" {
  description = "Version the Azure SQL Database created."
  value       = "${azurerm_sql_server.server.version}"
}

output "sql_server_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = "${azurerm_sql_server.server.fully_qualified_domain_name}"
}

output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  value       = "Server=tcp:${azurerm_sql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.db.name};Persist Security Info=False;User ID=${azurerm_sql_server.server.administrator_login};Password=${azurerm_sql_server.server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

output "firewall_rule_ids" {
  description = "The list of all firewall rule resource ids"
  value       = ["${azurerm_sql_firewall_rule.firewall_rules.*.id}"]
}

output "vnet_rule_ids" {
  description = "The list of all vnet rule resource ids"
  value       = ["${azurerm_sql_virtual_network_rule.vnet_rules.*.id}"]
}
