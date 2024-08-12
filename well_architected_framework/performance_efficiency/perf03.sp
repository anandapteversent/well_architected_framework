locals {
  well_architected_framework_perf03_common_tags = merge(local.well_architected_framework_performance_efficiency_common_tags, {
    question_id = "right-storage-solution"
  })
}

benchmark "well_architected_framework_perf03" {
  title       = "PERF03 How do you select your storage solution?"
  description = "Understand data characteristics (like shareable, size, cache size, access patterns, latency, throughput, and persistence of data) to select the right purpose-built data stores (storage or database) for your workload."
  children = [
    benchmark.well_architected_framework_perf03_bp01,
    benchmark.well_architected_framework_perf03_bp03
  ]

  tags = local.well_architected_framework_perf02_common_tags
}

benchmark "well_architected_framework_perf03_bp01" {
  title       = "BP01 Use a purpose-built data store that best supports your data access and storage requirements"
  description = "Understand data characteristics (like shareable, size, cache size, access patterns, latency, throughput, and persistence of data) to select the right purpose-built data stores (storage or database) for your workload."

  children = [
    aws_thrifty.control.ebs_with_low_usage,
    aws_thrifty.control.high_iops_ebs_volumes,
    aws_thrifty.control.large_ebs_volumes,
    aws_thrifty.control.low_iops_ebs_volumes,
    aws_thrifty.control.stale_dynamodb_table_data
  ]

  tags = merge(local.well_architected_framework_perf02_common_tags, {
    choice_id = "perf_select_compute_evaluate_options"
    risk      = "high"
  })
}

benchmark "well_architected_framework_perf03_bp03" {
  title       = "BP03 Collect and record data store performance metrics"
  description = "Track and record relevant performance metrics for your data store to understand how your data management solutions are performing. These metrics can help you optimize your data store, verify that your workload requirements are met, and provide a clear overview on how the workload performs."

  children = [
    aws_compliance.control.rds_db_instance_logging_enabled,
    aws_compliance.control.rds_db_instance_and_cluster_enhanced_monitoring_enabled

  ]

  tags = merge(local.well_architected_framework_perf02_common_tags, {
    choice_id = "perf_select_compute_evaluate_options"
    risk      = "high"
  })
}