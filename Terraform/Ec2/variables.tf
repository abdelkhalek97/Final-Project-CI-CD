variable "instType" {
  description = "this variable will tell instance type"
  type        = string
  default     = ""


}


variable "name" {
  type    = string
  default = ""
}


variable "subnet_ids" {
  # type = list(string)
}

variable "secg_id" {
  default = ""
}


variable "key_name" {
  default = ""
}

variable "instance_profile" {

}
variable "priavte_ip" {
  
}

variable "inline" {
  
}

variable "file_source" {
  
}
variable "file_destination" {
  
}

variable "connection_type" {
}

variable "connection_user" {
}

variable "connection_private_key" {
}