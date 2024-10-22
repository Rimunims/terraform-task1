resource "google_compute_instance" "resolver_instance" {
    count = 2          # Deploy two instances similar to m5.large instance
    name = "resolver-instance-${count.index}"
    machine_type = "e2-standard-4"
    zone = var.zone

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11" 
      }
    }
    
    network_interface {
      subnetwork = var.subnetwork
      access_config {
        # Ephemeral ip for external access
      }
    }

    tags = ["http-server","https-server"]

    # loading the bash script from external file 
    metadata_startup_script = file("${path.module}/startup-script.sh") 
}

