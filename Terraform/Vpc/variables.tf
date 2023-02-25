variable "vpc-cidr" {
  description = "this variable will include the cidr's vpc"
  type        = string

}

variable "vpc-name" {
  description = "name of the vpc"
  type        = string

}

variable "subnet_cidrs_public" {
  type        = map(string)
  description = "Subnet CIDR values"
}

variable "subnet_cidrs_private" {
  type        = map(string)
  description = "Subnet CIDR values"
}