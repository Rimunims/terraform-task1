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
    group = google_compute_instance_group.gke_nodes.self_link
  }
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
  



