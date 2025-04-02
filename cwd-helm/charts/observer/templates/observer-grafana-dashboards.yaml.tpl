{{- define "observer.grafana-dashboards" -}}
{{ $dashboard_directory := (.Values.observer.grafanaDirectory | default "observer") }}
{{ $dashboard_file_pattern := (.Values.observer.grafanaDashboardFilePattern | default "*.json") }}
{{ $pattern := printf "%s/%s" $dashboard_directory $dashboard_file_pattern }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: "{{ include "observer.fullname" . }}-grafana-dashboards"
  labels:
    {{- include "observer.labels" . | nindent 4 }}
    {{- if .Values.observer.grafanaDashboardLabels }}
      {{- .Values.observer.grafanaDashboardLabels | toYaml | nindent 4 }}
    {{- else }}
    grafana_dashboard: "1"
    {{- end }}
  annotations:
    fileGlobPattern: {{ $pattern | quote }}
data:
{{/* If try to use .Values in the .Files.Glob, it doesn't work.  Perhaps there is some two pass templating thing going on */}}
{{- if (.Files.Glob $pattern) }}
{{- (.Files.Glob $pattern).AsConfig | nindent 2 }}
{{- end -}}
{{- range $dashboardName, $dashboardUrl := .Values.observer.grafanaDashboardUrls }}
  {{ $dashboardName }}.json.url: {{ $dashboardUrl }}
{{- end -}}
{{- end -}}
