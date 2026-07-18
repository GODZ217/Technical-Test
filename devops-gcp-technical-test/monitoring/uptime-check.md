# Uptime Check Configuration

## Target

- **URL:** `https://<cloud-run-url>/healthz`
- **Check Interval:** 1 minute
- **Check Type:** HTTPS GET

## Steps (via Cloud Console)

1. Go to **Cloud Monitoring > Uptime Checks**.
2. Click **Create Uptime Check**.
3. Fill in:
   - **Title:** `hello-world-api-uptime`
   - **Hostname:** `<cloud-run-url>` (without protocol)
   - **Path:** `/healthz`
   - **Check Interval:** 1 minute
4. Click **Create**.

## Steps (via gcloud)

```bash
gcloud monitoring uptime-check-configs create \
  --display-name="hello-world-api-uptime" \
  --resource-type=uptime-url \
  --host=<cloud-run-url> \
  --http-check-path=/healthz \
  --period=60s \
  --timeout=10s
```
