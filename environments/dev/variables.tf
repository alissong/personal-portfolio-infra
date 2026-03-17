variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "domain_name" {
  type        = string
  description = "Root domain hosted in Route 53"
}

variable "record_name" {
  type        = string
  description = "DNS record name. Use @ for root domain or a subdomain like www"
}

variable "zone_id" {
  type        = string
  description = "Route 53 Hosted Zone ID"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2"
}

variable "ecr_registry" {
  type        = string
  description = "Base ECR registry URL"
}

variable "ecr_image" {
  type        = string
  description = "Full ECR image URL with tag"
}