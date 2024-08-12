locals {
  well_architected_framework_sus02_common_tags = merge(local.well_architected_framework_sustainability_common_tags, {
    question_id = "sus_user"
  })
}

benchmark "well_architected_framework_sus02" {
  title       = "SUS02 How do you align cloud resources to your demand?"
  description = "The way users and applications consume your workloads and other resources can help you identify improvements to meet sustainability goals. Scale infrastructure to continually match demand and verify that you use only the minimum resources required to support your users."
  children = [
    benchmark.well_architected_framework_sus02_bp01,
    benchmark.well_architected_framework_sus02_bp03
  ]

  tags = local.well_architected_framework_sus02_common_tags
}

benchmark "well_architected_framework_sus02_bp01" {
  title       = "BP01 Scale workload infrastructure dynamically"
  description = "Use elasticity of the cloud and scale your infrastructure dynamically to match supply of cloud resources to demand and avoid overprovisioned capacity in your workload."

  children = [
    aws_thrifty.control.ecs_service_without_autoscaling,
    aws_compliance.control.dynamodb_table_auto_scaling_enabled
  ]

  tags = merge(local.well_architected_framework_sus02_common_tags, {
    choice_id = "sus_sus_user_a2"
    risk      = "high"
  })
}

benchmark "well_architected_framework_sus02_bp03" {
  title       = "BP03 Stop the creation and maintenance of unused assets"
  description = "Decommission unused assets in your workload to reduce the number of cloud resources required to support your demand and minimize waste."

  children = [
    aws_thrifty.control.ec2_application_lb_unused,
    aws_thrifty.control.ec2_classic_lb_unused,
    aws_thrifty.control.ec2_gateway_lb_unused,
    aws_thrifty.control.ebs_snapshot_max_age,
    aws_thrifty.control.ebs_volumes_on_stopped_instances,
    aws_thrifty.control.unattached_ebs_volumes,
    aws_thrifty.control.unattached_eips,
    aws_thrifty.control.vpc_nat_gateway_unused,

  ]

  tags = merge(local.well_architected_framework_sus02_common_tags, {
    choice_id = "sus_sus_user_a2"
    risk      = "high"
  })
}
