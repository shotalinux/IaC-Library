output "bucket_name" {
  description = "The name of the created bucket"
  value       = minio_s3_bucket.this.bucket
}

output "bucket_region" {
  description = "Region where the bucket is created"
  value       = var.region
}

output "endpoint" {
  description = "The endpoint URL for accessing the bucket"
  value       = "${var.region}.your-objectstorage.com"
}