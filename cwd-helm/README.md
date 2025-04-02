# Helm Charts for Cloud Watchdog

## Helm Deployment
This repo needs to work together with [cwd-ops](https://bitbucket.oci.oraclecorp.com/projects/OCWS/repos/cwd-ops/browse) repo.

Assuming you have both repos under same parent folder, at the root of **this** project, start the script from `cwd-ops` repo:

```shell script
$ pwd
....../cwd-helm

$ ls ../cwd-ops
control-plane.sh docker           profiles         scripts

$ ../cwd-ops/control-plane.sh cwd-staging

Executing scripts from /init.d/[0-9]*-*.sh

```

After the control-plane container is started, deploy the needed helm chart under `charts/` folder

```
$ pwd
/workspace

$ cd /workspace/charts/cwd-coordinator
$ helmfile list
NAME           	NAMESPACE	ENABLED	LABELS
cwd-coordinator	cwd-apps 	true
$ helmfile diff
$ helmfile apply
```

## Secrets Management

To add secrets to the vault, login to the valut from the control-plane container (only granted to users in Administrator group)
```
$ vault login -method=oci auth_type=apikey role=oci_administrators
```

Write the secrets to the desired path in the vault secret store, using path of pattern 
`secret/<env>/apps/cloudwatchdog/<component>`, which is where vault policy is configured to access from pods in kubernetes. 
For example, for `<env>` be `cwd-staging`, and `<component>` be `test`:
``` 
$ vault kv put secret/cwd-staging/apps/cloudwatchdog/test CWD_DB_PASS=abc123

$ vault kv get secret/cwd-staging/apps/cloudwatchdog/test
======= Data =======
Key            Value
---            -----
CWD_DB_PASS    abc123
```

To update the secret on the same path by adding more fields, you need to use `patch` command, 
otherwise the existing values on the secret path will be overwritten by `put` action:
```
$ vault kv patch secret/cwd-staging/apps/cloudwatchdog/test ANOTHER_PASS=cde456
```

After the secrets are saved into the vault, you can reference the key of the vault path to your secret field in your pod, 
helm values, etc. For example:
```
vault:secret/data/cwd-staging/apps/cloudwatchdog/test#CWD_DB_PASS
```

**NOTE** the `data` in the path that is different when inserting the secrets. 
For example: https://bitbucket.oci.oraclecorp.com/projects/OCWS/repos/cwd-helm/browse/environments/cwd-staging/cwd-coordinator.yaml#35

To allow the pods to retrieve the secret from the vault, add the annotation of
 `vault.security.banzaicloud.io/vault-role: "<env>_apps_cloudwatchdog"` to the pod, where the `<env>` is the name of 
 deployment environment, such as `cwd-staging`.