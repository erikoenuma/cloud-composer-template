resource "google_compute_network" "composer_network" {
  name                    = var.NETWORK_NAME
  auto_create_subnetworks = false
  description             = "composer用ネットワーク"
}

resource "google_compute_subnetwork" "composer_subnet" {
  name                     = var.SUBNET_NAME
  ip_cidr_range            = var.CIDR_RANGE
  region                   = var.REGION
  network                  = google_compute_network.composer_network.id
  private_ip_google_access = true
  description              = "composer用サブネットワーク"
}

resource "google_compute_address" "nat_ip" {
  name    = "composer-nat-ip"
  address = var.NAT_IP_ADDRESS
  region  = var.REGION
}

resource "google_compute_router" "nat_router" {
  name        = "composer-nat-router"
  network     = google_compute_network.composer_network.id
  region      = var.REGION
  description = "composer用NATルーター"
}

resource "google_compute_router_nat" "nat_gw" {
  name   = "composer-nat-gw"
  router = google_compute_router.nat_router.name
  region = var.REGION

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

output "network-name" {
  value = google_compute_network.composer_network.name
}

output "subnet-name" {
  value = google_compute_subnetwork.composer_subnet.name
}
