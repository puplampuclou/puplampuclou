terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.8.0"
    }
  }
}

provider "google" {
#  credentials = file("/home/rodneyadmin/apigee-anthos-lab-01-8b398c25ec72.json")
  credentials = file(var.credentials_file)

#  project = "apigee-anthos-lab-01"
#  region  = "us-central1"
#  zone    = "us-central1-c"
   project = var.project
   region  = var.region
   zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
