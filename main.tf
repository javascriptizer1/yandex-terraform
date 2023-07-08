terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.94.0"
    }
  }
}

locals {
  folder_id   = "b1guhts3r44ndjbd7krn"
  cloud_id    = "b1gqd6irv18k48iucpd6"
  bucket_name = "testik-bucket"
  index       = "index.html"
}

provider "yandex" {
  cloud_id                 = local.cloud_id
  folder_id                = local.folder_id
  service_account_key_file = "./authorized_key.json"
}

// Create SA
resource "yandex_iam_service_account" "sa" {
  folder_id = local.folder_id
  name      = "tf-test-sa"
}

// Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.bucket_name
  acl        = "public-read"

  website {
    index_document = local.index
  }
}

resource "yandex_storage_object" "index" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.test.id
  acl        = "public-read"
  key        = local.index
  source     = "./site/${local.index}"
  tags = {
    test = "value"
  }
}

