variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "default_zone" {
  description = "Default zone"
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_name" {
  description = "Service account name"
  type        = string
}

variable "kms_provider_key_name" {
  description = "KMS key name"
  type        = string
  default     = null
}

variable "network_state_key" {
  description = "S3 key for network state"
  type        = string
}

variable "cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
}

variable "network_policy_provider" {
  description = "Cluster network policy provider"
  type        = string
  default     = "CALICO"
}

variable "master_version" {
  description = "Kubernetes version"
  type        = string
  default     = null
}

variable "master_public_ip" {
  description = "Boolean flag. When true, Kubernetes master will have a visible ipv4 address."
  type        = bool
  default     = true
}

variable "master_region" {
  description = "Name of region where cluster will be created. Required for regional cluster, not used for zonal cluster."
  type        = string
  default     = null
}

variable "node_groups" {
  description = "Parameters of Kubernetes node groups."
  default     = {}
}
