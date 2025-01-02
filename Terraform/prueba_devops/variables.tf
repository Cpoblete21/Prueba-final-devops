# Definición de variables

variable "aws_region" {
  description = "La región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "vpc_cidr_block" {
  description = "El bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "El bloque CIDR para la subred"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_availability_zone" {
  description = "La zona de disponibilidad para la subred"
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "El tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "s3_bucket_name" {
  description = "El nombre del bucket S3"
  type        = string
}

variable "key_name" {
  description = "El nombre de la clave SSH para la instancia EC2"
  type        = string
}

variable "route_table_id" {
  description = "El ID de la route table"
  type        = string
}
