locals {
  well_architected_framework_perf04_common_tags = merge(local.well_architected_framework_performance_efficiency_common_tags, {
    question_id = "select-network"
  })
}

benchmark "well_architected_framework_perf04" {
  title       = "PERF03 How do you configure your networking solution?"
  description = "The optimal networking solution for a workload varies based on latency, throughput requirements, jitter, and bandwidth. Physical constraints, such as user or on-premises resources, determine location options. These constraints can be offset with edge locations or resource placement."
  children = [
    benchmark.well_architected_framework_perf04_bp06,
    benchmark.well_architected_framework_perf04_bp07
  ]

  tags = local.well_architected_framework_perf04_common_tags
}

benchmark "well_architected_framework_perf04_bp06" {
  title       = "BP06 Choose your workload's location based on network requirements"
  description = "Evaluate options for resource placement to reduce network latency and improve throughput, providing an optimal user experience by reducing page load and data transfer times."

  children = [
    aws_compliance.control.vpc_flow_logs_enabled

  ]

  tags = merge(local.well_architected_framework_perf04_common_tags, {
    choice_id = "perf_select_network_location"
    risk      = "high"
  })
}

benchmark "well_architected_framework_perf04_bp07" {
  title       = "BP07 Optimize network configuration based on metrics"
  description = "Use collected and analyzed data to make informed decisions about optimizing your network configuration."

  children = [
    aws_compliance.control.vpc_flow_logs_enabled

  ]

  tags = merge(local.well_architected_framework_perf04_common_tags, {
    choice_id = " perf_select_network_optimize"
    risk      = "high"
  })
}

