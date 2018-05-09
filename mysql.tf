resource "kubernetes_replication_controller" "mysql" {
  metadata {
    name = "spring-petclinic-mysql"
    namespace = "spring-petclinic-dev"
    labels {
      App = "spring-petclinic-mysql"
    }
  }

  spec {
    replicas = 1
    selector {
      App = "spring-petclinic-mysql"
    }
    template {
      container {
        image = "mysql"
        name  = "spring-petclinic-mysql"
	env {
                name = "MYSQL_ROOT_PASSWORD"
                value = "mypassword"
		}

        port {
          container_port = 3306
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

resource "kubernetes_service" "mysql" {
  metadata {
    name = "spring-petclinic-mysql"
    namespace = "spring-petclinic-dev"
  }
  spec {
    selector {
      App = "${kubernetes_replication_controller.tomcat.metadata.0.labels.App}"
    }
    port {
      port = 3306
      target_port = 3306
    }
   
    type = "LoadBalancer"
  }
}
