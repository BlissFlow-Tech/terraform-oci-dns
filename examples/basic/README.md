# Basic example

Creates a public primary zone with DNSSEC and a secondary zone replicated from an external master.

```sh
terraform init
terraform apply -var compartment_id=<compartment-ocid>
```
