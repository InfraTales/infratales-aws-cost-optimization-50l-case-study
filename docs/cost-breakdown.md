# Detailed Cost Breakdown

## EC2 Analysis
- **Before**: 14 x m5.4xlarge (On-Demand)
  - Price: $0.768/hr
  - Total: 14 * 0.768 * 730 = $7,848/mo (~₹6.5L)
- **After**: ASG (Min 2, Max 10) t3.medium (Spot + Savings Plan)
  - Price: $0.0125/hr (Spot avg)
  - Total: ~$200/mo (~₹16k)

## RDS Analysis
- **Before**: db.r5.4xlarge Multi-AZ
  - Price: $2.32/hr
  - Total: $1,693/mo (~₹1.4L)
- **After**: db.t3.medium Single-AZ (Dev) / Multi-AZ (Prod) + Savings Plan
  - Price: $0.072/hr
  - Total: ~$100/mo (~₹8k)

## Data Transfer
- **Before**: Cross-AZ traffic via NAT Gateway ($0.045/GB + NAT processing)
- **After**: S3/DynamoDB Gateway Endpoints (Free)

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
