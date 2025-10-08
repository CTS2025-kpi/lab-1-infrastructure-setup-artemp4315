# AWS Monthly Cost Estimate (On-Demand Model)

### Summary
* **Total Monthly Cost**: **$83.84**
* **Total Upfront Cost**: **$0.00**

---

## Cost Breakdown

### 1. AWS Fargate
This covers the cost of running 3 containers (1 coordinator, 2 shards) 24/7.

* **vCPU Cost**: (3 tasks * 0.5 vCPU * 730 hours) * $0.0445/hr = **$48.73**
* **Memory Cost**: (3 tasks * 1 GB * 730 hours) * $0.0049/hr = **$10.73**

**Total Fargate Cost: $59.46 / month**

---

### 2. Application Load Balancer (ALB)
This covers the cost of the load balancer that directs traffic to the coordinator.

* **Fixed Hourly Cost**: 1 ALB * 730 hours * $0.02394/hr = **$17.48**
* **Usage (LCU) Cost**: Based on estimated traffic = **$5.55**

**Total ALB Cost: $23.03 / month**

---

### 3. Amazon DynamoDB
This calculation now uses the **On-Demand capacity** model. This model is flexible and has no upfront fees.

* **Read/Write Requests**: The assumed usage (1 million reads & 1 million writes) is **fully covered by the AWS Free Tier**. Cost = **$0.00**
* **Storage Cost**: 5 GB * $0.269/GB = **$1.34**

**Total DynamoDB Cost: $1.34 / month**

---

### 4. Amazon API Gateway

The cost for a small number of requests is negligible.

**Total API Gateway Cost: $0.01 / month**
