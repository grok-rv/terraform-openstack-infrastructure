# terraform-openstack-infrastructure
This is a terraform project repo to create and destroy bare minimum OpenStack Compute, Network and Storage resources to verify the site is operational for end users to access after any recovery efforts.

Terraform v0.12.6
+ provider.openstack v1.21.1

Outputs:

blockstorage = [
  "test-tf-volume-01",
  "test-tf-volume-02",
]
compute_1 = Terraform succesfully created vserver labops-compute-lrt-tf-vserver1 using the image, keypair, flavor, network, port , security-group and attached 2 block storage devices

compute_flavor = The compute flavor successfully created is test-tf-flavor

compute_keypair = The compute keypairs created are test-tf-keypair

image_v2 = The image succesfully created is rancheros

multi_vm = [
  "multi_vm-tf-01",
  "multi_vm-tf-02",
  "multi_vm-tf-03",
]

network_1 = Terraform succesfully created network labops-compute-lrt-tf-network_1

objectstorage_container = The object storage container created is test-tf-container

objectstorage_object = The object storage container object created is test/default.json

port_1 = Terraform successfully created port labops-compute-lrt-tf-port_1

secgroup_1 = Terraform succesfully created security group labops-compute-lrt-tf-secgroup_1

sriov_compute_1 = Terraform succesfully created a sriov vm labops-compute-lrt-tf-sriov-server using the image, keypair, flavor, security-group and network labops-compute-lrt-tf-sriov-network_1 attached

sriov_network_1 = Terraform succesfully created sriov network labops-compute-lrt-tf-sriov-network_1

sriov_port_1 = Terraform succesfully created sriov port labops-compute-lrt-tf-sriov-port_1

sriov_subnet_1 = Terraform succesfully created sriov subnet labops-compute-lrt-tf-sriov-subnet_1

subnet_1 = Terraform succesfully created subnet labops-compute-lrt-tf-subnet_1

terraform-provider = connected with openstack at https://identity-url:443/v3
