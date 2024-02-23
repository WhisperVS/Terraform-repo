variable "subnets" {
  type = map(any)
}
######################## SUBNET VARS #############################
variable "subnets_to_associate" {
  default = ["pub_sub_1", "pub_sub_2", "pub_sub_3"]
}
####################### SG PORTS VARS  ######################
variable "ingress_ports" {
  default = {
    http  = 80
    https = 443
    ssh   = 22
  }
}
############################## EC2 AMAZON LINUX 2 VARS #######################
variable "ami" {
  type = string
}
##################################  SSH-KEY VARS ###########################
variable "public_key" {
  type = string
}
####################################  RDS VARS ##############################
variable "allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = number
}

variable "instance_class" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

variable "storage_type" {
  type = string
}
