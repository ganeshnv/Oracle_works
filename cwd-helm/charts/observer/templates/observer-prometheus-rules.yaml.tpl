{{- define "observer.prometheus-rules" -}}
{{ $prometheus_rules_directory := (.Values.observer.prometheusDirectory | default "observer") }}
{{ $prometheus_rules_file_pattern := (.Values.observer.prometheusRulesFilePattern | default "*.rules") }}
{{ $pattern := printf "%s/%s" $prometheus_rules_directory $prometheus_rules_file_pattern }}
{{ range $path, $bytes := .Files.Glob $pattern }}
{{ $file_ext := ext $path }}
{{- $ruleName := base $path }}
---
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: "{{ include "observer.fullname" $ }}-{{ $ruleName }}"
  labels:
    {{- include "observer.labels" $ | nindent 4 }}
spec:
{{- $.Files.Get $path | nindent 2 }}
{{- end }}
{{- end -}}
