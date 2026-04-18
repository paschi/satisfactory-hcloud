variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "hcloud_server_location" {
  type    = string
  default = "fsn1"
}

variable "hcloud_server_type" {
  type    = string
  default = "cpx42"
}

variable "hcloud_ssh_key" {
  type      = string
  sensitive = true
}

variable "game_image" {
  type    = string
  default = "wolveix/satisfactory-server:latest"
}

variable "game_max_players" {
  type    = number
  default = 12
}

variable "backup_bucket" {
  type = string
}

variable "backup_provider" {
  type    = string
  default = "Hetzner"
}

variable "backup_access_key" {
  type      = string
  sensitive = true
}

variable "backup_secret_key" {
  type      = string
  sensitive = true
}

variable "backup_endpoint" {
  type    = string
  default = "https://fsn1.your-objectstorage.com"
}

variable "backup_region" {
  type    = string
  default = "fsn1"
}

variable "backup_cron_schedule" {
  type    = string
  default = "*/5 * * * *"
}
