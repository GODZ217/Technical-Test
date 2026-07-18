resource "google_cloud_run_service" "default" {
  name     = var.cloudrun_service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.cloudrun_image

        env {
          name  = "DB_HOST"
          value = google_sql_database_instance.postgres.private_ip_address
        }

        env {
          name  = "DB_NAME"
          value = google_sql_database.default.name
        }

        env {
          name  = "DB_USER"
          value = google_sql_user.default.name
        }

        env {
          name  = "DB_PASSWORD"
          value = google_sql_user.default.password
        }
      }

      vpc_access {
        connector = google_vpc_access_connector.serverless.id
        egress    = "PRIVATE_RANGES_ONLY"
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "5"
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.serverless.id
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    google_vpc_access_connector.serverless,
    google_sql_database_instance.postgres
  ]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "public" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
