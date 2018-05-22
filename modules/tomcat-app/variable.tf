# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "app-name" {
  description = "Application Name"
}
variable "env-name" {
  description = "Environment Name"
}
variable "app_version_id" {
  description = "Unique version application ID"
}
variable "mysql-jdbc-host" {
  description = "My SQL JDBC HOST NAME"
}
