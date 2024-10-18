resource "google_dns_managed_zone" "resolver-zone"{
    name = "resolver-zone"
    dns_name = "uniresolver.io."
}
resource "google_dns_record_set" "resolver-dns" {
    name = "dev.uniresolver.io."
    type = "A"
    ttl = 300
    managed_zone = google_dns_managed_zone.resolver-zone.name

    rrdatas = [google_compute_global_address.lb_ip.address]
}