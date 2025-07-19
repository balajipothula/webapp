# AWS IAM Role Terraform Module

This Terraform module creates a configurable **IAM Role** in AWS. It supports attaching a custom trust policy (assume role policy), naming, safe lifecycle behavior, and clean outputs.

---

## ✅ Features

- Creates an `aws_iam_role` with:
  - Custom `assume_role_policy`
  - Optional `description`, `name`, and `force_detach_policies`
- Fully exportable outputs for downstream references
- `lifecycle` block that safely ignores `tags_all` drift
- Designed to be used as a foundational module in serverless, ECS, EKS, or general compute contexts

---

## 📦 Usage

```hcl
module "webapp_lambda_aws_iam_role" {

  source                = "./terraform/aws/iam/role"

  assume_role_policy    = data.aws_iam_policy_document.webapp_lambda_iam_role.json  # 🔒 Required argument.
  description           = "IAM Role for WebApp Lambda."                             # ✅ Optional argument — recommended to keep.
  force_detach_policies = true                                                      # ✅ Optional argument — recommended to keep.
  name                  = "WebAppLambdaIAMRole"                                     # ✅ Optional argument — recommended to keep.

}
