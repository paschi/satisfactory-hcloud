resource "hcloud_firewall" "satisfactory_firewall" {
  name = "satisfactory-firewall"
  rule {
    direction = "in"
    port      = "7777"
    protocol  = "tcp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    port      = "7777"
    protocol  = "udp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    port      = "8888"
    protocol  = "tcp"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_ssh_key" "satisfactory_ssh_key" {
  name       = "satisfactory-ssh-key"
  public_key = var.hcloud_ssh_key
}

resource "hcloud_server" "satisfactory_server" {
  name         = "satisfactory-server"
  image        = "docker-ce"
  location     = var.hcloud_server_location
  server_type  = var.hcloud_server_type
  firewall_ids = [hcloud_firewall.satisfactory_firewall.id]
  ssh_keys     = [hcloud_ssh_key.satisfactory_ssh_key.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    game_image           = var.game_image
    game_max_players     = var.game_max_players
    backup_bucket        = var.backup_bucket
    backup_provider      = var.backup_provider
    backup_access_key    = var.backup_access_key
    backup_secret_key    = var.backup_secret_key
    backup_region        = var.backup_region
    backup_endpoint      = var.backup_endpoint
    backup_cron_schedule = var.backup_cron_schedule
  })
}
