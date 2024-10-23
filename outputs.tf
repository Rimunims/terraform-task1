output "cluster_endpoint" {
    description = "The endpoint of the GKE cluster"
    value = google_container_cluster.primary.endpoint

}
output "load_balancer_ip" {
    description = "The IP address of the load balancer"
    value = google_compute_global_address.resolver_global_ip.address
}
output "dns_name" {
    description = "The DNS name for the Universal Resolver application"
    value = "dev.uniresolver.io"
}
