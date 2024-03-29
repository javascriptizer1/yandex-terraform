resource "yandex_kubernetes_cluster" "k8s-regional" {
  network_id              = local.network_output.network_id
  network_policy_provider = var.network_policy_provider
  master {
    version   = var.master_version
    public_ip = true
    regional {
      region = "ru-central1"
      dynamic "location" {
        for_each = local.network_output.k8s_masters_subnet_info
        content {
          zone      = location.value["zone"]
          subnet_id = location.value["subnet_id"]
        }
      }
    }
    security_group_ids = [local.network_output.sg_internal, local.network_output.sg_k8s_master]
  }
  service_account_id      = yandex_iam_service_account.myaccount.id
  node_service_account_id = yandex_iam_service_account.myaccount.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}
