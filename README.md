# terraform-oci-dns

Terraform module that manages OCI DNS zones: primary or secondary, global or private, with DNSSEC and zone-transfer servers.

## Usage

```hcl
module "dns" {
  source  = "blissflow-tech/dns/oci"
  version = "~> 1.0"

  compartment_id = var.compartment_id

  zones = {
    public = {
      name         = "example.com"
      dnssec_state = "ENABLED"
    }
    internal = {
      name    = "internal.example.com"
      scope   = "PRIVATE"
      view_id = var.dns_view_id
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
```

The `zones` output is keyed like the input map, and each zone carries its assigned `nameservers`.

## Notes

* Private zones need `scope = "PRIVATE"` and the OCID of a DNS view in `view_id`.
* `external_masters` feed secondary zones through zone transfers; `external_downstreams` receive transfers from a primary zone.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >= 1.3 |
| oci | >= 8.0, < 10.0 |

## Providers

| Name | Version |
| ---- | ------- |
| oci | >= 8.0, < 10.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [oci_dns_zone.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| compartment\_id | The OCID of the compartment the zones will reside in | `string` | n/a | yes |
| zones | Map of OCI DNS zones to create | <pre>map(object({<br/>    name          = string<br/>    zone_type     = optional(string, "PRIMARY")<br/>    dnssec_state  = optional(string, "DISABLED")<br/>    scope         = optional(string, "GLOBAL")<br/>    view_id       = optional(string)<br/>    freeform_tags = optional(map(string), {})<br/>    defined_tags  = optional(map(string), {})<br/><br/>    external_downstreams = optional(list(object({<br/>      address     = string<br/>      port        = optional(number)<br/>      tsig_key_id = optional(string)<br/>    })), [])<br/><br/>    external_masters = optional(list(object({<br/>      address     = string<br/>      port        = optional(number)<br/>      tsig_key_id = optional(string)<br/>    })), [])<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| zones | DNS zones keyed like the zones input, each with its assigned nameservers |
<!-- END_TF_DOCS -->

## License

Apache 2.0. See [LICENSE](LICENSE).
