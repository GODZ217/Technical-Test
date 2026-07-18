resource "random_password" "db_password" {
  length  = 16
  special = false
}

resource "google_sql_database_instance" "postgres" {
  name             = "technical-test-postgres"
  database_version = var.cloudsql_postgres_version
  region           = var.region

  settings {
    tier = var.cloudsql_tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
    }

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "default" {
  name     = "appdb"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "default" {
  name     = "appuser"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_password.result
}
