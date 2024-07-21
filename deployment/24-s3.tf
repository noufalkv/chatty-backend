resource "aws_s3_bucket" "code_deploy_backend_bucket" {
  bucket        = "${local.prefix}-app"
  force_destroy = true
  tags          = local.common_tags
}

resource "aws_s3_bucket_acl" "code_deploy_bucket_acl" {
  bucket     = aws_s3_bucket.code_deploy_backend_bucket.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.code_deploy_backend_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket                  = aws_s3_bucket.code_deploy_backend_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_versioning" "code_deploy_bucket_versioning" {
  bucket = aws_s3_bucket.code_deploy_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
