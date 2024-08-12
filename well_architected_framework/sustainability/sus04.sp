locals {
  well_architected_framework_sus04_common_tags = merge(local.well_architected_framework_sustainability_common_tags, {
    question_id = "sus_data"
  })
}

benchmark "well_architected_framework_sus04" {
  title       = "SUS04 How do you take advantage of data management policies and patterns to support your sustainability goals?"
  description = "Implement data management practices to reduce the provisioned storage required to support your workload, and the resources required to use it. Understand your data, and use storage technologies and configurations that best support the business value of the data and how it’s used. Lifecycle data to more efficient, less performant storage when requirements decrease, and delete data that’s no longer required."
  children = [
    benchmark.well_architected_framework_sus04_bp03,
    benchmark.well_architected_framework_sus04_bp05
  ]

  tags = local.well_architected_framework_sus04_common_tags
}

benchmark "well_architected_framework_sus04_bp03" {
  title       = "BP03 Use policies to manage the lifecycle of your datasets"
  description = "Manage the lifecycle of all of your data and automatically enforce deletion to minimize the total storage required for your workload."

  children = [
    aws_thrifty.control.buckets_with_no_lifecycle,
    aws_thrifty.control.ebs_snapshot_max_age
  ]

  tags = merge(local.well_architected_framework_sus04_common_tags, {
    choice_id = "sus_sus_data_a4"
    risk      = "high"
  })
}

benchmark "well_architected_framework_sus04_bp05" {
  title       = "BP05 Remove unneeded or redundant data"
  description = "Remove unneeded or redundant data to minimize the storage resources required to store your datasets."

  children = [
    aws_thrifty.control.unattached_ebs_volumes,
    aws_thrifty.control.large_ebs_volumes,
    aws_thrifty.control.ebs_with_low_usage,
    aws_thrifty.control.stale_dynamodb_table_data
  ]

  tags = merge(local.well_architected_framework_sus04_common_tags, {
    choice_id = "sus_sus_data_a4"
    risk      = "high"
  })
}
