# nginx-bitmedia
**Nginx-bitmedia test task**

The code creates a droplet in digitalocean using terraform, builds a docker image, configures and deploys an Nginx server with an inscription on the start page using ansible and docker compose.

## Required
[Docker](https://docs.docker.com/get-docker/), [Terraform](https://developer.hashicorp.com/terraform/downloads), [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
Worked with: Docker version 23.0.5, Terraform v1.4.4, Ansible core 2.15.0. Tested MacOS 13.4
## Setup

1) Retrieve your API key from [DigitalOcean]( https://cloud.digitalocean.com/account/api/tokens)
   
**Note**: If you haven't already, you'll have to create an account and set up billing.

2) Get your DigitalOcean SSH key fingerprint [DigitalOcean]( https://cloud.digitalocean.com/account/security)
3) Get your DockerHub username  [DockerHub](https://docs.docker.com/docker-id/)
4) Get your DockerHub access token  [DockerHub](https://hub.docker.com/settings/security)

5) Export credentials to env.

```
export TF_VAR_do_token=<Digitalocean token, i.e. dop_v1_12345>
export TF_VAR_ssh_key_fingerprint= <Digitalocean fingerprint, i.e. cb:98:63:cf>
export DOCKERHUB_ACCESS_TOKEN= <DockerHub access token, i.e. dckr_pat_foo_bar>
export DOCKERHUB_USERNAME= <Dockerhub username, i.e. username>
```
6) Clone repository and run `./start.sh`