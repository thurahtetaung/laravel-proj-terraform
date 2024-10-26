resource "aws_iam_instance_profile" "web_profile" {
  name = "laravel-ec2-instance-profile"

  role = aws_iam_role.web_role.name
  // session manager access

}

resource "aws_iam_role" "web_role" {
  name = "laravel-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "laravel-ec2-role"
  }
}

resource "aws_iam_policy" "s3_parameterstore_policy" {
  name        = "s3-ssm-policy"
  description = "Policy for S3 and SSM access for Laravel EC2 instances"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*",
          "arn:aws:s3:::${var.code_deploy_bucket_name}",
          "arn:aws:s3:::${var.code_deploy_bucket_name}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:PutParameter",
          "ssm:DeleteParameter",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:DescribeParameters",
          "ssm:GetParameter",
          "ssm:DeleteParameters"
        ],
        Resource = "*"
      }
    ]
  })
}

resource aws_iam_role_policy_attachment s3_parameterstore_policy_attachment {
  role       = aws_iam_role.web_role.name
  policy_arn = aws_iam_policy.s3_parameterstore_policy.arn
}

resource aws_iam_role_policy_attachment ssminstancecore_policy_attachment {
  role       = aws_iam_role.web_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}