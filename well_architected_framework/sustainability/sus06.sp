locals {
  well_architected_framework_sus06_common_tags = merge(local.well_architected_framework_sustainability_common_tags, {
    question_id = "sus_dev"
  })
}

benchmark "well_architected_framework_sus06" {
  title       = "SUS06 How do your organizational processes support your sustainability goals?"
  description = "Look for opportunities to reduce your sustainability impact by making changes to your development, test, and deployment practices."
  children = [
    benchmark.well_architected_framework_sus06_bp03
  ]

  tags = local.well_architected_framework_sus06_common_tags
}

benchmark "well_architected_framework_sus06_bp03" {
  title       = "BP03 Increase utilization of build environments"
  description = "Increase the utilization of resources to develop, test, and build your workloads."

  children = [
    aws_thrifty.control.ebs_with_low_usage,
    aws_thrifty.control.instances_with_low_utilization,
    aws_thrifty.control.ecs_cluster_low_utilization,
    aws_thrifty.control.rds_db_low_utilization,
    aws_thrifty.control.redshift_cluster_low_utilization
  ]

  tags = merge(local.well_architected_framework_sus06_common_tags, {
    choice_id = "sus_sus_hardsus_sus_dev_a4"
    risk      = "high"
  })
}
