# InfraTales | ₹50L Savings Playbook – Cloud Cost Optimization Case Study

**A Terraform-based reconstruction of a real-world malfunctioning AWS setup that was costing ₹50 lakh per year more than needed, and the step-by-step optimization that saved it.**

![Cost Flow Diagram](diagrams/cost-flow.mmd)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple.svg)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Production-orange.svg)](https://aws.amazon.com)

## 📉 The "Before" State (The Problem)

We inherited an AWS environment from a startup burning cash. The architecture was riddled with:
- **Overprovisioned Compute**: 14x `m5.4xlarge` instances running at 15% utilization.
- **Wasteful Database**: Multi-AZ `db.r5.4xlarge` RDS with 2TB storage (mostly empty).
- **Idle Resources**: 8 unattached EBS volumes, 3 unused ALBs, 90 days of snapshots.
- **Chatty Network**: Cross-AZ traffic costing ₹55k/month.
- **Logging Chaos**: S3 Standard storage for logs with no lifecycle policies.

## 💰 Cost Breakdown

| Service | Usage (Before) | Cost (Before) | Optimization | Cost (After) |
|:---|:---|:---|:---|:---|
| **EC2** | 14x m5.4xlarge | ₹8,19,000 | ASG (t3.medium + Spot) | ₹1,45,000 |
| **RDS** | db.r5.4xlarge | ₹1,26,000 | db.t3.medium + Savings Plan | ₹24,000 |
| **NAT GW** | 3 (Multi-AZ) | ₹20,700 | 1 (Single AZ) | ₹6,900 |
| **Redis** | r6g.large Cluster | ₹38,000 | DynamoDB + DAX | ₹9,000 |
| **CloudWatch** | 900 Custom Metrics | ₹54,000 | Metric Pruning | ₹8,000 |
| **ALB** | 3 Unused | ₹42,000 | Consolidated | ₹0 |
| **EBS** | 8 Unattached | ₹12,000 | Deleted | ₹0 |
| **S3** | Standard Tier | ₹9,800 | Lifecycle to Glacier | ₹2,100 |
| **Data Transfer** | Cross-AZ | ₹55,000 | Endpoint Optimization | ₹5,000 |
| **Snapshots** | 90 Days | ₹17,000 | 7 Days Retention | ₹1,200 |
| **Total Monthly** | | **₹12,93,000** | | **₹2,03,000** |
| **Total Annual** | | **₹1.55 Cr** | | **₹24.3 Lakhs** |

### 💸 Total Annual Savings: ₹1.30 Crore (~$155,000)

## 🚀 The Solution (The "After" State)

We rebuilt the infrastructure using Terraform with a focus on cost-efficiency:
1. **Rightsizing**: Moved from fixed instances to Auto Scaling Groups with Mixed Instances Policy (Spot + On-Demand).
2. **Modernization**: Replaced Redis with DynamoDB (pay-per-request).
3. **Lifecycle Management**: Automated S3 tiering and Snapshot cleanup.
4. **Network Optimization**: Consolidated NAT Gateways and used VPC Endpoints.
5. **Governance**: Implemented AWS Budgets and Cost Anomaly Detection.

## 🛠️ Repository Structure

- `terraform/before/`: The wasteful infrastructure (DO NOT DEPLOY IN PROD).
- `terraform/after/`: The optimized, production-ready infrastructure.
- `docs/case-study.md`: The full engineering story of how we found and fixed these issues.

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
