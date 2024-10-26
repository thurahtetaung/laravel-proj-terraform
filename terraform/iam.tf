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
      },
      // s3 access for bucket
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "s3:*",
        Resource = ["arn:aws:s3:::${var.s3_bucket_name}", "arn:aws:s3:::${var.s3_bucket_name}/*"]
      },
    ]
  })
  tags = {
    Name = "laravel-ec2-role"
  }
}

resource aws_iam_role_policy_attachment web_role_attachment {
  role       = aws_iam_role.web_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}