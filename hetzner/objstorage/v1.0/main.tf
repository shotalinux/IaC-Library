provider "minio" {
  minio_server   = "${var.region}.your-objectstorage.com"
  minio_user     = var.access_key
  minio_password = var.secret_key
  minio_region   = var.region
  minio_ssl      = true
}

resource "minio_s3_bucket" "this" {
  bucket         = var.bucket_name
  acl            = var.acl
  object_locking = var.object_locking
}