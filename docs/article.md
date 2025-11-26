# We saved ₹50 lakhs per year on AWS — and it was all our own stupidity

It was 11:30 PM on a Tuesday when the CFO slacked the engineering channel: *"Why is our AWS bill ₹13 lakhs this month? We budgeted for ₹4 lakhs."*

Series A startup. 18 months of chaotic growth. Engineering team moving fast, breaking things.

And apparently breaking the bank.

No one knew why the bill was this high. No one had time to look. Until we had no choice.

---

What we were running:

Frontend → ALB → ECS (14x m5.4xlarge) → RDS  
Async jobs → Redis cluster  
Everything split across 3 AZs whether it needed to be or not.

---

We were building for traffic we didn't even have.

Provisioned for 100x. Using 10x. Paying for 1000x.

We assumed "scaling for growth" meant leaving everything running at maximum theoretical capacity.

Forever.

When we opened Cost Explorer, it was like opening a fridge you left shut for a year.

Everything rotten, stinking, and expensive.

---

**EC2: ₹8.19 lakh/month**

14x `m5.4xlarge` instances. 16 vCPU, 64GB RAM each.

Average CPU utilization? 12%.

Peak utilization on our biggest sale day? 28%.

We provisioned for Black Friday. Every. Single. Day.

---

**RDS: ₹1.26 lakh/month**

Multi-AZ `db.r5.4xlarge`. 16 vCPU, 128GB RAM.

Actual data size? 50GB.

IOPS? Consistently under 500.

We could have run this on a laptop.

---

**Data Transfer: ₹55k/month**

Our microservices were chatting across Availability Zones like long-lost lovers.

No VPC endpoints. S3 calls from EC2 went over the public internet.

Every health check ping was costing money.

---

Then there was the graveyard:

8 unattached EBS volumes. Orphaned after someone terminated instances and forgot to clean up.

3 unused Application Load Balancers from old experiments. Still running. Still charging.

90 days of snapshot retention. Compliance only needed 7.

A Redis cluster caching simple key-value pairs that could've lived in memory.

900 CloudWatch custom metrics. Half were duplicates from bad tagging.

The pattern was clear:

Developers spun up resources for "testing."  
No one deleted them.  
No tagging policy.  
No budget alerts.  
No lifecycle policies on S3.  
No scheduled scaling.

Cost Explorer showed p99 resource utilization at 15%.

The room went quiet when we saw those graphs.

We were paying for a Lamborghini and driving it to the grocery store once a week.

---

This wasn't going to be a one-day fix.

It took 3 weeks. Inventory, testing, gradual migration.

And more chai than sleep.

---

**Week 1: The Easy Wins**

We deleted the obvious waste.

8 unattached EBS volumes? Gone.  
3 unused ALBs? Deleted.  
Snapshot retention? Changed from 90 days to 7 days.  
S3 logs? Lifecycle policy → move to Glacier after 30 days.

**Savings: ₹71k/month**

These savings were lying on the floor.

We should've cleaned this mess a year ago.

---

**Week 2: The Scary Part**

EC2 rightsizing.

We didn't trust auto-scaling yet. So we did this in phases.

First, we analyzed 30 days of CloudWatch metrics.  
Then load-tested with `t3.medium` in staging (2 vCPU, 4GB RAM).  

Then we built an Auto Scaling Group with a Mixed Instances Policy:
- Base capacity: 2x `t3.medium` On-Demand (₹9k/month)
- Burst capacity: up to 8x Spot instances (₹1.2k/month average)

We switched traffic 10% at a time. Took 2 days.

**Before:** 14x `m5.4xlarge` = ₹8.19L/month  
**After:** ASG (2 base + spot burst) = ₹1.45L/month  
**Savings: ₹6.74L/month**

What broke during rollout:

Spot instances got terminated twice mid-day. We added Spot Capacity Rebalancing.

One microservice had an 8GB memory leak we didn't catch in staging. Slapped us at 9 PM. We fixed it.

Cost: 2 late nights.  
Pain: Medium.  
Worth it: Absolutely.

---

**Week 2.5: Database Downgrade**

We snapshotted RDS and downgraded from `db.r5.4xlarge` to `db.t3.medium`.

Tested for 3 days. No issues. P99 latency stayed under 5ms.

