# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "app-name" {
  description = "Application Name"
}
variable "docker-org" {
  description = "Docker registry Org Name"
}
variable "env-name" {
  description = "Environment Name"
}
variable "app-version-id" {
  description = "Unique version application ID"
}
variable "mysql-jdbc-host" {
  description = "My SQL JDBC HOST NAME"
}
variable "replicas" {
  description = "No:of Replicas" 
}
