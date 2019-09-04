#terraform openstack provider 
#TF_LOG=DEBUG

variable "user_name" {}
variable "tenant_id" {}
variable "password" {}
variable "user_domain_name" {}
variable "auth_url" {}
variable "region" {}

provider "openstack" {
  auth_url = var.auth_url
  user_domain_name = var.user_domain_name
  region = var.region
  tenant_id = var.tenant_id
  user_name = var.user_name
  password = var.password
}

output "terraform-provider" {
  value = "connected with openstack at ${var.auth_url}"
}
