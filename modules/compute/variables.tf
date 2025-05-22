variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "Adetola-instance"
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
  default     = "vpc-0744d97a89507616b"
}

variable "subnet_id" {
  description = "ID of the subnet where EC2 instance will be launched"
  type        = string
  default = "subnet-08611ef42508bf7cb"
}


