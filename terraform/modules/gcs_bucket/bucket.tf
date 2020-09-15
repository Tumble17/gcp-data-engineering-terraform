resource "google_storage_bucket" "example_bucket" {
  name = "gcp-data-eng-${var.identifier}"
}