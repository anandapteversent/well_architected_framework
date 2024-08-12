locals {
  well_architected_framework_perf02_common_tags = merge(local.well_architected_framework_performance_efficiency_common_tags, {
    question_id = "select-compute"
  })
}

benchmark "well_architected_framework_perf02" {
  title       = "PERF02 How do you select your compute solution?"
  description = "Selecting the most appropriate compute option for your workload allows you to improve performance, reduce unnecessary infrastructure costs, and lower the operational efforts required to maintain your workload."
  children = [
    benchmark.well_architected_framework_perf02_bp01,
    benchmark.well_architected_framework_perf02_bp04,
    benchmark.well_architected_framework_perf02_bp05
  ]

  tags = local.well_architected_framework_perf02_common_tags
}

benchmark "well_architected_framework_perf02_bp01" {
  title       = "BP01 Select the best compute options for your workload"
  description = "Selecting the most appropriate compute option for your workload allows you to improve performance, reduce unnecessary infrastructure costs, and lower the operational efforts required to maintain your workload."

  children = [
    aws_thrifty.control.ec2_instance_older_generation,
    aws_thrifty.control.ec2_instance_with_graviton,
    aws_thrifty.control.ecs_cluster_container_instance_with_graviton,
    aws_thrifty.control.eks_node_group_with_graviton,
    aws_thrifty.control.lambda_function_with_graviton,
    aws_thrifty.control.latest_rds_instance_types,
    aws_thrifty.control.emr_cluster_instance_prev_gen
  ]

  tags = merge(local.well_architected_framework_perf02_common_tags, {
    choice_id = "perf_select_compute_evaluate_options"
    risk      = "high"
  })
}

benchmark "well_architected_framework_perf02_bp04" {
  title       = "BP04 Configure and right-size compute resources"
  description = "Configure and right-size compute resources to match your workload’s performance requirements and avoid under- or over-utilized resources."

  children = [
    aws_thrifty.control.ec2_instance_older_generation,
    aws_thrifty.control.instances_with_low_utilization,
    aws_thrifty.control.long_running_ec2_instances,
    aws_thrifty.control.ecs_cluster_low_utilization,
    aws_thrifty.control.rds_db_low_utilization,
    aws_thrifty.control.latest_rds_instance_types,
    aws_thrifty.control.redshift_cluster_low_utilization
  ]

  tags = merge(local.well_architected_framework_perf02_common_tags, {
    choice_id = "perf_select_compute_right_sizing"
    risk      = "high"
  })
}

benchmark "well_architected_framework_perf02_bp05" {
  title       = "BP05 Scale your compute resources dynamically"
  description = "Use the elasticity of the cloud to scale your compute resources up or down dynamically to match your needs and avoid over- or under-provisioning capacity for your workload."

  children = [
    aws_thrifty.control.ecs_service_without_autoscaling,
    aws_compliance.control.dynamodb_table_auto_scaling_enabled
  ]

  tags = merge(local.well_architected_framework_perf02_common_tags, {
    choice_id = "perf_select_compute_elasticity"
    risk      = "high"
  })
}

