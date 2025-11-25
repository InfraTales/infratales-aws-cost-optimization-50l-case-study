# Cost Governance Strategy

To prevent this from happening again, we implemented:

1. **AWS Budgets**: Alerts sent to Slack when forecasted spend exceeds 80% of budget.
2. **Cost Anomaly Detection**: AI-driven alerts for unusual spend spikes.
3. **Tagging Policy**:
   - `CostCenter`: Which team pays?
   - `Environment`: Prod/Dev/Staging?
   - `Owner`: Who built this?
4. **Lambda Scheduler**: Automatically stops Dev/Staging instances at 8 PM and starts them at 8 AM.

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
