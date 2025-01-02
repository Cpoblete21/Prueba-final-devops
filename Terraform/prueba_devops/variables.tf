variable "instance_type" {
 type = string
 default = "t2.micro"
}

variable "ami_id" {
type = string
default = "ami-0c55b159cbfafe1f0"
}

variable "cidr" {
 type = string
 default = "192.168.0.0/16"
}