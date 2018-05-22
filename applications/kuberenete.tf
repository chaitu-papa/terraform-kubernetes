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
	mysql-jdbc-host = "a9f24c4135da311e8a89a0e9cfd102bd-1177462056.us-east-1.elb.amazonaws.com"
}
output "application_endpoint" {
	value = "${module.tomcat_application.endpoint}"
}
