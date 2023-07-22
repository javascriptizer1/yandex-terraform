data "yandex_vpc_network" "mynet" {
  name = "mynet"
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    endpoint                = "storage.yandexcloud.net"
    region                  = "ru-central1"
    bucket                  = "testik-terraform"
    key                     = var.network_state_key
    shared_credentials_file = "storage.key"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
