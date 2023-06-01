# main.tf
provider "google" {
  credentials = file(env("GOOGLE_CREDENTIALS"))
  project = "unique-magpie-388510"
  region  = "us-central1"
  zone    = "us-central1-c"
}

module "gke" {
  source = "terraform-google-modules/kubernetes-engine/google"
  version = "~> 13.0"

  project_id = "unique-magpie-388510"
  name = "my-gke-cluster"
  region = "us-central1"
  network = "default"
  subnetwork = "default"
  ip_range_pods = "default"
  ip_range_services = "default"

  node_pools = [
    {
      name = "default-node-pool"
      machine_type = "n1-standard-1"
      min_count = 1
      max_count = 10
      disk_size_gb = 100
      disk_type = "pd-standard"
      image_type = "COS"
      auto_repair = true
      auto_upgrade = true
    }
  ]

  node_pools_oauth_scopes = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]

  network_policy = {
    enabled = true
    provider = "CALICO"
  }

  depends_on = [google_project_service.container]
}
