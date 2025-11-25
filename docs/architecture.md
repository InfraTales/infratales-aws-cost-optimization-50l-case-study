# Architecture Evolution

## The "Before" Architecture (Wasteful)
- **Compute**: Static fleet of large EC2 instances. No Auto Scaling.
- **Database**: Overprovisioned Multi-AZ RDS.
- **Network**: Chatty microservices across 3 AZs using 3 NAT Gateways.
- **Storage**: Unattached EBS volumes and S3 Standard tier for everything.

## The "After" Architecture (Optimized)
- **Compute**: Auto Scaling Group with Spot Instances.
- **Database**: Rightsized RDS with Storage Autoscaling.
- **Network**: Single NAT Gateway, VPC Endpoints for S3/DynamoDB (free data transfer).
- **Storage**: S3 Lifecycle Policies (Intelligent Tiering -> Glacier).
- **Caching**: CloudFront for static assets to offload EC2.

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
