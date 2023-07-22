terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.94.0"
    }
  }
  backend "s3" {
    endpoint                = "storage.yandexcloud.net"
    region                  = "ru-central1"
    bucket                  = "testik-terraform"
    key                     = "k8s_terraform.tfstate"
    shared_credentials_file = "storage.key"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
}
