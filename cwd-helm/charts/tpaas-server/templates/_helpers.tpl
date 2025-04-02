{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "tpaas-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "properties-name-api" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "api-properties" -}}
{{- end -}}

{{- define "properties-name-ui" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "ui-properties" -}}
{{- end -}}

{{- define "properties-name-interceptor" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "interceptor-properties" -}}
{{- end -}}

{{- define "properties-name-rate-limit" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "rate-limit-properties" -}}
{{- end -}}

{{- define "properties-name-webshell" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "webshell-properties" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tpaas-server.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tpaas-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "tpaas-server.labels" -}}
app.kubernetes.io/name: {{ include "tpaas-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "tpaas-server-api-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "api" -}}
{{- end -}}

{{- define "tpaas-server-ui-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "ui" -}}
{{- end -}}

{{- define "tpaas-server-interceptor-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "interceptor" -}}
{{- end -}}

{{- define "tpaas-server-rate-limit-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "rate-limit" -}}
{{- end -}}

{{- define "tpaas-server-report-server-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "report-server" -}}
{{- end -}}

{{- define "tpaas-server-webshell-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "webshell" -}}
{{- end -}}

{{- define "tpaas-server-gitbook-name" -}}
{{- printf "%s-%s"  (include "tpaas-server.name" .) "gitbook" -}}
{{- end -}}

{{- define "tpaas-server-api.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-api-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-ui.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-ui-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-interceptor.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-interceptor-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-rate-limit.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-rate-limit-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-report-server.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-report-server-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-webshell.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-webshell-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "tpaas-server-gitbook.labels" -}}
app.kubernetes.io/component: {{ include "tpaas-server-gitbook-name" . }}
{{ include "tpaas-server.labels" . }}
{{- end -}}

{{- define "image-url" -}}
{{- $imageRepo := required "image.repository is required" .Values.image.repository -}}
{{- $imageTag := required "image.tag is required" .Values.image.tag -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{- define "container-args" }}
{{- $params := . -}}
- {{ $params.name | quote }}
{{- if $params.extra }}
- {{ $params.extra | quote }}
{{- end }}
{{- end }}

{{- define "container-args-report" }}
{{- $params := . -}}
- {{ $params.id | quote }}
{{- if $params.endpoint }}
- {{ $params.endpoint | quote }}
{{- end }}
{{- if $params.region }}
- {{ $params.region | quote }}
{{- end }}
{{- if $params.bucket }}
- {{ $params.bucket | quote }}
{{- end }}
{{- end }}

{{- define "volume-mount-properties-api" -}}
- name: properties-file-api
  mountPath: /workspace/API/application.properties
  subPath: application.properties
  readOnly: true
{{- end -}}

{{- define "volume-properties-api" -}}
- name: properties-file-api
  configMap:
    name: {{ include "properties-name-api" . }}
    items:
      - key: application.properties
        path: application.properties
{{- end -}}

{{- define "oci-private-keys-secret-name" -}}
{{- printf "%s-%s" (include "tpaas-server.name" .) "oci-private-key-secret" -}}
{{- end -}}

{{- define "oci-private-key-volume-mount" }}
- name: keyfile
  mountPath: "/workspace/API/oci_api_key.pem"
  subPath: oci_api_key.pem
  readOnly: true
{{- end }}

{{- define "oci-private-key-file-volume" }}
- name: keyfile
  secret:
    secretName: {{ include "oci-private-keys-secret-name" . }}
    items:
    - key: OCI_PRIVATE_KEY
      path: oci_api_key.pem
{{- end }}

{{- define "db-wallet-secret-name" -}}
{{- required "Database secretName is required" .Values.infra.database.secretName -}}
{{- end -}}

{{- define "db-wallet-zip-file-name" -}}
{{- required "Database wallet file name is required" .Values.infra.database.walletFileName -}}
{{- end -}}

{{- define "volume-db-wallet" }}
- name: walletfile
  secret:
    secretName: {{ include "db-wallet-secret-name" . }}
    items:
    - key: {{ include "db-wallet-zip-file-name" . }}
      path: wallet.zip
{{- end }}

{{- define "volume-db-wallet-unzipped" }}
- name: unzipped-wallet
  emptyDir: {}
{{- end }}

{{- define "volume-mount-db-wallet-unzipped" }}
- name: unzipped-wallet
  mountPath: /workspace/API/wallet
{{- end }}

{{- define "volume-mount-db-wallet" }}
- name: walletfile
  mountPath: "/tmp"
  readOnly: true
- name: unzipped-wallet
  mountPath: "/workspace/API/wallet"
{{- end }}

{{- define "busybox-image-url" -}}
{{- $imageRepo := required "image.busyboxImage is required" .Values.image.busyboxImage -}}
{{- $imageTag := required "image.busyboxVersion is required" .Values.image.busyboxVersion -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{- define "reportServer-image-url" -}}
{{- $imageRepo := required "image.reportServerImage is required" .Values.image.reportServerImage -}}
{{- $imageTag := required "image.reportServerTag is required" .Values.image.reportServerTag -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{- define "webshell-image-url" -}}
{{- $imageRepo := required "image.webshellImage is required" .Values.image.webshellImage -}}
{{- $imageTag := required "image.webshellTagis required" .Values.image.webshellTag -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{- define "gitbook-image-url" -}}
{{- $imageRepo := required "image.gitbookImage is required" .Values.image.gitbookImage -}}
{{- $imageTag := required "image.gitbookTag is required" .Values.image.gitbookTag -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{- define "initContainers-wallet-file" }}
{{- $imageName := .image }}
- name: init-wallet
  image: {{ include "busybox-image-url" . }}
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  volumeMounts:
  {{- include "volume-mount-db-wallet" . | indent 6 }}
  command:
  - 'sh'
  - '-c'
  - 'mkdir -p /workspace/API/wallet/;unzip /tmp/wallet.zip -d /workspace/API/wallet/;'
{{- end }}

{{- define "volume-mount-properties-ui" -}}
- name: properties-file-ui
  mountPath: /workspace/UI/application.properties
  subPath: application.properties
  readOnly: true
{{- end -}}

{{- define "volume-properties-ui" -}}
- name: properties-file-ui
  configMap:
    name: {{ include "properties-name-ui" . }}
    items:
      - key: application.properties
        path: application.properties
{{- end -}}

{{- define "volume-mount-properties-interceptor" -}}
- name: properties-file-interceptor
  mountPath: /workspace/INTERCEPTOR/application.properties
  subPath: application.properties
  readOnly: true
{{- end -}}

{{- define "volume-properties-interceptor" -}}
- name: properties-file-interceptor
  configMap:
    name: {{ include "properties-name-interceptor" . }}
    items:
      - key: application.properties
        path: application.properties
{{- end -}}

{{- define "volume-mount-properties-rate-limit" -}}
- name: properties-file-rate-limit
  mountPath: /workspace/RATELIMIT/application.properties
  subPath: application.properties
  readOnly: true
{{- end -}}

{{- define "volume-properties-rate-limit" -}}
- name: properties-file-rate-limit
  configMap:
    name: {{ include "properties-name-rate-limit" . }}
    items:
      - key: application.properties
        path: application.properties
{{- end -}}

{{- define "volume-mount-properties-webshell" -}}
- name: properties-file-webshell
  mountPath: /workspace/webshell.json
  subPath: webshell.json
  readOnly: true
{{- end -}}

{{- define "volume-properties-webshell" -}}
- name: properties-file-webshell
  configMap:
    name: {{ include "properties-name-webshell" . }}
    items:
      - key: webshell.json
        path: webshell.json
{{- end -}}


{{- define "liveness-probe" }}
{{- $apiPort := .api }}
ports:
- containerPort: {{ $apiPort }}
  name: api
readinessProbe:
  initialDelaySeconds: 30
  timeoutSeconds: 2
  tcpSocket:
    port: {{ $apiPort }}
  periodSeconds: 10
{{- end }}

{{- define "ingress-path" -}}
{{- if .Values.ingress.path -}}
{{- .Values.ingress.path -}}
{{- else }}
{{- printf "/%s" .Release.Name -}}
{{- end }}
{{- end }}