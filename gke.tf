resource "google_container_cluster" "primary" {
  name = "universal-resolver-cluster"
  location = var.region
  initial_node_count = 1

  node_locations = ["us-central1-a","us-central1-b"]

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_container_node_pool" "primary_nodes" {
  cluster = google_container_cluster.primary.name
  node_count = 3

  node_config {
    machine_type = "e2-standard-4"
    oauth_scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/servicecontrol"
    ]
   # subnetwork = var.subnetwork
  }
  management {
    auto_repair = true
    auto_upgrade = true
  }
}