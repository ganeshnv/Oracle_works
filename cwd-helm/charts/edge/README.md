# CRDs for Certmanager
 From https://raw.githubusercontent.com/jetstack/cert-manager/release-0.10/deploy/manifests/00-crds.yaml
 
See https://docs.cert-manager.io/en/latest/getting-started/install/kubernetes.html

These need to get deployed before the cert-manager-selfsigned-clusterisser since otherwise get:
` Error: [unable to recognize "": no matches for kind "Certificate" in version "certmanager.k8s.io/v1alpha1", unable to recognize "": no matches for kind "ClusterIssuer" in version "certmanager.k8s.io/v1alpha1", unable to recognize "": no matches for kind "Issuer" in version "certmanager.k8s.io/v1alpha1"]`

Fundamental problem is that they don't support the CRD inside the helm chart, so we have to manage and deploy it ourselves in our helm chart

In addition, the certmanager requires:
```
# Disable resource validation on the cert-manager namespace
 kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
 ```

Since this is painful to add to helm using jobs (due to need for service accounts), instead, we do it in the helmfile with hooks.