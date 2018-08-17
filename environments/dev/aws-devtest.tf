variable "aws_account_id" {
  type    = "string"
  default = "429061350814"
}

variable "aws_region" {
  type    = "string"
  default = "eu-west-2"
}

variable "aws_az_a" {
  type    = "string"
  default = "eu-west-2a"
}

variable "aws_az_b" {
  type    = "string"
  default = "eu-west-2b"
}

provider "aws" {
  allowed_account_ids = ["${var.aws_account_id}"]
  region              = "${var.aws_region}"
}

variable "elastic-beanstalk-single-docker" {
  type    = "string"
  default = "64bit Amazon Linux 2018.03 v2.12.1 running Docker 18.03.1-ce"
}

variable "elastic-beanstalk-Java" {
  type    = "string"
  default = "64bit Amazon Linux 2018.03 v2.7.3 running Java 8"
}

variable "elastic-beanstalk-Node" {
  type    = "string"
  default = "64bit Amazon Linux 2018.03 v4.5.2 running Node.js"
}

locals {
  elb_ssl_policy = "ELBSecurityPolicy-TLS-1-2-2017-01"
}

#Config for Azure
locals {
  azure_dns_zone_name = "hmpps.dsd.io"
  azure_dns_zone_rg   = "webops"
}
