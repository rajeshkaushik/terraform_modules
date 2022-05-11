provider "aws" {
  region = "us-east-1"
  profile = "dev_admin"
}

module wafv2_acl {
  source = "../../modules/wafv2"
  name   = "test_web_acl"

  scope  = "REGIONAL"

  apigateway_stage_arn   =  var.apigateway_stage_arn

  managed_rules = var.managed_rules

  ip_rate_based_rule = var.ip_rate_based_rule

  geo_location_rules = var.geo_location_rules

  web_acl_tags = {
    testRajesh : "testAcl"
  }
}