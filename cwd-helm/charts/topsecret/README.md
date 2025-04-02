
Good example with full Vault CRD:
https://github.com/banzaicloud/bank-vaults/issues/591

How to generate fingerprint:
 https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#How3
Example:
  openssl rsa -pubout -outform DER -in ~/.oci/oci_api_key.pem | openssl md5 -c

# Issues

Vaults Kubernetes Auth requires ClusterRole `system:auth-delegator` to be able
to validate JWT tokens requested by vault-webhook.

```console
User "system:serviceaccount:system-secret:topsecret-vault-operator" cannot create tokenreviews
https://github.com/banzaicloud/bank-vaults/issues/657#issuecomment-529827404
```
