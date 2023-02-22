variable "instType" {
  description = "this variable will tell instance type"
  type        = string
  default     = ""


}

variable "ami_id" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}


variable "subnet_ids" {
  # type = list(string)
  default = ""
}

variable "secg_id" {
  type    = string
  default = ""
}


variable "key_name" {
  default = ""
}

variable "connection_type" {
  default = ""
}

variable "connection_user" {
  default = ""
}

variable "connection_private_key" {
  default = ""
}

variable "file_source" {
  default = ""
}

variable "file_destination" {
  default = ""
}


variable "inline" {
  default = ""
}



variable "instType_priv" {
  description = "this variable will tell instance type"
  type        = string
  default     = ""

}

variable "ami_id_priv" {
  type    = string
  default = ""
}

variable "name_priv" {
  type    = string
  default = ""
}


variable "subnet_ids_priv" {
  default = ""
}

variable "secg_id_priv" {
  type    = string
  default = ""
}
variable "key_name_priv" {
  default = ""
}



