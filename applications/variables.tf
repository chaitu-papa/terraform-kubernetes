# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "k8s-api" {
  description = "Kubernetes api url"
}
variable "k8s-username" {
  description = "Kubernetes username"
}
variable "k8s-password" {
  description = "Kubernetes password"
}
variable "app-name" {
  description = "Application Name"
}
variable "env-name" {
  description = "Environment Name"
}
variable "app-version-id" {
  description = "Unique version application ID"
}
variable "docker-org" {
  description = "Docker registry org Name"
}
variable "mysql-jdbc-host" {
  description = "My SQL JDBC HOST NAME"
}
variable "replicas" {
  description = "no:of application replicas"
}
variable "appd-agent-account" {
  description = "appd agent account"
}
variable "appd-agent-account-access-key" {
  description = "appd agent account access key"
}
