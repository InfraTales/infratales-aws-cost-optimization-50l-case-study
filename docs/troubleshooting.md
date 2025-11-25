# Troubleshooting Cost Issues

| Symptom | Probable Cause | Fix |
|:---|:---|:---|
| **EC2 Cost Spike** | Spot Instances reclaimed, fell back to On-Demand | Adjust Spot price or instance types |
| **NAT Gateway Cost** | High cross-AZ traffic | Use VPC Endpoints or keep traffic in-zone |
| **S3 Cost Spike** | API requests (LIST/PUT) | Check for infinite loops in code accessing S3 |
| **EBS Cost** | Forgotten snapshots | Enable Data Lifecycle Manager (DLM) |

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
