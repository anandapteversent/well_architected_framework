locals {
  well_architected_framework_sustainability_common_tags = merge(local.well_architected_framework_common_tags, {
    pillar_id = "sustainability"
  })
}

benchmark "well_architected_framework_sustainability" {
  title       = "Sustainability"
  description = "Sustainability pillar provides design principles, operational guidance, best-practices, potential trade-offs, and improvement plans you can use to meet sustainability targets for your AWS workloads."
  children = [
    benchmark.well_architected_framework_sus02,
    benchmark.well_architected_framework_sus04,
    benchmark.well_architected_framework_sus05,
    benchmark.well_architected_framework_sus06
  ]

  tags = local.well_architected_framework_sustainability_common_tags
}
