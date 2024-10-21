resource "google_compute_instance_template" "gke_template"{
    name = "gke-template"
    machine_type = "n1-standard-1"
    disk {
      boot =true
      auto_delete = true
      source_image = "debian-cloud/debian-11"
    }
    network_interface {
      network = "default"
      access_config {

      }

    }
}

resource "google_compute_instance_group_manager" "gke_nodes" {
  name = "gke-nodes"
  zone = "us-central1-a"
  base_instance_name = "gkeinstance"
  version{
    instance_template = google_compute_instance_template.gke_template.self_link
  }
  target_size = 1
}

resource "google_compute_global_address" "lb_ip" {
  name = "lb-ip"
}

resource "google_compute_target_pool" "resolver-pool" {
 name = "resolver-pool" 
}

resource "google_compute_backend_service" "resolver-backend" {
  name = "resolver-backend"
  protocol = "HTTP"
  port_name = "http"
  timeout_sec = 30

  backend {
    group = google_compute_instance_group_manager.gke_nodes.instance_group
  }
  health_checks = [google_compute_http_health_check.resolver-health-check.self_link]
}

resource "google_compute_http_health_check" "resolver-health-check" {
    name = "resolver-health-check"
    request_path = "/"
    check_interval_sec = 30
    timeout_sec = 10
    healthy_threshold = 1
    unhealthy_threshold = 10
}

resource "google_compute_url_map" "resolver-url-map" {
  name = "resolver-url-map"
  default_service = google_compute_backend_service.resolver-backend.self_link
}

resource "google_compute_global_forwarding_rule" "resolver-forwarding-rule" {
    name = "resolver-forwarding-rule"
    target = google_compute_target_http_proxy.resolver-http-proxy.self_link
    port_range = "80"
    ip_address = google_compute_global_address.lb_ip.address  
}

resource "google_compute_target_http_proxy" "resolver-http-proxy" {
    name = "resolver-http-proxy"
    url_map = google_compute_url_map.resolver-url-map.self_link
}
  

 



