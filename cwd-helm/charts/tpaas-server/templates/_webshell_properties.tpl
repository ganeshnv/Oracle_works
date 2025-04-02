{{- define "application-properties-webshell" }}
{
  "host": "{{ default "0.0.0.0" .Values.components.webshell.host }}",
  "port" : {{ default "8090" .Values.components.webshell.container.port }},
  "clientPort": {{ default "12347" .Values.components.webshell.clientPort }}
}
{{- end -}}