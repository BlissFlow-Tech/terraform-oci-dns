output "zones" {
  description = "DNS zones keyed like the zones input, each with its assigned nameservers"
  value = {
    for name, zone in oci_dns_zone.this : name => {
      id                    = zone.id
      compartment_id        = zone.compartment_id
      name                  = zone.name
      zone_type             = zone.zone_type
      dnssec_config         = zone.dnssec_config
      dnssec_state          = zone.dnssec_state
      external_downstreams  = zone.external_downstreams
      external_masters      = zone.external_masters
      is_protected          = zone.is_protected
      scope                 = zone.scope
      self                  = zone.self
      serial                = zone.serial
      nameservers           = [for ns in zone.nameservers : ns.hostname]
      defined_tags          = zone.defined_tags
      freeform_tags         = zone.freeform_tags
      state                 = zone.state
      time_created          = zone.time_created
      version               = zone.version
      view_id               = zone.view_id
      zone_transfer_servers = zone.zone_transfer_servers
    }
  }
}
