
resource "kubernetes_namespace" "tomcat" {
  metadata {
    annotations {
      name = "${var.app-name}-annotations"
    }

    labels {
      mylabel = "${var.app-name}"
    }

    name = "${var.app-name}-${var.env-name}"
  }
}

resource "kubernetes_replication_controller" "tomcat" {
  metadata {
    name = "${var.app-name}"
    namespace = "${var.app-name}-${var.env-name}"
    labels {
      App = "${var.app-name}"
    }
  }

  spec {
    replicas = "${var.replicas}"
    selector {
      App = "${var.app-name}"
    }
    template {
      container {
        image = "docker.elastic.co/beats/filebeat:6.0.1"
        name  = "filebeat"
	env {
                name = "app_name"
                value = "${var.app-name}"
		}
	env {
                name = "app_version"
                value = "${var.app-version-id}"
		}
	env {
                name = "env_name"
                value = "${var.env-name}"
		}
	env {
                name = "elk_hostname"
                value = "34.196.120.121"
		}
	env {
                name = "elastic_port"
                value = "9200"
		}
	volume_mount {
             name = "share-folder"
             mount_path = "/usr/local/tomcat/logs"
        }
        resources {
          limits {
            cpu    = "0.25"
            memory = "256Mi"
          }
          requests {
            cpu    = "250m"
            memory = "50Mi"
          }
        }
        }
      container {
        image = "${var.docker-org}/${var.app-name}:${var.app-version-id}"
        name  = "${var.app-name}"
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
                value = "jdbc:mysql://${var.mysql-jdbc-host}:3306/petclinic?autoReconnect=true&characterEncoding=utf8&useUnicode=true&interactiveClient=true"
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
	volume_mount {
             name = "share-folder"
             mount_path = "/usr/local/tomcat/logs"
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
        volume {
        name = "share-folder"
        empty_dir {
	}
      }
      }
    }
  }
resource "kubernetes_service" "tomcat" {
  metadata {
    name = "${var.app-name}"
    namespace = "${var.app-name}-${var.env-name}"
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
output "endpoint" {
  value = "${kubernetes_service.tomcat.load_balancer_ingress.0.hostname}"
}
