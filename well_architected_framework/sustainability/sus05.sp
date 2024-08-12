locals {
  well_architected_framework_sus05_common_tags = merge(local.well_architected_framework_sustainability_common_tags, {
    question_id = "sus_hardware"
  })
}

benchmark "well_architected_framework_sus05" {
  title       = "SUS05 How do you select and use cloud hardware and services in your architecture to support your sustainability goals?"
  description = "Look for opportunities to reduce workload sustainability impacts by making changes to your hardware management practices. Minimize the amount of hardware needed to provision and deploy, and select the most efficient hardware and services for your individual workload."
  children = [
    benchmark.well_architected_framework_sus05_bp01,
    benchmark.well_architected_framework_sus05_bp02
  ]

  tags = local.well_architected_framework_sus05_common_tags
}

benchmark "well_architected_framework_sus05_bp01" {
  title       = "BP01 Use the minimum amount of hardware to meet your needs"
  description = "Use the minimum amount of hardware for your workload to efficiently meet your business needs."

  children = [
    aws_thrifty.control.ebs_with_low_usage,
    aws_thrifty.control.instances_with_low_utilization,
    aws_thrifty.control.ec2_network_lb_unused,
    aws_thrifty.control.ec2_application_lb_unused,
    aws_thrifty.control.ec2_gateway_lb_unused,
    aws_thrifty.control.ecs_cluster_low_utilization,
    aws_thrifty.control.rds_db_low_utilization,
    aws_thrifty.control.redshift_cluster_low_utilization
  ]

  tags = merge(local.well_architected_framework_sus05_common_tags, {
    choice_id = "sus_sus_hardware_a2"
    risk      = "high"
  })
}

benchmark "well_architected_framework_sus05_bp02" {
  title       = "BP02 Use instance types with the least impact"
  description = "Continually monitor and use new instance types to take advantage of energy efficiency improvements."

  children = [
    aws_thrifty.control.ec2_instance_with_graviton,
    aws_thrifty.control.ecs_cluster_container_instance_with_graviton,
    aws_thrifty.control.eks_node_group_with_graviton,
    aws_thrifty.control.rds_db_instance_with_graviton
  ]

  tags = merge(local.well_architected_framework_sus05_common_tags, {
    choice_id = "sus_sus_hardware_a3"
    risk      = "high"
  })
}
