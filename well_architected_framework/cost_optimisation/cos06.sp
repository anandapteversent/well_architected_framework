locals {
  well_architected_framework_cos06_common_tags = merge(local.well_architected_framework_cost_optimisation_common_tags, {
    question_id = "type-size-number-resources"
  })
}

benchmark "well_architected_framework_cos06" {
  title       = "COS06  How do you meet cost targets when you select resource type, size and number?"
  description = "Select resources based on collected metrics and validate against the cost targets"
  children = [
    benchmark.well_architected_framework_cos06_bp02,
    benchmark.well_architected_framework_cos06_bp03,
    benchmark.well_architected_framework_cos06_bp04
  ]

  tags = local.well_architected_framework_cos06_common_tags
}

benchmark "well_architected_framework_cos06_bp03" {
  title       = "BP03 Select resource type, size, and number automatically based on metrics"
  description = "Use metrics from the currently running workload to select the right size and type to optimize for cost. Appropriately provision throughput, sizing, and storage for compute, storage, data, and networking services. This can be done with a feedback loop such as automatic scaling or by custom code in the workload."

  children = [
    aws_thrifty.control.ebs_with_low_usage,
    aws_thrifty.control.rds_db_low_utilization,
    aws_thrifty.control.instances_with_low_utilization,
    aws_thrifty.control.long_running_ec2_instances,
    aws_thrifty.control.ecs_cluster_low_utilization,
    aws_thrifty.control.redshift_cluster_low_utilization,
    aws_thrifty.control.cw_log_group_retention,
    aws_thrifty.control.high_iops_ebs_volumes
  ]

  tags = merge(local.well_architected_framework_cos06_common_tags, {
    choice_id = "cost_type_size_number_resources_metrics"
    risk      = "medium"
  })
}

benchmark "well_architected_framework_cos06_bp02" {
  title       = "BP02 Select resource type, size, and number automatically based on data"
  description = "Select resource size or type based on data about the workload and resource characteristics. For example, compute, memory, throughput, or write intensive. This selection is typically made using a previous (on-premises) version of the workload, using documentation, or using other sources of information about the workload."

  children = [
    aws_thrifty.control.ec2_instance_older_generation,
    aws_thrifty.control.gp2_volumes,
    aws_thrifty.control.io1_volumes,
    aws_thrifty.control.unattached_ebs_volumes,
    aws_thrifty.control.vpc_nat_gateway_unused,
    aws_thrifty.control.unattached_eips,
    aws_thrifty.control.latest_rds_instance_types,
    aws_thrifty.control.ec2_application_lb_unused,
    aws_thrifty.control.lambda_function_with_graviton,
    aws_thrifty.control.cw_log_stream_unused
  ]

  tags = merge(local.well_architected_framework_cos06_common_tags, {
    choice_id = "cost_type_size_number_resources_data"
    risk      = "medium"
  })
}

benchmark "well_architected_framework_cos06_bp04" {
  title       = "BP04 Consider using shared resources"
  description = "For already-deployed services at the organization level for multiple business units, consider using shared resources to increase utilization and reduce total cost of ownership (TCO). Using shared resources can be a cost-effective option to centralize the management and costs by using existing solutions, sharing components, or both. Manage common functions like monitoring, backups, and connectivity either within an account boundary or in a dedicated account. You can also reduce cost by implementing standardization, reducing duplication, and reducing complexity."

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

  tags = merge(local.well_architected_framework_cos06_common_tags, {
    choice_id = "cost_type_size_number_resources_data"
    risk      = "medium"
  })
}
