provider "aws" {
  region  = "eu-north-1"
  profile = "learning"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account id"
}

# --- Resource Definitions ---

resource "aws_iam_policy" "view_only_policy" {
  name        = "CustomViewOnlyPolicy-Terraform"
  description = "A custom view-only policy created by Terraform."

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:Describe*",
          "s3:List*",
          "rds:Describe*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "view_only_role" {
  name = "ViewOnlyRole-Terraform"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${var.aws_account_id}:root"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.view_only_role.name
  policy_arn = aws_iam_policy.view_only_policy.arn
}
