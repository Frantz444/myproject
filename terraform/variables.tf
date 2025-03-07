variable "VPCID" {
    description = "VPC of project"
    type = string
    default = "my_vpc"
}

variable "InstanceCount" {
    description = "EC2 Instance Count"
    type = string
    default = "1"
}

variable "Ami_id" {
    description = "ID of AMI to use for the instance"
    type = string
    default = "my_ami"
}

variable "EC2_instance_type" {
      description = "EC2 instance type"
    type = string
    default = "t2.micro"
}

variable "RdsEngine" {
    description = "RDS Engine"
    type = string
    default = "postgres"
}

variable "RdsInstanceType" {
    description = "RDS Engine Type"
    type = string
    default = "db.t3.micro"
}

variable "RDSAdminUser" {
    description = "DB Admin User"
    type = string
    default = "admin"
}

