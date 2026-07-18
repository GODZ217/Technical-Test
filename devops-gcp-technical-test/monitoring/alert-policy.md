# Alert Policy Configuration

## Condition

- **Metric:** `uptime_check/response_code`
- **Condition:** Response code != 200
- **Duration:** 5 minutes (consecutive)
- **Alignment:** `rate` (1 minute window)

## Notification Channels

- Email
- Slack (optional)

## Steps (via Cloud Console)

1. Go to **Cloud Monitoring > Alerting > Create Policy**.
2. Click **Add Condition**, then select **Uptime Check** -> pick the previously created uptime check.
3. Configure condition:
   - **Condition Type:** Metric threshold
   - **Filter:** `uptime_check_id = <your-uptime-check-id>`
   - **Rolling window:** 1 min
   - **Condition:** `metric.response_code != 200`
   - **For:** 5 minutes
4. Click **Add**.
5. Under **Notifications**, add Email and/or Slack notification channel.
6. Name the policy (e.g., `hello-world-api-alert`) and click **Create**.

## Steps (via gcloud)

```bash
gcloud monitoring alert-policies create \
  --display-name="hello-world-api-alert" \
  --condition-display-name="Response code != 200 for 5 minutes" \
  --condition-filter='resource.type="uptime_url" AND metric.type="monitoring.googleapis.com/uptime_check/response_code"' \
  --condition-threshold-threshold-value=200 \
  --condition-threshold-comparison=COMPARISON_NE \
  --condition-threshold-duration=300s \
  --notification-channels=<channel-id>
```

> **Note:** Replace `<channel-id>` with the ID of your Email/Slack notification channel.
