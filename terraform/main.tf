// GCP

// google storage
resource "google_storage_bucket" "data-lake-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

// bigquery dataset
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  project    = var.project_id
  location   = var.location
  delete_contents_on_destroy=true

}

// Airbyte Terraform provider documentation: https://registry.terraform.io/providers/airbytehq/airbyte/latest/docs

// Sources
resource "airbyte_source_google_sheets" "googlesheets" {
  configuration = {
    batch_size = 8
    credentials = {
      service_account_key_authentication = {
        service_account_info = file(var.credentials_json_path)
      }
    }
    names_conversion = false
    spreadsheet_id   = var.spreadsheet_id
  }
  name          = var.source_name
  workspace_id  = var.workspace_id
}

// Destinations
resource "airbyte_destination_bigquery" "bigquery" {
  configuration = {
    dataset_id       = google_bigquery_dataset.dataset.dataset_id
    dataset_location = google_bigquery_dataset.dataset.location
    destination_type = "bigquery"
    project_id       = google_bigquery_dataset.dataset.project
    credentials_json = file(var.credentials_json_path)
    loading_method = {
      gcs_staging = {
        credential = {
          hmac_key = {
            hmac_key_access_id = var.hmac_key_access_id
            hmac_key_secret    = var.hmac_key_secret
          }
        }
        gcs_bucket_name          = google_storage_bucket.data-lake-bucket.name
        gcs_bucket_path          = var.gcs_bucket_path
        keep_files_in_gcs_bucket = "Delete all tmp files from GCS"
      }
      
    }
  }
  name         = var.destination_name
  workspace_id = var.workspace_id
}

// Connections
resource "airbyte_connection" "National_Rail_Data" {
  name           = var.connection_name
  source_id      = airbyte_source_google_sheets.googlesheets.source_id
  destination_id = airbyte_destination_bigquery.bigquery.destination_id
  configurations = {
    streams = [
      {
        name = "railway"
      },
     
    ]
  }
}