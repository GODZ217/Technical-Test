# Terraform - GCP Infrastructure

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- GCP project with billing enabled
- Service account with the following roles:
  - `roles/compute.admin`
  - `roles/cloudsql.admin`
  - `roles/run.admin`
  - `roles/iam.serviceAccountUser`
  - `roles/vpcaccess.admin`

## Usage

```bash
# 1. Copy and fill in variables
cp terraform.tfvars.example terraform.tfvars

# 2. Initialize Terraform
terraform init

# 3. Review the plan
terraform plan

# 4. Apply
terraform apply

# 5. Destroy when done
terraform destroy
```

## Resources Created

| Resource                   | Name                                |
| -------------------------- | ----------------------------------- |
| VPC                        | `technical-test-vpc`                |
| Public Subnet              | `technical-test-vpc-public`         |
| Private Subnet             | `technical-test-vpc-private`        |
| Serverless VPC Connector   | `serverless-connector`              |
| Cloud SQL PostgreSQL       | `technical-test-postgres`           |
| Cloud Run Service          | `hello-world-api`                   |

## Outputs

After apply, Terraform will output:

- `cloud_run_url` - The URL of the deployed Cloud Run service
- `cloud_sql_connection_name` - The Cloud SQL instance connection name
- `cloud_sql_private_ip` - The private IP of the Cloud SQL instance
