# Operational Runbook

## Daily Checks
- **Cost Anomaly**: Check AWS Cost Anomaly Detection dashboard.
- **Budget Alerts**: Verify no budget alerts in Slack.

## Monthly Tasks
- **Unused Resources**: Run the `cleanup.sh` script to find unattached EBS volumes and old snapshots.
- **Rightsizing**: Check Compute Optimizer recommendations.

## Emergency Procedures
- **Budget Breach**: If spend spikes > 20% in 24h:
  1. Check Cost Explorer (Daily View).
  2. Identify the service (usually Lambda loops or S3 transfer).
  3. Kill the rogue process.

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
