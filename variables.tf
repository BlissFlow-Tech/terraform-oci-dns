variable "compartment_id" {
  description = "The OCID of the compartment the zones will reside in"
  type        = string
}

variable "zones" {
  description = "Map of OCI DNS zones to create"
  type = map(object({
    name          = string
    zone_type     = optional(string, "PRIMARY")
    dnssec_state  = optional(string, "DISABLED")
    scope         = optional(string, "GLOBAL")
    view_id       = optional(string)
    freeform_tags = optional(map(string), {})
    defined_tags  = optional(map(string), {})

    external_downstreams = optional(list(object({
      address     = string
      port        = optional(number)
      tsig_key_id = optional(string)
    })), [])

    external_masters = optional(list(object({
      address     = string
      port        = optional(number)
      tsig_key_id = optional(string)
    })), [])
  }))
}
