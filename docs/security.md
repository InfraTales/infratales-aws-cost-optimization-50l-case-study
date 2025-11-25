# Security Considerations

Cost optimization should never compromise security. Here's how we maintained (and improved) security:

1. **VPC Endpoints**: By removing NAT Gateways and using Gateway Endpoints for S3/DynamoDB, traffic stays within the AWS network (more secure + cheaper).
2. **IAM Roles**: Rightsizing often involves consolidating roles. We ensured Least Privilege was maintained.
3. **Encryption**: All new volumes and buckets enforce encryption by default.
4. **Security Groups**: Cleaned up unused rules from the "Before" state.

---
---
  <a href="https://infratales.com/projects">Projects</a> •
  <a href="https://infratales.com/newsletter">Newsletter</a> •
  <a href="https://infratales.com/premium">Premium</a>

### 🟦 Built by InfraTales
Real engineering stories. Real AWS. Real failures.
https://infratales.com • Projects • Newsletter • Premium Case Studies
