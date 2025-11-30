# Cost Analysis (₹)

This document provides cost estimates for the **AWS Cost Optimization Case Study** infrastructure in **Indian Rupees (₹)**.

## Summary

| Metric | Before | After | Savings |
|--------|--------|-------|---------|
| **Monthly Cost** | ₹8,50,000 | ₹3,50,000 | **₹5,00,000/month** |
| **Annual Cost** | ₹1,02,00,000 | ₹42,00,000 | **₹60,00,000/year** |
| **Savings %** | - | - | **~60%** |

## Production Environment

| Service | Before (₹/month) | After (₹/month) | Notes |
|---------|------------------|-----------------|-------|
| **EC2** | ₹6,50,000 | ₹16,000 | Spot + ASG + Right-sizing |
| **RDS** | ₹1,40,000 | ₹8,000 | Single-AZ dev + Reserved |
| **Data Transfer** | ₹45,000 | ₹0 | VPC Endpoints |
| **NAT Gateway** | ₹15,000 | ₹5,000 | Consolidated |
| **Total** | **₹8,50,000** | **₹29,000** | |

## Cost Optimization Strategies Applied

1. **EC2 Right-sizing** – Downsized from m5.4xlarge to t3.medium
2. **Spot Instances** – 70% savings on non-critical workloads
3. **Auto Scaling** – Scale to demand, not peak capacity
4. **Reserved Instances** – 40% savings on baseline compute
5. **VPC Endpoints** – Eliminated NAT Gateway data processing costs
6. **Storage Tiering** – S3 Intelligent-Tiering for infrequent access

## Detailed Breakdown

See [cost-breakdown.md](cost-breakdown.md) for line-item analysis.
See [savings-calculation.md](savings-calculation.md) for ROI calculations.
