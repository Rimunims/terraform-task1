resource "google_container_cluster" "primary" {
  name = "universal-resolver-cluster"
  location = var.region
  initial_node_count = 3

  node_locations = ["us-central1-a","us-central1-b","us-central1-c"]

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
}