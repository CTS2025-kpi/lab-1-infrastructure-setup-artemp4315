data "aws_iam_user" "test_view_only_user" {
  user_name = "test-view-only-user"
}

# --- Resource Definitions ---

resource "aws_iam_policy" "view_only_policy" {
  name        = "CustomViewOnlyPolicy-Terraform-IAM"
  description = "A custom view-only policy created by Terraform."

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:Describe*",
          "s3:List*",
          "rds:Describe*",
          "iam:List*",
          "iam:Get*"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "view_only_role" {
  name = "ViewOnlyRole-IAM-Terraform"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          AWS = data.aws_iam_user.test_view_only_user.arn
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_attachment" {
  role       = aws_iam_role.view_only_role.name
  policy_arn = aws_iam_policy.view_only_policy.arn
}

resource "aws_iam_user_policy" "allow_assume_role" {
  name = "AllowAssumeViewOnlyRole"
  user = data.aws_iam_user.test_view_only_user.user_name

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = aws_iam_role.view_only_role.arn
      }
    ]
  })
}
