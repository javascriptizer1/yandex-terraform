output "network_id" {
  value = yandex_vpc_network.mynet.id
}

output "sg_internal" {
  value = yandex_vpc_security_group.internal.id
}

output "sg_k8s_master" {
  value = yandex_vpc_security_group.k8s_master.id
}

output "sg_k8s_worker" {
  value = yandex_vpc_security_group.k8s_worker.id
}

output "k8s_masters_subnet_info" {
  value = [for k, v in var.subnets["k8s_masters"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-main[v.name].id, yandex_vpc_subnet.subnet-main[v.name].zone])]
}

output "k8s_workers_subnet_info" {
  value = [for k, v in var.subnets["k8s_workers"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-main[v.name].id, yandex_vpc_subnet.subnet-main[v.name].zone])]
}
