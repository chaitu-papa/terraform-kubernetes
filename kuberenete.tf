provider "kubernetes" {
  host     = "https://api.kubernetes.devops-coe-cts.com"
  username = "admin"
  password = "ZpvS6H8ODjKhpvBdZGDs3oeIgHKjkqBk"
  insecure = "true"
}
resource "kubernetes_namespace" "tomcat" {
  metadata {
    annotations {
      name = "spring-petclinic-annotations"
    }

    labels {
      mylabel = "spring-petclinic"
    }

    name = "spring-petclinic-dev"
  }
}

resource "kubernetes_replication_controller" "tomcat" {
  metadata {
    name = "spring-petclinic"
    namespace = "spring-petclinic-dev"
    labels {
      App = "spring-petclinic"
    }
  }

  spec {
    replicas = 2
    selector {
      App = "spring-petclinic"
    }
    template {
      container {
        image = "ccsdevops/spring-petclinic:29"
        name  = "spring-petclinic"
	env {
                name = "db_script"
                value = "mysql"
		}
	env {
                name = "jdbc_driverClassName"
                value = "com.mysql.jdbc.Driver"
		}
	env {
                name = "jdbc_url"
                value = "jdbc:mysql://spring-petclinic-mysql:3306/petclinic?useUnicode=true"
		}
	env {
                name = "jdbc_username"
                value = "root"
		}
	env {
                name = "jdbc_password"
                value = "mypassword"
        	}

        port {
          container_port = 8080
        }

        resources {
          limits {
            cpu    = "0.5"
            memory = "512Mi"
          }
          requests {
            cpu    = "250m"
            memory = "50Mi"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "tomcat" {
  metadata {
    name = "spring-petclinic"
    namespace = "spring-petclinic-dev"
  }
  spec {
    selector {
      App = "${kubernetes_replication_controller.tomcat.metadata.0.labels.App}"
    }
    port {
      port = 8080
      target_port = 8080
    }
   
    type = "LoadBalancer"
  }
}
output "lb_ip" {
  value = "${kubernetes_service.tomcat.load_balancer_ingress.0.ip}"
}
