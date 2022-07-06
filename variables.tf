variable "custom_vpc" {
  default     = true
  description = "Set to true or false whether you want a new VPC to be created"
}

variable "default_vpc" {
  default     = false
  description = "Set to true or false whether you want to use the default VPC"
}

variable "vpc_cidr" {
  default     = "172.16.0.0/16"
  description = "VPC CIDR Range"
}

variable "env_name" {
  default     = "Dev"
  description = "Environment name -reqired-"
}

variable "subnets_names" {
  default     = ["External", "Internal", "Shared_Services", "Reach_Back"]
  description = "List with the name of the subnet blocks "
}

variable "public_ip" {
  default     = [true, false, false, true]
  description = "Bool list as per it relates to subnets_names list"
}

variable "az_list" {
  default     = ["us-east-1a", "us-east-1b"]
  description = "Define the number of AZ for each subnet block"
}

variable "subnets_cidr" {
  default = [
    "172.16.0.0/25",
    "172.16.0.128/25",
    "172.16.1.0/25",
    "172.16.1.128/25",
    "172.16.2.0/25",
    "172.16.2.128/25",
    "172.16.3.0/25",
    "172.16.3.128/25",
  ]

  description = "List of cidr ranges to be used in the subnets creation"
}

variable "nat_gw_subnet" {
  default     = "External"
  description = "Name of the subnet block where you want the nat gateway gets deployed"
}

