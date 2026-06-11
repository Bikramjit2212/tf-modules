# 🚀 AWS Infrastructure Provisioning using Terraform Modules

A modular Infrastructure as Code (IaC) project built using Terraform to provision AWS resources including a VPC, Subnet, Security Group, and EC2 Instance. The project demonstrates how reusable Terraform modules can be leveraged to build scalable and maintainable cloud infrastructure.

---

## 📌 Project Overview

This project provisions a basic AWS environment by separating infrastructure components into independent Terraform modules.

The infrastructure created includes:

* A custom Virtual Private Cloud (VPC)
* A public subnet within the VPC
* A Security Group allowing SSH and HTTP traffic
* An EC2 instance deployed inside the subnet

The primary objective of this project is to demonstrate Terraform module development and inter-module dependency management.

---

## 🏗️ Architecture

```
                        AWS (us-east-1)
                               │
                               ▼
                    ┌─────────────────┐
                    │       VPC       │
                    │ 10.0.0.0/16     │
                    └────────┬────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │ Public Subnet   │
                    │ 10.0.1.0/24     │
                    └────────┬────────┘
                             │
          ┌──────────────────┴──────────────────┐
          ▼                                     ▼
 ┌─────────────────┐                  ┌─────────────────┐
 │ Security Group  │                  │  EC2 Instance   │
 │ SSH (22)        │◄────────────────►│  t2.micro       │
 │ HTTP (80)       │                  │ webserver1      │
 └─────────────────┘                  └─────────────────┘
```

---

## 📂 Project Structure

```
tf-modules-main/
├── main.tf
├── outputs.tf
├── variables.tf
├── terraform.tfvars
├── README.md
│
├── vpc/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── security_group/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
└── ec2/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

---

## ⚙️ Terraform Modules

### 1. VPC Module

Responsible for creating networking resources.

Resources provisioned:

* AWS VPC
* AWS Subnet

Inputs:

| Variable            | Description                             |
| ------------------- | --------------------------------------- |
| `cidr_block`        | CIDR block for the VPC                  |
| `subnet_cidr`       | CIDR block for the subnet               |
| `availability_zone` | Availability Zone for subnet deployment |

Outputs:

* `vpc_id`
* `subnet_id`

---

### 2. Security Group Module

Responsible for creating network access rules.

Ingress Rules:

| Port | Protocol | Purpose     |
| ---- | -------- | ----------- |
| 22   | TCP      | SSH Access  |
| 80   | TCP      | HTTP Access |

Egress Rules:

* Allows all outbound traffic.

Input:

| Variable | Description                                 |
| -------- | ------------------------------------------- |
| `vpc_id` | VPC ID where Security Group will be created |

Output:

* `security_group_id`

---

### 3. EC2 Module

Responsible for provisioning compute resources.

Resources:

* EC2 Instance

Default Configuration:

| Parameter     | Value                   |
| ------------- | ----------------------- |
| AMI           | `ami-068c0051b15cdb816` |
| Instance Type | `t2.micro`              |
| Instance Name | `webserver1`            |

Inputs:

| Variable            | Description       |
| ------------------- | ----------------- |
| `ami`               | AMI ID            |
| `instance_type`     | EC2 instance type |
| `subnet_id`         | Target subnet     |
| `security_group_id` | Security Group ID |
| `instance_name`     | Name tag          |

Output:

* `instance_id`

---

## 🔄 Module Dependency Flow

```
VPC Module
   │
   ├── vpc_id ───────────────► Security Group Module
   │
   └── subnet_id ────────────► EC2 Module
                                      │
Security Group Module ───────────────┘
                  security_group_id
```

Terraform automatically handles these dependencies through module outputs and references.

---

## 🚀 Deployment Steps

### Prerequisites

* AWS Account
* IAM User with required permissions
* AWS CLI configured
* Terraform installed

Verify installations:

```bash
terraform version
aws sts get-caller-identity
```

---

### Clone Repository

```bash
git clone <repository-url>
cd tf-modules-main
```

---

### Initialize Terraform

```bash
terraform init
```

---

### Review Execution Plan

```bash
terraform plan
```

---

### Deploy Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

when prompted.

---

### View Outputs

```bash
terraform output
```

Example outputs:

```text
instance_id = i-xxxxxxxxxxxxxxxxx
vpc_id      = vpc-xxxxxxxxxxxxxxxxx
```

---

### Destroy Infrastructure

To avoid unnecessary AWS charges:

```bash
terraform destroy
```

---

## 📖 Terraform Concepts Demonstrated

* Infrastructure as Code (IaC)
* Terraform Modules
* Module Reusability
* Variable Management
* Outputs and Inter-Module Communication
* Resource Dependency Handling
* AWS Networking Basics
* EC2 Provisioning
* Security Group Configuration

---

## 🔍 Potential Improvements

This project is intentionally simple and educational. Production enhancements could include:

* Remote state using S3 and DynamoDB locking
* Separate environments (dev/stage/prod)
* NAT Gateway and Internet Gateway
* Route Tables
* Public and Private Subnets
* User Data bootstrap scripts
* Elastic IP association
* Auto Scaling Groups
* Application Load Balancer integration
* Version constraints for Terraform and providers

---

## 🧠 Key Learning Outcomes

Through this project, gaining hands-on experience with:

* Designing reusable Terraform modules.
* Passing data between modules using outputs.
* Structuring Terraform projects for maintainability.
* Deploying AWS infrastructure using modular IaC practices.
* Understanding how Terraform builds dependency graphs automatically.

---

# 👨‍💻 Author

**Bikramjit Roy**

DevOps & Cloud Engineering Enthusiast passionate about automation, CI/CD, cloud-native practices, and building reliable software delivery pipelines.

GitHub:
https://github.com/Bikramjit2212

---

## ⭐ If you found this project useful, consider giving it a star.
