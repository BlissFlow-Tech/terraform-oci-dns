module "dns" {
  source = "../.."

  compartment_id = var.compartment_id

  zones = {
    public = {
      name         = "example.com"
      dnssec_state = "ENABLED"
    }
    partner = {
      name      = "partner.example.com"
      zone_type = "SECONDARY"
      external_masters = [
        { address = "192.0.2.10", port = 53 },
      ]
    }
  }
}

output "nameservers" {
  value = { for k, z in module.dns.zones : k => z.nameservers }
}
