variable "mysql_username" {
  description = "DB username"
  type        = string
}

variable "mysql_password" {
  description = "DB password"
  type        = string
  sensitive   = true
}

output "show_mysql_username" {
  value = var.mysql_username
}
