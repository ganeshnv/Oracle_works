{{- define "elasticsearch.loadbalancerName" -}}
{{- if empty .Values.elasticsearch.fullnameOverride -}}
{{- if empty .Values.elasticsearch.nameOverride -}}
{{ .Values.elasticsearch.clusterName }}-{{ .Values.elasticsearch.nodeGroup }}
{{- else -}}
{{ .Values.elasticsearch.nameOverride }}-{{ .Values.elasticsearch.nodeGroup }}
{{- end -}}
{{- else -}}
{{ .Values.elasticsearch.fullnameOverride }}
{{- end -}}
{{- end -}}

{{- define "elasticsearch.loadbalancerService" -}}
{{- if empty .Values.elasticsearch.masterService -}}
{{- if empty .Values.elasticsearch.fullnameOverride -}}
{{- if empty .Values.elasticsearch.nameOverride -}}
{{ .Values.elasticsearch.clusterName }}-master-loadbalancer
{{- else -}}
{{ .Values.elasticsearch.nameOverride }}-master-loadbalancer
{{- end -}}
{{- else -}}
{{ .Values.elasticsearch.fullnameOverride }}
{{- end -}}
{{- else -}}
{{ .Values.elasticsearch.masterService }}
{{- end -}}
{{- end -}}