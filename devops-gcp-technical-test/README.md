# DevOps GCP Technical Test

Production-like repository for a DevOps Engineer technical test featuring a containerized Node.js app deployed on Cloud Run with Infrastructure as Code (Terraform) and CI/CD (GitHub Actions).

## Architecture

```
┌──────────────────────────────────────────────────────┐
│                    Cloud Run                          │
│           hello-world-api (serverless)                │
│         ┌──────────────────────────────────┐          │
│         │  Node.js Express (port 8080)     │          │
│         │  / → "Hello World"              │          │
│         │  /healthz → 200 OK              │          │
│         └──────────┬───────────────────────┘          │
│                    │                                  │
│         Serverless VPC Access Connector               │
│                    │                                  │
├────────────────────┼──────────────────────────────────┤
│                    │                                  │
│         ┌──────────▼───────────────────────┐          │
│         │  Cloud SQL PostgreSQL             │          │
│         │  Private IP (VPC)                 │          │
│         └──────────────────────────────────┘          │
│                    VPC                                │
│         ┌──────────────────┐  ┌──────────────────┐    │
│         │  Public Subnet   │  │  Private Subnet  │    │
│         │  10.0.1.0/24     │  │  10.0.2.0/24     │    │
│         └──────────────────┘  └──────────────────┘    │
└──────────────────────────────────────────────────────┘
```

## Folder Structure

```
devops-gcp-technical-test/
├── app/                        # Node.js Express application
│   ├── Dockerfile
│   ├── package.json
│   ├── index.js
│   └── .dockerignore
├── cicd/                       # CI/CD pipeline configuration
│   └── github-actions/
│       └── cloudrun-deploy.yml
├── docs/                       # Documentation
│   ├── theoretical-answers.md
│   └── monitoring-alerting.md
├── iac/                        # Terraform infrastructure
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── network.tf
│   ├── cloudsql.tf
│   ├── cloudrun.tf
│   ├── main.tf
│   ├── terraform.tfvars.example
│   └── README.md
├── monitoring/                 # Monitoring configuration docs
│   ├── uptime-check.md
│   └── alert-policy.md
└── README.md
```

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- [Docker](https://docs.docker.com/get-docker/)
- GCP project with billing enabled
- GitHub repository with Actions enabled

## How to Provision Infrastructure (Terraform)

```bash
cd iac

cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your project ID and region

terraform init
terraform plan
terraform apply
```

## How to Run the Application Locally

```bash
cd app

npm install
npm start
```

The app will be available at `http://localhost:8080`.

```bash
curl http://localhost:8080
# Hello World

curl http://localhost:8080/healthz
# OK
```

## How to Deploy (CI/CD)

This repository uses GitHub Actions. On every push to the `main` branch, the pipeline:

1. Builds the Docker image from `app/`
2. Pushes it to Artifact Registry
3. Deploys it to Cloud Run

### Required GitHub Secrets

| Secret                | Description                              |
| --------------------- | ---------------------------------------- |
| `GCP_PROJECT_ID`      | Your GCP project ID                      |
| `GCP_SA_KEY`          | Service account JSON key (base64)        |
| `REGION`              | GCP region (e.g., `us-central1`)         |
| `SERVICE_NAME`        | Cloud Run service name                   |
| `ARTIFACT_REPOSITORY` | Artifact Registry repository name        |

### Manual Deploy

```bash
cd app

docker build -t gcr.io/<PROJECT_ID>/hello-world-api .
docker push gcr.io/<PROJECT_ID>/hello-world-api

gcloud run deploy hello-world-api \
  --image gcr.io/<PROJECT_ID>/hello-world-api \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated
```

## How to Delete Resources

```bash
cd iac
terraform destroy
```

> **Warning:** This will delete all resources created by Terraform, including the Cloud SQL database.

## Monitoring

See the [monitoring](./monitoring) directory for Uptime Check and Alert Policy configuration guides.
