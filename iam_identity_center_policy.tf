variable "sso_instance_arn" {
  type    = string
  default = "arn:aws:sso:::instance/ssoins-6508f9c3cf7f4841"
}

variable "aws_account_id" {
  type    = string
  default = "916574583997"
}

variable "view_only_user_id" {
  type    = string
  default = "f08c396c-40b1-702f-75b6-87b882191022"
}


# --- Resource Definitions ---

resource "aws_ssoadmin_permission_set" "view_only_ps" {
  name             = "ViewOnly-Terraform_IC"
  description      = "Grants view-only access to AWS resources."
  instance_arn     = var.sso_instance_arn
  session_duration = "PT1H"
}

resource "aws_ssoadmin_permission_set_inline_policy" "custom_view_only_policy" {
  instance_arn       = aws_ssoadmin_permission_set.view_only_ps.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.view_only_ps.arn
  
  inline_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:Describe*",
          "s3:List*",
          "s3:Get*",
          "rds:Describe*",
          "iam:List*",
          "iam:Get*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_ssoadmin_account_assignment" "view_only_assignment" {
  instance_arn       = aws_ssoadmin_permission_set.view_only_ps.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.view_only_ps.arn
  
  principal_id   = var.view_only_user_id
  principal_type = "USER"
  
  target_id   = var.aws_account_id
  target_type = "AWS_ACCOUNT"
}
