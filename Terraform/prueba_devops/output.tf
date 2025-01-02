/*
# Salida del ID de la instancia EC2 creada
output "instance_id" {
  value = aws_instance.example_instance.id
}

# Salida de la URL del bucket S3
output "s3_bucket" {
  value = aws_s3_bucket.example_bucket.arn
}


 */
# Salida del ARN VPC
output "vpc_id" {
  value = module.vpc.vpc_id
}

/*
# Salida del ARN SubNet
output "subnet_id" {
  value = aws_subnet.main_subnet.arn
}


 */