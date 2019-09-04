resource "openstack_compute_instance_v2" "compute_1" {
  name = "labops-compute-lrt-tf-vserver1"
  flavor_id = "${openstack_compute_flavor_v2.test-tf-flavor.id}"
  image_id = "${openstack_images_image_v2.test-tf-rancheros.id}"
  key_pair = "${openstack_compute_keypair_v2.test-tf-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_1.name}"]
  network {
    name = "${openstack_networking_network_v2.network_1.name}"
  } 
}

resource "openstack_compute_interface_attach_v2" "ai_to_vm_1" {
  depends_on = ["openstack_compute_instance_v2.compute_1"] 
  instance_id = "${openstack_compute_instance_v2.compute_1.id}"
  port_id = "${openstack_networking_port_v2.port_1.id}"
}

resource "openstack_compute_volume_attach_v2" "va_1" {
  count = var.counts
  instance_id = "${openstack_compute_instance_v2.compute_1.id}"
  volume_id = "${openstack_blockstorage_volume_v2.test-tf-volume.*.id[count.index]}"
}

resource "openstack_compute_instance_v2" "sriov_compute" {
  depends_on = ["openstack_networking_port_v2.sriov_port1"]
  name = "labops-compute-lrt-tf-sriov-server"
  flavor_id = "${openstack_compute_flavor_v2.test-tf-flavor.id}"
  image_id = "${openstack_images_image_v2.test-tf-rancheros.id}"
  key_pair = "${openstack_compute_keypair_v2.test-tf-keypair.name}"
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_1.name}"]
  network {
    name = "${openstack_networking_network_v2.sriov_network_1.name}"
    port = "${openstack_networking_port_v2.sriov_port1.id}"
  }
}  

resource "openstack_compute_instance_v2" "multi_vm-tf" {
  count = 3
  name = "${format("multi_vm-tf-%02d", count.index+1)}"
  flavor_id = "${openstack_compute_flavor_v2.test-tf-flavor.id}"
  image_id = "${openstack_images_image_v2.test-tf-rancheros.id}"
  key_pair = "${openstack_compute_keypair_v2.test-tf-keypair.name}"
  security_groups =  ["${openstack_compute_secgroup_v2.secgroup_1.name}"]
  network {
    name = "${openstack_networking_network_v2.network_1.name}"
  }
}


output "compute_1" {
  value = "Terraform succesfully created vserver ${openstack_compute_instance_v2.compute_1.name} using the image, keypair, flavor, network, port , security-group and attached 2 block storage devices"

}

output "sriov_compute_1" {
  value = "Terraform succesfully created a sriov vm ${openstack_compute_instance_v2.sriov_compute.name} using the image, keypair, flavor, security-group and network ${openstack_networking_network_v2.sriov_network_1.name} attached"
}

output "multi_vm" {
  value = openstack_compute_instance_v2.multi_vm-tf[*].name
}