Bought a 1-year Compute Savings Plan for RDS. 21% discount.

**Before:** `db.r5.4xlarge` Multi-AZ = ₹1.26L/month  
**After:** `db.t3.medium` + Savings Plan = ₹24k/month  
**Savings: ₹1.02L/month**

What we underestimated:

Reboot took 8 minutes. We did it at 2 AM anyway.

Connection pool configs needed tuning for the smaller instance. That took 3 hours of debugging.

---

**Week 3: Architectural Changes**

NAT Gateway consolidation.

We had 3 NAT Gateways (one per AZ) for "high availability."

Our uptime SLA was 99.5%. We didn't need 99.99%.

We killed 2. Kept 1.

**Before:** 3x NAT GW = ₹20.7k/month  
**After:** 1x NAT GW = ₹6.9k/month  
**Savings: ₹13.8k/month**

Trade-off: If that single NAT Gateway fails, we're down.

But it's managed by AWS. Hasn't failed yet.

---

**Redis → DynamoDB migration**

We were using ElastiCache Redis for simple key-value caching. Session tokens, feature flags.

We migrated to DynamoDB On-Demand with DAX (DynamoDB Accelerator) for reads.

**Before:** `r6g.large` Redis cluster = ₹38k/month  
**After:** DynamoDB On-Demand + DAX = ₹9k/month  
**Savings: ₹29k/month**

What made it painful:

We had to rewrite cache logic. Redis `GET`/`SET` → DynamoDB `GetItem`/`PutItem`.

DAX doesn't support all DynamoDB operations. We hit this hard with scans. Had to rework queries.

We tested in staging for 5 days before switching prod.

---

**VPC Endpoints for S3 and DynamoDB**

Our services were calling S3 and DynamoDB over the internet.

Every API call = data transfer charges.

We created VPC Gateway Endpoints.

**Before:** Cross-AZ + Internet = ₹55k/month  
**After:** VPC Endpoints = ₹5k/month  
**Savings: ₹50k/month**

This should have been day-1 architecture.

---

**CloudWatch metric cleanup**

We had 900 custom metrics. Half were duplicates from bad tagging.

We deleted 450. Kept the ones that mattered.

**Before:** 900 metrics = ₹54k/month  
**After:** 450 metrics = ₹8k/month  
**Savings: ₹46k/month**

---

We didn't want this to happen again.

So we built guardrails:

1. AWS Budgets with alerts at 50%, 80%, 100% of ₹4L/month budget
2. Cost Anomaly Detection that emails us if daily spend increases >20%
3. Lambda Scheduler that shuts down non-prod environments at 7 PM, starts at 9 AM
4. Tagging Policy enforced via SCPs: `Environment`, `Owner`, `Project`
5. Terraform only. No more ClickOps.

Non-prod shutdown alone saved ₹18k/month.

---

**Final tally:**

| Service | Before (₹/month) | After (₹/month) | Savings |
|:---|---:|---:|---:|
| EC2 | 8,19,000 | 1,45,000 | 6,74,000 |
| RDS | 1,26,000 | 24,000 | 1,02,000 |
| NAT Gateway | 20,700 | 6,900 | 13,800 |
| Redis → DynamoDB | 38,000 | 9,000 | 29,000 |
| CloudWatch | 54,000 | 8,000 | 46,000 |
| ALB (deleted) | 42,000 | 0 | 42,000 |
| EBS (deleted) | 12,000 | 0 | 12,000 |
| S3 Lifecycle | 9,800 | 2,100 | 7,700 |
| Data Transfer | 55,000 | 5,000 | 50,000 |
| Snapshots | 17,000 | 1,200 | 15,800 |
| **Monthly Total** | **12,93,000** | **2,03,000** | **10,90,000** |
| **Annual Savings** | | | **₹1.30 Crore** |

---

If you don't watch your AWS bill weekly, you're burning money quietly.

Until one day someone finally looks. And it's too late.

Most startups don't die from bad code.

They die from burning cash on idle infrastructure.

Set a budget. Set alerts. Enforce tagging. Auto-scale everything. Delete what you don't use.

And remember this:

If it's cheap at 10 req/s, it can bankrupt you at 1,000 req/s — but it can also bankrupt you at 10 req/s if you provisioned it for 10,000.
