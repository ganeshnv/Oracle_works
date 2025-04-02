
# Logging

This chart is a bit to get around helm v2 limitations. We use master helmfile
`./helmfile.yaml` which declared two helmfile dependencies to ensure that we
deploy those dependencies in sequence. This way, CRDs are deployed before eny
resources from `logging-common`.

# Archaeology
It appears team silver host image has lumberjack connectivity baked into it, since we never configure any information about how to send data to lumberjack (where it lives).

We are therefore using instance principles from the VM host that the logging fluentd docker container runs on, which is in the OKE cluster.  A dynamic grouop enables those hosts to send logs to lumberjack.  And then we also enable a group to read the logs in the devops portal:
https://devops.oci.oraclecorp.com/logs

## Terminology
BOAT = BMC Operator Access Tenancy
https://confluence.oci.oraclecorp.com/pages/viewpage.action?pageId=30807408

https://confluence.oci.oraclecorp.com/display/~yeshan/BOAT+Tenancy+Policy+Reference

BOAT Group:  The boat group is used to authorize reading logs in lumberjack for some core oracle opearator access thingie.  We don't really know what group we should be using.   The id hardcoded into the defaults is of the group `ent_devsecops-service-spotlight`.
https://console.us-ashburn-1.oraclecloud.com/identity/groups/ocid1.group.oc1..aaaaaaaapxlinoiswyknpxt7vwufi3dvoyvslk5vv22uwwlyjtti276gaavq

It was chosen because some of us seem to be enrolled in that group (in addtion to `ent_sccp-service-admin` which was not used.)

### TODO
 Would be better to have some confirmation that this is the right group?

# Docs


Lumberjack: https://confluence.oci.oraclecorp.com/display/LUM/Lumberjack+-+Logging

Gives info about policies:
https://confluence.oci.oraclecorp.com/display/ID/Lumberjack+V2+Design+and+Implementation

Gives other info about policies:
https://confluence.oci.oraclecorp.com/display/LUM/V2+Onboarding+steps


## Outputting to Lumberjack
Uses the oci fluentd output plugin:
https://bitbucket.oci.oraclecorp.com/projects/CNP/repos/fluentd-k8s-daemonset-lumberjack/browse

```
log_group is derived, in order of precedence, as follows: ..* record field lumberjack_log_group : if set then the plugin will use the value of this field (the key-value is then removed from the record). ..* record field kubernetes.labels.log_group : if set then the plugin will use the value of this field (the key-value is retained in the record). ..* record field kubernetes.namespace_name : if set to the value "kube-system" then the plugin will set "k8s" as the log-group ..* default: the value "app" will be used as the log-group 
```

Since log groups MUST be created in advance in lumberjack (using the lumberjack-tool), this terraform plan creates the app and k8s log groups.

### TODO: Building the fluentd docker container with lumberjack output
Right now, it exists in our docker dev registry.  But the dockerfile/build aren't reproducable. 

* Should extend the bonzaicloud base fluentd image:   `FROM banzaicloud/fluentd:v1.7.4-alpine-12`
* Our Dockerfile should codify the instructions at https://bitbucket.oci.oraclecorp.com/projects/CNP/repos/fluentd-k8s-daemonset-lumberjack/browse to install the required gems in our docker image. (It the gems required are shown here: https://github.com/zzmzzm90/logging-operator/blob/ed56a957aa5f4384a6e3a5bbead3cc771df4005b/fluentd-image/v1.7/Dockerfile#L71 but need to be installed from artifactory inside the Dockerfile, not copied from the user's machine)
* Seems like the cert needs to be installed in `/home/fluent/certs/` from here: https://bitbucket.oci.oraclecorp.com/projects/CNP/repos/fluentd-k8s-daemonset-lumberjack/browse/certs
* A build should be created in Hudson to build and push it to our docker registry.

### TODO: Auto build of our Docker Image for Logging Operator
We have a branch of the operator code because it has to support lumberjack output in code.
Need to auto build the dockerfile from that branch at some point to publish to our registry:
https://github.com/zzmzzm90/logging-operator/blob/master/Dockerfile

### Not relevent
Using Lumberjack From Fluentbit:
https://confluence.oraclecorp.com/confluence/display/CPSRE/Unofficial+OKE+Fluentbit+Lumberjack+Logging

Sets log group based on namespace here:
https://orahub.oraclecorp.com/saas-dev-black/fluentbit-plugin-oci-lumberjack/blob/master/out_lumberjack.go#L259
