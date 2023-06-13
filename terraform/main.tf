# Specify the Terraform provider to use
provider "digitalocean" {
  token = var.do_token
}
# Setup a DO droplet
resource "digitalocean_droplet" "web-server" {
  image  = var.droplet_image
  name   = "web-server"
  region = var.region
  size   = var.droplet_size
  ssh_keys = [
    var.ssh_key_fingerprint,
  ]
  user_data = <<-EOF
    #!/bin/bash
    adduser nginx-bitmedia --disabled-password --gecos ''
    usermod -aG sudo nginx-bitmedia
    echo 'nginx-bitmedia ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/90-cloud-init-users
    mkdir /home/nginx-bitmedia/.ssh
    cp /root/.ssh/authorized_keys /home/nginx-bitmedia/.ssh/
    chown -R nginx-bitmedia:nginx-bitmedia /home/nginx-bitmedia/.ssh
  EOF
}

# Output the public IP address of the new droplet
output "public_ip_server" {
  value = digitalocean_droplet.web-server.ipv4_address
}