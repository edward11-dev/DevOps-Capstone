# Master INSTANCE
variable "AMI" {
  description = "AMI id of AWS resource"
  type        = map(string)
  default = {
    ubuntu = "ami-08d4ac5b634553e16"
  }
}

# PKI
variable "PATH_PRIVATE_KEY" {
  description = "Private Key file location"
  default     = "~/DevOps/Capstone/EasyPay/easypay.pem"
  type        = string
}

variable "PATH_PUBLIC_KEY" {
  description = "Public Key file location"
  default     = "~/DevOps/Capstone/EasyPay/terraform_ec2_key.pub"
  type        = string
}

variable "AWS_TOKEN" {
  description = "AWS API Token"
  type        = string
  sensitive   = true
}

variable "INSTANCE_TYPE" {
  description = "AWS EC2 instance type (size)"
  default     = "t2.medium"
  type        = string
}