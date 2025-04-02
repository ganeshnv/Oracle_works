{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cwd-ldap-internal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "cwd-ldap-internal-properties-name" -}}
{{- printf "%s-%s" (include "cwd-ldap-internal.name" .) "properties" -}}
{{- end }}

{{- define "image-url" -}}
{{- $imageRepo := required "image.repository is required" .Values.image.repository -}}
{{- $imageTag := required "image.tag is required" .Values.image.tag -}}
{{- printf "%s:%s" $imageRepo $imageTag -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cwd-ldap-internal.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cwd-ldap-internal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cwd-ldap-internal.labels" -}}
helm.sh/chart: {{ include "cwd-ldap-internal.chart" . }}
{{ include "cwd-ldap-internal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cwd-ldap-internal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cwd-ldap-internal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- define "busybox-image-url" -}}
{{- $imageRepo := required "image.busyboxImage is required" .Values.image.busyboxImage -}}
{{- $imageTag := required "image.busyboxVersion is required" .Values.image.busyboxVersion -}}
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
  - 'mkdir -p /workspace/CWD/wallet/;unzip /tmp/wallet.zip -d /workspace/CWD/wallet/;'
{{- end }}

{{- define "db-wallet-secret-name" -}}
{{- printf "%s-%s" (include "cwd-ldap-internal.name" .)  .Values.cwd.ldap.db.secretName -}}
{{- end -}}

{{- define "db-wallet-zip-file-name" -}}
{{- required "Database wallet file name is required" .Values.cwd.ldap.db.walletFileName -}}
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
  mountPath: /workspace/CWD/wallet
{{- end }}

{{- define "volume-mount-db-wallet" }}
- name: walletfile
  mountPath: "/tmp"
  readOnly: true
- name: unzipped-wallet
  mountPath: "/workspace/CWD/wallet"
{{- end }}

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

{{- define "application-properties" }}
- configMapRef:
    name: {{ include "cwd-ldap-internal-properties-name" . }}
{{- end }}
