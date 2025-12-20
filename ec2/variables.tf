variable "ami" {
  description = "Image ID"
  default = "ami-068c0051b15cdb816"
}
variable "instance_type" {
  description = "Instance Type"
  default = "t2.micro"
}
variable "subnet_id" {
  description = "Subnet Id"
}
variable "security_group_id" {
  description = "Security Group Id"
}
variable "instance_name" {
  description = "Name of the instance"
}