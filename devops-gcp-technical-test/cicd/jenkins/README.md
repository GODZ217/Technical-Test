# Jenkins Pipeline - Cloud Run Deploy

This pipeline does the same steps as the GitHub Actions version:

1. Checkout code
2. Authenticate to GCP via service account key
3. Configure gcloud and Docker for Artifact Registry
4. Build Docker image from `app/`
5. Push to Artifact Registry
6. Deploy to Cloud Run

## Prerequisites in Jenkins

### Required Plugins

- Pipeline
- Credentials Binding
- Google Cloud SDK (installed on agent)

### Jenkins Credentials

| ID               | Type          | Description                              |
| ---------------- | ------------- | ---------------------------------------- |
| `GCP_PROJECT_ID`  | Secret text   | Your GCP project ID                      |
| `GCP_SA_KEY`      | Secret file   | Service account JSON key                 |
| `REGION`          | Secret text   | GCP region (e.g., `us-central1`)         |
| `SERVICE_NAME`    | Secret text   | Cloud Run service name                   |
| `ARTIFACT_REPOSITORY` | Secret text | Artifact Registry repository name        |

## Usage

- Create a **Multibranch Pipeline** job pointing to this repository.
- The `Jenkinsfile` is picked up automatically from the branch.
- Alternatively, create a **Pipeline** job and point it to `cicd/jenkins/Jenkinsfile` in SCM.
