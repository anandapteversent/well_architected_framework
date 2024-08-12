locals {
  well_architected_framework_cost_optimisation_common_tags = merge(local.well_architected_framework_common_tags, {
    pillar_id = "costOptimisation"
  })
}

benchmark "well_architected_framework_cost_optimisation" {
  title       = "Cost Optimisation"
  description = "Cost optimisation is a pillar that helps organisation to put appropriate measures on AWS to reduce waste and save costs"
  children = [
    benchmark.well_architected_framework_cos03,
    benchmark.well_architected_framework_cos06
  ]

  tags = local.well_architected_framework_cost_optimisation_common_tags
}
