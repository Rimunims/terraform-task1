resource "google_dns_managed_zone" "resolver-zone"{
    name = "universal-resolver-zone"
    dns_name = "universal-did-resolver"
}
resource "google_dns_record_set" "resolver-dns" {
    name = "universal-did-resolver"
    type = "A"
    ttl = 300
    managed_zone = google_dns_managed_zone.resolver-zone.name

    rrdatas = [google_compute_global_address.resolver_global_ip.address]
}