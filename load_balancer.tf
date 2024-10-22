resource "google_compute_global_address" "resolver_global_ip"{
     name = "resolver-lb-ip"
}
resource "google_compute_target_http_proxy" "http_proxy"{
  name = "resolver-http-proxy"
  url_map = google_compute_url_map.default.self_link
}
resource "google_compute_url_map" "default"{
  name = "resolver-url-map"
  default_service = google_compute_backend_service.default.self_link
}
resource "google_compute_backend_service" "default"{
  name = "resolver-backend"
  load_balancing_scheme = "EXTERNAL"
 # backend {
  #  group = google_compute_instance_group.default.self_link
  #} 
  health_checks = [google_compute_http_health_check.default.self_link]
}
resource "google_compute_http_health_check" "default"{
  name = "http-health-check"
  request_path = "/"
  check_interval_sec = 10
  timeout_sec = 5
  healthy_threshold = 2
  unhealthy_threshold = 2
}