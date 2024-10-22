resource "kubernetes_deployment" "universal_resolver" {
  metadata {
    name = "universal-resolver"
    labels = {
        app = "universal-resolver"
    }
  }

  spec {
    replicas = 2

    selector {
        match_labels = {
          app = "universal-resolver"
        }
    }

    template {
      metadata {
        labels = {
            app = "universal-resolver"
        }
      }

      spec {
        container {
            name = "resolver"
            image = "universalresolver/driver-did-btcr:latest"
            port  {
                container_port = 8080
            }

            resources {
                requests = {
                  memory = "512Mi"
                  cpu = "500m"
                }
               # limits {
                #    memory = "1Gi"
                 #   cpu = "1000m"
                #}
            }
        }
      }
    }
  }
}

resource "kubernetes_service" "resolver_service" {
    metadata{
        name = "universal-resolver-service"
        labels = {
            app = "universal-resolver"
        }
    }

    spec {
        selector = {
            app = "universal-resolver"
        }

        port {
            port = 80
            target_port = 8080
        }
        type = "NodePort"
    }
}

resource "kubernetes_ingress" "resolver_ingress" {
    metadata {
        name = "resolver-ingress"
        annotations = {
            "kubernetes.io/ingress.class" = "gce"
        }
    }
    spec {
        backend{
          service_name = kubernetes_service.resolver_service.metadata[0].name   
          service_port = 80
        }
    }

}


  
