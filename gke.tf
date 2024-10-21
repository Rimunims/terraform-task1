resource "google_container_cluster" "primary" {
    name = "gke-cluster"
    location = "us-central1"

    node_pool {
        name = "default-pool"
        node_count = 2  # As per existing setup
        autoscaling {
            min_node_count = 1
            max_node_count = 5
        }
        node_config {
            machine_type = "n1-standard-2"  # Equivalent to m5.large (AWS)
            oauth_scopes = [
                "https://www.googleapis.com/auth/cloud-platform"
            ]
        }
    }
    networking_mode = "VPC_NATIVE"
}