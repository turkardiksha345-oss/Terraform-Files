variable "aws_region" {
  default = "eu-north-1"
}

variable "cluster_name" {
  default = "demo-eks-cluster1"
}

variable "node_instance_type" {
  default = "m7i-flex.large"
}

variable "desired_nodes" {
  default = 2
}
