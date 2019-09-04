#TF_LOG=DEBUG

variable "counts" { 
default = 2 
}


resource "openstack_compute_keypair_v2" "test-tf-keypair" {
  name = "test-tf-keypair"
}

resource "openstack_blockstorage_volume_v2" "test-tf-volume" {
  count = var.counts
  name = "${format("test-tf-volume-%02d",count.index+1)}"
  description = "this is a test tf volume  by rv965d"
  size = 10
}

resource "openstack_images_image_v2" "test-tf-rancheros" {

  name = "rancheros"
  disk_format = "qcow2"
  container_format = "bare"
  image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
}


resource "openstack_compute_flavor_v2" "test-tf-flavor" {
  name = "test-tf-flavor"
  ram = "1024"
  vcpus = "2"
  disk = "15"
  is_public = "true"
  extra_specs = {
    "hw:cpu_policy" = "dedicated"
    "hw:mem_page_size" = "large"
    "hw:numa_nodes" = "1"
    "hw:pci_numa_affinity_policy" = "dedicated"
  }

}

resource "openstack_objectstorage_container_v1" "container_1" {
  region = var.region
  name = "test-tf-container"
  metadata = {
    test = "true"
  }
  content_type = "application/json"
}

resource "openstack_objectstorage_object_v1" "doc_1" {
  region = var.region
  name = "test/default.json"
  container_name = "${openstack_objectstorage_container_v1.container_1.name}"
  metadata = {
    test = "true"
  }
  content_type = "application/json"
  content = <<JSON
          {
            "foo" : "bar"
          }
JSON
}

output "image_v2" {
  value =  "The image succesfully created is ${openstack_images_image_v2.test-tf-rancheros.name}"
}

output "compute_flavor" {
  value = "The compute flavor successfully created is ${openstack_compute_flavor_v2.test-tf-flavor.name}"
}

output "compute_keypair" {
  value = "The compute keypairs created are ${openstack_compute_keypair_v2.test-tf-keypair.name}"
}

output "blockstorage" {
  value = openstack_blockstorage_volume_v2.test-tf-volume[*].name
}

output "objectstorage_container" {
  value = "The object storage container created is ${openstack_objectstorage_container_v1.container_1.name}"
}
output "objectstorage_object" {
  value = "The object storage container object created is ${openstack_objectstorage_object_v1.doc_1.name}"
}
