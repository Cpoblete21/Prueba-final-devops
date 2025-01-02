# Creación de un Bucket S3
resource "aws_s3_bucket" "bucket-finalprueba" {
  bucket = var.s3_bucket_name
  lifecycle {
    prevent_destroy = false
  }
}