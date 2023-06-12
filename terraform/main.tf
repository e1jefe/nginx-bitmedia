provider "digitalocean" {
  token = var.DIGITALOCEAN_API_TOKEN
}

resource "digitalocean_droplet" "web_server" {
  image  = "ubuntu-20-04-x64"  # Specify the desired image
  name   = "web_server"
  region = "fra1"  # Specify the desired region

  ssh_keys = [
    var.SSH_KEY_FINGERPRINT,
  ]

  size = "s-1vcpu-1gb"  # Specify the desired droplet size
}