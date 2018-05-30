provider "kubernetes" {
  host     = "${var.k8s-api}"
  username = "${var.k8s-username}"
  password = "${var.k8s-password}"
  insecure = "true"
}
module "tomcat_application" {
	source = "../modules/tomcat-app"
	docker-org = "${var.docker-org}"
	app-name = "${var.app-name}"
	env-name = "${var.env-name}"
	app-version-id = "${var.app-version-id}"
	mysql-jdbc-host = "${var.mysql-jdbc-host}"
}
output "application_endpoint" {
	value = "${module.tomcat_application.endpoint}"
}

