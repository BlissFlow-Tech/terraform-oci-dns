resource "oci_dns_zone" "this" {
  for_each = var.zones

  compartment_id = var.compartment_id
  name           = each.value.name
  zone_type      = each.value.zone_type

  dnssec_state  = each.value.dnssec_state
  freeform_tags = each.value.freeform_tags
  defined_tags  = each.value.defined_tags
  scope         = each.value.scope
  view_id       = each.value.view_id

  dynamic "external_downstreams" {
    for_each = each.value.external_downstreams
    content {
      address     = external_downstreams.value.address
      port        = external_downstreams.value.port
      tsig_key_id = external_downstreams.value.tsig_key_id
    }
  }

  dynamic "external_masters" {
    for_each = each.value.external_masters
    content {
      address     = external_masters.value.address
      port        = external_masters.value.port
      tsig_key_id = external_masters.value.tsig_key_id
    }
  }
}
