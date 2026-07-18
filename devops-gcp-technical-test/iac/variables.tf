variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "technical-test-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "cloudsql_tier" {
  description = "Cloud SQL machine tier"
  type        = string
  default     = "db-f1-micro"
}

variable "cloudsql_postgres_version" {
  description = "PostgreSQL version for Cloud SQL"
  type        = string
  default     = "POSTGRES_15"
}

variable "cloudrun_service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "hello-world-api"
}

variable "cloudrun_image" {
  description = "Container image for Cloud Run"
  type        = string
}

variable "serverless_vpc_connector_name" {
  description = "Name of the Serverless VPC Access connector"
  type        = string
  default     = "serverless-connector"
}
