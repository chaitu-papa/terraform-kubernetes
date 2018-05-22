resource "kubernetes_namespace" "mysql" {
  metadata {
    annotations {
      name = "${var.app-name}-annotations"
    }

    labels {
      mylabel = "${var.app-name}"
    }

    name = "${var.app-name}-${var.component}-${var.env-name}"
  }
}


resource "kubernetes_replication_controller" "mysql" {
  metadata {
    name = "${var.app-name}-${var.component}"
    namespace = "${var.app-name}-${var.component}-${var.env-name}"
    labels {
      App = "${var.app-name}-${var.component}"
    }
  }

  spec {
    replicas = 1
    selector {
      App = "${var.app-name}-${var.component}"
    }
    template {
      container {
        image = "ccsdevops/${var.app-name}:${var.app-version}"
        name  = "${var.app-name}-${var.component}"
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
    name = "${var.app-name}-${var.component}"
    namespace = "${var.app-name}-${var.component}-${var.env-name}"
  }
  spec {
    selector {
      App = "${kubernetes_replication_controller.mysql.metadata.0.labels.App}"
    }
    port {
      port = 3306
      target_port = 3306
    }
   
    type = "LoadBalancer"
  }
}
output "endpoint" {
  value = "${kubernetes_service.mysql.load_balancer_ingress.0.hostname}"
}
