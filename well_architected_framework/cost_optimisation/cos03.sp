locals {
  well_architected_framework_cos03_common_tags = merge(local.well_architected_framework_cost_optimisation_common_tags, {
    question_id = "monitor-usage"
  })
}

benchmark "well_architected_framework_cos03" {
  title       = "COS03 How do you monitor usage and cost?"
  description = "Do we have appropriate level of monitoring for AWS components and associated costs?"
  children = [
    benchmark.well_architected_framework_cos03_bp01,
    benchmark.well_architected_framework_cos03_bp06
  ]

  tags = local.well_architected_framework_cos03_common_tags
}

benchmark "well_architected_framework_cos03_bp01" {
  title       = "BP01 Configure detailed information sources"
  description = "Set up cost management and reporting tools for enhanced analysis and transparency of cost and usage data. Configure your workload to create log entries that facilitate the tracking and segregation of costs and usage."

  children = [
    aws_thrifty.control.full_month_cost_changes
  ]

  tags = merge(local.well_architected_framework_cos03_common_tags, {
    choice_id = "cost_monitor_usage_detailed_source"
    risk      = "high"
  })
}

benchmark "well_architected_framework_cos03_bp06" {
  title       = "BP06 Allocate costs based on workload metrics"
  description = "Allocate the workload's costs based on usage metrics or business outcomes to measure workload cost efficiency. Implement a process to analyze the cost and usage data with analytics services, which can provide insight and charge back capability."

  children = [
    aws_tags.control.ebs_volume_untagged,
    aws_tags.control.ebs_snapshot_untagged,
    aws_tags.control.dynamodb_table_untagged,
    aws_tags.control.ec2_application_load_balancer_untagged,
    aws_tags.control.ec2_instance_untagged,
    aws_tags.control.ecs_container_instance_untagged,
    aws_tags.control.rds_db_cluster_untagged,
    aws_tags.control.efs_file_system_untagged,
    aws_tags.control.vpc_nat_gateway_untagged
  ]

  tags = merge(local.well_architected_framework_cos03_common_tags, {
    choice_id = "cost_monitor_usage_allocate_outcome"
    risk      = "high"
  })
}
