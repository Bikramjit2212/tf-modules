# AWS EC2 Monitoring with Terraform (CloudWatch + SNS Alerts)

## 📌 Project Overview

This project demonstrates how to provision and monitor AWS infrastructure using **Terraform**. It follows a modular approach to deploy an Amazon EC2 instance, configure its security group, create Amazon SNS notifications, and set up Amazon CloudWatch alarms to monitor CPU utilization.

The project showcases Infrastructure as Code (IaC) principles, reusable Terraform modules, and basic AWS monitoring capabilities.

> **Note:** The repository reflects both the implemented functionality and a few issues identified during code review. Those improvements are documented under the "Known Issues & Enhancements" section.

---

## 📝 Project Description

**AWS EC2 Monitoring and Alerting using Terraform**

Designed and implemented a modular Terraform-based infrastructure solution to provision Amazon EC2 instances, configure security groups, create SNS email notifications, and establish CloudWatch CPU utilization monitoring. Utilized reusable modules and environment-specific configurations while identifying and documenting implementation improvements to enhance reliability and production readiness.

---


## 🚀 Architecture

```text
Terraform
│
├── EC2 Module
│     ├── Launch EC2 Instance
│     └── Create Security Group
│
├── SNS Module
│     ├── Create SNS Topic
│     └── Create Email Subscription
│
└── CloudWatch Module
      └── Monitor EC2 CPU Utilization
             └── Trigger SNS Email Notifications
```

### Workflow

1. Terraform provisions an EC2 instance.
2. A security group allowing SSH access is attached.
3. An SNS topic is created.
4. Email subscriptions are configured.
5. CloudWatch monitors the EC2 CPU metric.
6. When the threshold is exceeded, SNS sends an email notification.

---

## ✨ Features

* Modular Terraform codebase.
* EC2 instance provisioning.
* Automatic Security Group creation.
* CloudWatch CPU monitoring.
* SNS email notifications.
* Environment-specific variable files.
* Reusable Terraform modules.
* Infrastructure deployment through code.

---

## 📁 Project Structure

```text
cloudwatch/
├── cloudwatch/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── ec2/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── envs/
│   ├── dev.tfvars
│   └── prod.tfvars
├── sns/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── main.tf
└── variables.tf
```

---

## 🛠 Technologies Used

* Terraform
* AWS EC2
* AWS CloudWatch
* AWS SNS
* AWS Security Groups
* Infrastructure as Code (IaC)

---

## 📋 Prerequisites

Before deploying this project, ensure you have:

* AWS Account
* IAM User with appropriate permissions
* AWS CLI configured
* Terraform installed
* Existing EC2 Key Pair

Example permissions include:

* EC2 Full Access
* CloudWatch Full Access
* SNS Full Access

---

## ⚙️ Configuration

### Example dev.tfvars

```hcl
region         = "us-east-1"
ami            = "ami-068c0051b15cdb816"
instance_type  = "t2.micro"
key_name       = "linuxserver"
email          = "your-email@example.com"
```

---

## 🚀 Deployment Steps

### Initialize Terraform

```bash
terraform init
```

### Review Execution Plan

```bash
terraform plan -var-file=envs/dev.tfvars
```

### Deploy Infrastructure

```bash
terraform apply -var-file=envs/dev.tfvars
```

Type:

```text
yes
```

when prompted.

---

## 📬 SNS Email Subscription

During deployment:

* Terraform creates an SNS topic.
* An email subscription is created if an email address is provided.
* AWS sends a confirmation email.

You must confirm the subscription by clicking the link received in your inbox.

Without confirmation, notifications will not be delivered.

---

## 📈 CloudWatch Monitoring

The intended configuration is:

| Setting            | Value          |
| ------------------ | -------------- |
| Metric             | CPUUtilization |
| Namespace          | AWS/EC2        |
| Statistic          | Average        |
| Threshold          | 80%            |
| Period             | 60 seconds     |
| Evaluation Periods | 1              |
| Notification       | SNS Email      |

When CPU usage exceeds the configured threshold, CloudWatch triggers the SNS topic.

---

## 🔥 Simulating High CPU Usage

The EC2 user data installs the `stress` utility:

```bash
yum install stress -y
```

After SSH into the instance:

```bash
stress --cpu 2 --timeout 300
```

This generates CPU load and can be used to test alert notifications.

---

## 🧹 Destroy Infrastructure

To avoid AWS charges:

```bash
terraform destroy -var-file=envs/dev.tfvars
```

---

## 🔮 Future Enhancements

Potential improvements include:

* Custom VPC deployment.
* Public and private subnet architecture.
* Remote Terraform state using S3.
* DynamoDB state locking.
* IAM roles for EC2.
* Auto Scaling Groups.
* CloudWatch dashboards.
* Multi-environment automation.
* GitHub Actions CI/CD integration.
* AWS Systems Manager Session Manager instead of SSH.

---

## 💼 Skills Demonstrated

This project highlights experience with:

* Infrastructure as Code
* Terraform Modules
* AWS EC2 Provisioning
* Security Group Management
* Amazon SNS
* Amazon CloudWatch
* Environment Configuration
* Terraform Variables
* Monitoring and Alerting
* Basic Infrastructure Troubleshooting

---


## 🎯 Learning Outcome

This project strengthened practical understanding of:

* Terraform module design,
* AWS infrastructure provisioning,
* Monitoring and alerting workflows,
* Debugging infrastructure configurations,
* Applying DevOps best practices to improve infrastructure quality.

While originally developed as a learning project, reviewing and refining the implementation provided valuable experience in identifying real-world operational gaps and improving overall infrastructure reliability.

---

# 👨‍💻 Author

**Bikramjit Roy**

DevOps & Cloud Engineering Enthusiast passionate about automation, CI/CD, cloud-native practices, and building reliable software delivery pipelines.

GitHub:
https://github.com/Bikramjit2212

---

## ⭐ If you found this project useful, consider giving it a star.
