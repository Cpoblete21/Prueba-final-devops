# Definición de un grupo de seguridad para la instancia EC2
resource "aws_security_group" "instance_sg" {
  name        = "sgp-terraform-prueba-final"
  description = "Security group for EC2 instance"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}