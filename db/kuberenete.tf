provider "kubernetes" {
  host     = "https://api.kubernetes.devops-coe-cts.com"
  username = "admin"
  password = "ZpvS6H8ODjKhpvBdZGDs3oeIgHKjkqBk"
  insecure = "true"
}
module "mysql_db" {
	source = "../modules/mysql-db"
	app-name = "petclinicdatabase"
	env-name = "dev"
	app-version = "1.0"
	component = "mysql"
}
output "mysql_endpoint" {
	value = "${module.mysql_db.endpoint}"
}
