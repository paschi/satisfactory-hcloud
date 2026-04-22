<div align="center">

# satisfactory-hcloud

[![Steam][badge-steam]][uri-steam]
[![OpenTofu][badge-opentofu]][uri-opentofu]
[![Hetzner][badge-hetzner]][uri-hetzner]

*Dockerized **Satisfactory** server running on **Hetzner Cloud** powered by **OpenTofu**.*

</div>

## ⚡️ Getting Started

First, install [OpenTofu][uri-opentofu-install] if you have not already.

As this project uses a remote backend for state management and stores backups in the cloud, you must first create an **S3-compatible bucket** (e.g. Hetzner Object Storage, Scaleway, ...) and create access and secret keys for it.

To be able to create resources in the Hetzner Cloud, you need to create an API token in your account.

To configure the remote state, create a file named `terraform.tfvars` with the following content:

```hcl
access_key = "<YOUR_BUCKET_ACCESS_KEY>"
secret_key = "<YOUR_BUCKET_SECRET_KEY>"
bucket     = "<YOUR_BUCKET_NAME>"
region     = "<YOUR_BUCKET_REGION>"
endpoint   = "<YOUR_BUCKET_ENDPOINT>"
```

Additionally, create a `terraform.tfvars` file to specify the required variables:

```hcl
hcloud_token      = "<YOUR_HCLOUD_ACCESS_TOKEN>"
hcloud_ssh_key    = "<YOUR_SSH_PUBLIC_KEY>"
backup_bucket     = "<YOUR_BUCKET_NAME>"
backup_access_key = "<YOUR_BUCKET_ACCESS_KEY>"
backup_secret_key = "<YOUR_BUCKET_SECRET_KEY>"
backup_provider   = "<YOUR_BUCKET_PROVIDER>"
backup_region     = "<YOUR_BUCKET_REGION>"
backup_endpoint   = "<YOUR_BUCKET_ENDPOINT>"
```

After that, initialize the OpenTofu configuration and deploy the resources:
```shell
$ tofu init -backend-config=terraform.tfvars
$ tofu apply
```

This will create all required resources and start the Satisfactory docker container. The IP address of the server can be found in the outputs section of the `tofu apply` command.

After you're done playing, you can tear down the infrastructure:
```shell
$ tofu destroy
```

## ⚙️ Configuration

The server and game settings can be configured by using a `terraform.tfvars` file or environment variables.

### 🌎 Server & Game
| Variable | Description | Default |
| --- | --- | --- |
| `hcloud_server_location` | Location of the cloud server (e.g., `fsn1`, `nbg1`). | `fsn1` |
| `hcloud_server_type` | Type of cloud server to use (e.g., `cpx42`). | `cpx42` |
| `game_image` | Docker image to use for the Satisfactory server. | `wolveix/satisfactory-server:latest` |
| `game_max_players` | Maximum number of players allowed. | `12` |

### 💾 Backups
This project supports automated backups to Hetzner Object Storage (or any S3-compatible storage).

| Variable | Description | Default |
| --- | --- | --- |
| `backup_bucket` | Name of the bucket for backups. | |
| `backup_provider` | Provider for the backup storage (e.g., `Hetzner`). | `Hetzner` |
| `backup_access_key` | Access key for the storage. | |
| `backup_secret_key` | Secret key for the storage. | |
| `backup_region` | Region of the storage. | `fsn1` |
| `backup_endpoint` | Endpoint URL for the storage. | `https://fsn1.your-objectstorage.com` |
| `backup_cron_schedule` | Cron schedule for the backup job. | `*/5 * * * *` |

[badge-hetzner]: https://img.shields.io/badge/Hetzner-D50C2D.svg?style=for-the-badge&logo=Hetzner&logoColor=white
[badge-opentofu]: https://img.shields.io/badge/OpenTofu-FF4E00.svg?style=for-the-badge&logo=OpenTofu&logoColor=white
[badge-steam]: https://img.shields.io/badge/Steam-000000.svg?style=for-the-badge&logo=Steam&logoColor=white
[uri-hetzner]: https://www.hetzner.com
[uri-opentofu]: https://opentofu.org
[uri-opentofu-install]: https://opentofu.org/docs/intro/install/
[uri-steam]: https://www.steampowered.com
