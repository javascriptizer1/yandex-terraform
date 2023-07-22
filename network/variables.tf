variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "network_state_key" {
  description = "S3 key for network state"
  type        = string
}

variable "default_zone" {
  description = "Default zone"
  type        = string
  default     = "ru-central1-a"
}

variable "network_name" {
  description = "Name of main network"
  type        = string
}

variable "subnets" {
  description = "Subnets for K8S"
  type = map(list(object({
    name = string,
    zone = string,
    cidr = list(string)
  })))

  validation {
    condition     = alltrue([for i in keys(var.subnets) : alltrue([for j in lookup(var.subnets, i) : contains(["ru-central1-a", "ru-central1-b", "ru-central1-c"], j.zone)])])
    error_message = "Error! Zones not supported!"
  }
}

variable "white_ips_for_master" {
  type = list(string)
}

variable "external_static_ips" {
  description = "static ips"

  type = map(list(object(
    {
      name = string,
      zone = string
    }))
  )
}
