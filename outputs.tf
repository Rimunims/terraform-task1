output "instance_ips" {
    description = "The external IPs of the compte engine isntances running docker compose"
    value = google_compute_instance.resolver_instance[*].network_interface[0].access_config[0].nat_ip

}
output "load_balancer_ip" {
    description = "The IP address of the load balancer"
    value = google_compute_global_address.resolver_global_ip.address
}
output "dns_name" {
    description = "The DNS name for the Universal Resolver application"
    value = "dev.uniresolver.io"
}
output "gce_instance_names" {
    description = "The names of the Compute Engine instances running Docker Compose"
    value = google_compute_instance.resolver_instance[*].name
}