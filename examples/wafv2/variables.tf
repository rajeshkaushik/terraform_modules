variable "managed_rules" {
  type = list(object({
    gp_name         = string
    vendor_name     = string
    priority        = number
    override_action = string
    excluded_rules  = list(string)
  }))
  description = "List of Managed WAF rule groups."
  default = [
    {
      gp_name         = "AWSManagedRulesAmazonIpReputationList"
      vendor_name     = "AWS"
      priority        = 10
      override_action = "none"
      excluded_rules  = []
    },
    {
      gp_name         = "AWSManagedRulesAnonymousIpList"
      vendor_name     = "AWS"
      priority        = 20
      override_action = "none"
      excluded_rules  = []
    }
  ]
}

variable "ip_sets_rules" {
  type = list(object({
    name       = string
    priority   = number
    ip_set_arn = string
    action     = string
  }))
  description = "A rule to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "ip_rate_based_rule" {
  type = object({
    name     = string
    priority = number
    limit    = number
    action   = string
  })
  description = "A rate-based rule tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default = {
    name : "ip-rate-limit",
    priority : 50,
    action : "block",
    limit : 5000
  }
}

variable "geo_location_rules" {
  type = list(object({
    name          = string
    priority      = number
    country_codes = list(string)
    action        = string
  }))
  description = "Country codes based rules to control access from specified Geo locations."
  default = [
    {
      name          = "block_country_access"
      priority      = 30
      country_codes = ["KP", "PK"]
      action        = "block"
    }
  ]
}

variable "ip_rate_url_based_rules" {
  type = list(object({
    name                  = string
    priority              = number
    limit                 = number
    action                = string
    search_string         = string
    positional_constraint = string
  }))
  description = "A rate and url based rules tracks the rate of requests for each originating IP address, and triggers the rule action when the rate exceeds a limit that you specify on the number of requests in any 5-minute time span"
  default     = []
}

variable "group_rules" {
  type = list(object({
    name            = string
    arn             = string
    priority        = number
    override_action = string
    excluded_rules  = list(string)
  }))
  description = "List of WAFv2 Rule Groups."
  default     = []
}

variable "alb_arn" {
  type        = string
  description = "ARN of the ALB to be associated with the WAFv2 ACL."
  default     = ""
}

variable "apigateway_stage_arn" {
  type        = string
  description = "ARN of the API Gateway to be associated with the WAFv2 ACL."
  default     = ""
}

variable "default_action" {
  type        = string
  description = "The action to perform if none of the rules contained in the WebACL match."
  default     = "allow"
}
