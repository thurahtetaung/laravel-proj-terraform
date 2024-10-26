variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
  default     = "default"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "laravel"
}

variable "project_domain" {
  description = "Project domain"
  type        = string
  default     = "example.com"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.small"
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
  default = "ami-0866a3c8686eaeeba"
}

variable "ec2_volume_size" {
  description = "EC2 volume size"
  type        = number
  default     = 30

}

variable "ssh-keypair-name" {
  description = "SSH keypair name"
  type        = string
}

variable "db_enginer_version" {
  description = "DB engine version"
  type        = string
  default = "8.0.mysql_aurora.3.05.2"
}

variable "db_instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.serverless"

}

variable "redis_instance_type" {
  description = "Redis instance type"
  type        = string
  default     = "cache.t3.micro"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_publicly_accessible" {
  description = "Whether the DB should have a public IP"
  type        = bool
  default     = false
}

variable "db_password" {
  description = "RDS root password"
  type        = string
  sensitive   = true
}

variable "ssl_certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  default = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "my-bucket"
}

variable "s3_bucket_acl" {
  description = "S3 bucket ACL"
  type        = string
}

variable "code_deploy_bucket_name" {
  description = "CodeDeploy bucket name"
  type        = string
  default     = "my-codedeploy-bucket"

}