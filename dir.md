# Disaster Recovery Plan

## Backup Strategy
- Daily SQL backups via Cloud SQL automatic backups
- GCS lifecycle rules to retain static content backups
- Terraform state stored in GCS (versioning enabled)

## Recovery Strategy
- Redeploy infrastructure via Terraform
- Redeploy containers via Cloud Build trigger
- Restore DB from latest snapshot using `gcloud sql backups restore`

## Availability
- Consider regional Cloud SQL (not zonal) for higher uptime
- Set up monitoring alerts (Cloud Monitoring + Alerting Policies)

## Incident Response
- Access logs in Cloud Logging
- Use Slack or Email alerts for errors
