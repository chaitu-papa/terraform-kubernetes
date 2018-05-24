provider "kubernetes" {
  host     = "https://api.kubernetes.devops-coe-cts.com"
  username = "admin"
  password = "ZpvS6H8ODjKhpvBdZGDs3oeIgHKjkqBk"
  insecure = "true"
}
module "tomcat_application" {
	source = "../modules/tomcat-app"
	app-name = "spring-petclinic"
	env-name = "uat"
	app_version_id = "31"
	mysql-jdbc-host = "100.71.84.21"
}
output "application_endpoint" {
	value = "${module.tomcat_application.endpoint}"
}
