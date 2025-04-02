Based on https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/oracle.md

Uses consul templates for the vault webhook:
https://github.com/banzaicloud/bank-vaults/blob/35e3ac4484fe1097d87cbc0858f6a5bdcc08b657/docs/mutating-webhook/consul-template.md

Be very careful with your:
  ociUserFingerprintVaultTmpl
  ociUserPrivateKeyVaultTmpl
as they are consul templates.
The private key must be indented 4 in the template (see the values file for an example.)

# Issues

```
(view) vault.read(secret/data/app_infra/external_dns): no secret exists at secret/data/app_infra/external_dns (retry attempt 7 after "16s")
https://github.com/hashicorp/consul-template/issues/1146#issuecomment-432865861
```
