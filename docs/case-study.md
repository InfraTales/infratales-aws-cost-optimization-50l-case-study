# Case Study: How We Saved ₹50 Lakhs/Year on AWS

## 🚨 The Midnight Alarm

It was 11:30 PM on a Tuesday when the CFO slacked the engineering channel: *"Why is our AWS bill ₹13 Lakhs this month? We budgeted for ₹4 Lakhs."*

We were a Series A startup. We moved fast, broke things, and apparently broke the bank. Our infrastructure had grown organically (read: chaotically) over 18 months. Developers spun up instances for "testing" and forgot them. Databases were provisioned for "future scale" that never arrived.

## 🕵️ The Investigation

We opened AWS Cost Explorer and filtered by "Unblended Cost". The results were horrifying:
1. **EC2**: ₹8L/month. We were running 14 `m5.4xlarge` instances. CPU utilization? Average 12%.
2. **RDS**: ₹1.2L/month. A Multi-AZ `db.r5.4xlarge` for a database with 50GB of data.
3. **Data Transfer**: ₹55k/month. Our microservices were chatting across Availability Zones like long-lost lovers.

## 🛠️ The Fix

We didn't just "turn things off". We re-architected for cost-efficiency.

### Phase 1: Rightsizing (The Low Hanging Fruit)
We replaced the 14 `m5.4xlarge` instances with an Auto Scaling Group of `t3.medium` instances. We used a **Mixed Instances Policy** to blend On-Demand (base capacity) with Spot Instances (burst capacity).
**Savings: ₹6.7L/month**

### Phase 2: Database Modernization
We analyzed the RDS metrics. The IOPS were low, and memory usage was under 20%. We downgraded to `db.t3.medium` and bought a 1-year Savings Plan.
**Savings: ₹1L/month**

### Phase 3: Architecture Cleanup
- **NAT Gateways**: We had 3 NAT Gateways (one per AZ). We consolidated to 1.
- **Redis**: We were paying for a cluster to cache simple key-value pairs. We moved to DynamoDB On-Demand.
- **S3**: We moved 50TB of logs to Glacier Deep Archive.

## 📉 The Result

| Metric | Before | After |
|:---|:---|:---|
| **Monthly Bill** | ₹12,93,000 | ₹2,03,000 |
| **Annual Run Rate** | ₹1.55 Cr | ₹24.3 L |
| **Savings** | - | **84%** |

This repository contains the Terraform code for both the "Before" (Wasteful) and "After" (Optimized) states, so you can see exactly what changed.

---
### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
