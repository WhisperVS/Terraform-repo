variable "allocated_storage" {
    type = number
  description = "allocated storage size"
}

variable "db_name" {
  type = string
  description = "database name"
}

variable "engine" {
  type = string
  description = "db engine"
}

variable "engine_version" {
  type = number
  description = "engine version"
}

variable "instance_class" {
  type = string
  description = "instance class"
}

variable "username" {
  type = string
  description = "username"
}

variable "password" {
  type = string
  description = "db password"
}

variable "skip_final_snapshot" {
  type = bool
  description = "skip final snapshot true"
}