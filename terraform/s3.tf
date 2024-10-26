resource aws_s3_bucket laravel-bucket {
  bucket = var.s3_bucket_name
  tags = {
    Name        = "${var.s3_bucket_name}"
    Environment = var.environment
  }
}

resource aws_s3_bucket_ownership_controls laravel-bucket-ownership-controls {
  bucket = aws_s3_bucket.laravel-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource aws_s3_bucket_acl laravel-bucket-acl {
  depends_on = [ aws_s3_bucket_ownership_controls.laravel-bucket-ownership-controls ]
  bucket = aws_s3_bucket.laravel-bucket.bucket
  acl    = "${var.s3_bucket_acl}"
}