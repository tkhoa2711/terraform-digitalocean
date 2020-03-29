output "public_ip" {
  value = "${digitalocean_droplet.web.ipv4_address}"
}

output "price_monthly" {
  value = "${data.digitalocean_sizes.web.sizes.0.price_monthly}"
}

output "name" {
  value = "${digitalocean_droplet.web.name}"
}
