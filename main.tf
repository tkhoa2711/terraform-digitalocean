provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "personal" {
  name = var.do_ssh_key_name
}

data "digitalocean_sizes" "web" {
  filter {
    key    = "vcpus"
    values = [1]
  }

  filter {
    key    = "memory"
    values = [1024]
  }

  filter {
    key    = "regions"
    values = ["sgp1"]
  }

  sort {
    key       = "price_monthly"
    direction = "asc"
  }
}

resource "digitalocean_droplet" "web" {
  ssh_keys = [data.digitalocean_ssh_key.personal.id]
  image    = "ubuntu-18-04-x64"
  name     = "web"
  region   = "sgp1"

  # https://developers.digitalocean.com/documentation/v2/#list-all-sizes
  # size = "s-1vcpu-1gb" # $5.0/month
  size = data.digitalocean_sizes.web.sizes[0].slug

  provisioner "remote-exec" {
    inline = [
      "sudo adduser --disabled-password --gecos '' ${var.username}",
      "sudo mkdir -p /home/${var.username}/.ssh",
      "sudo touch /home/${var.username}/.ssh/authorized_keys",
      "sudo echo '${file(var.user_public_key)}' > /home/${var.username}/.ssh/authorized_keys",
      "sudo chmod 0600 /home/${var.username}/.ssh/authorized_keys",
      "sudo chown -R ${var.username}:${var.username} /home/${var.username}/.ssh",
      "sudo usermod -aG sudo ${var.username}",
    ]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key)
      timeout     = "2m"
    }
  }
}
