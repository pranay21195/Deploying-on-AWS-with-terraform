variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "ap-south-1"
}

variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}
variable "webserver-ami" {
  type    = string
  default = "ami-0eeb03e72075b9bcc"
}

variable "instance-type" {
  type    = string
  default = "t2.micro"
}
variable "instance-count" {
  type    = number
  default = 1

}
# key variable for refrencing 
variable "key_name" {
  default = "mastercard"
}
# base_path for refrencing
variable "base_path" {
  default = "/home/ec2-user/mastercard"
}
variable "webserver-port" {
  type    = number
  default = 80
}

variable "public_subnet" {
  description = "Number of public subnets."
  type        = number
  default     = 2
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets."
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.3.0/24",
  ]
}

