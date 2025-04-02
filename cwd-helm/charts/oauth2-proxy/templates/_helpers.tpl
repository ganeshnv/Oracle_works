{{/*
Expand the name of the chart.
*/}}


{{- define "oauth2-proxy-tpaas-ui-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "tpaas-ui" -}}
{{- end -}}

{{- define "oauth2-proxy-tpaas-api-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "tpaas-api" -}}
{{- end -}}

{{- define "oauth2-proxy-tpaas-report-server-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "report-server" -}}
{{- end -}}

{{- define "oauth2-proxy-tpaas-webshell-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "webshell" -}}
{{- end -}}

{{- define "oauth2-proxy-cwd-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "cwd" -}}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "cwd-internal" -}}
{{- end -}}

{{- define "oauth2-proxy-cwd-nginx-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "cwd-nginx" -}}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal-nginx-name" -}}
{{- printf "%s-%s" (include "oauth2-proxy.name" .) "cwd-internal-nginx" -}}
{{- end -}}

{{- define "oauth2-proxy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "oauth2-proxy-cwd-upstream" -}}
{{- printf "%s%s:%d" "http://" (include "oauth2-proxy-cwd-nginx-name" .) (.Values.cwd.nginx.service.port | int)  -}}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal-upstream" -}}
{{- printf "%s%s:%d" "http://" (include "oauth2-proxy-cwd-internal-nginx-name" .) (.Values.cwd.nginx.service.port | int)  -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "oauth2-proxy.fullname" -}}
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
{{- define "oauth2-proxy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "oauth2-proxy-tpaas-ui.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-ui-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-api.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-api-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-internal-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-nginx.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-nginx-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal-nginx.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-internal-nginx-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-report-server.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-report-server-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-webshell.labels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-webshell-name" . }}
{{ include "oauth2-proxy.labels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-ui.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-ui-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-api.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-api-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-report-server.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-report-server-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-tpaas-webshell.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-tpaas-webshell-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-internal-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-nginx.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-nginx-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{- define "oauth2-proxy-cwd-internal-nginx.selectorLabels" -}}
app.kubernetes.io/component: {{ include "oauth2-proxy-cwd-internal-nginx-name" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "oauth2-proxy.labels" -}}
helm.sh/chart: {{ include "oauth2-proxy.chart" . }}
{{ include "oauth2-proxy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "oauth2-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "oauth2-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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

{{- define "volume-mount-cwd-nginx" -}}
- name: nginx-conf-volume
  mountPath: /etc/nginx/nginx.conf
  subPath: nginx.conf
  readOnly: true
{{- end -}}

{{- define "volume-cwd-nginx" -}}
- name: nginx-conf-volume
  configMap:
    name: {{include "oauth2-proxy-cwd-nginx-name" .}}
    items:
      - key: nginx.conf
        path: nginx.conf
{{- end -}}

{{- define "volume-cwd-internal-nginx" -}}
- name: nginx-conf-volume
  configMap:
    name: {{include "oauth2-proxy-cwd-internal-nginx-name" .}}
    items:
      - key: nginx.conf
        path: nginx.conf
{{- end -}}
