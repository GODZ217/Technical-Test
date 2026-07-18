# This file is intentionally sparse. Resources are organized by concern:
#   - provider.tf  : Provider and backend configuration
#   - network.tf   : VPC, subnets, and VPC Access Connector
#   - cloudsql.tf  : Cloud SQL PostgreSQL instance, database, and user
#   - cloudrun.tf  : Cloud Run service and IAM policy
#
# This separation keeps each file focused and easy to maintain.
