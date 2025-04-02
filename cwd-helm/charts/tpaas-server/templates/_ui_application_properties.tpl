{{- define "application-properties-ui" }}
spring.profiles.active=default
server.port={{ required "UI port is required." .Values.components.ui.container.port }}
server.error.whitelabel.enabled={{ default false .Values.components.ui.server.error.whitelabel.enabled }}
api.location={{ printf "https://%s/api/v1"  .Values.ingress.ui.hostname  }}
api.for.webshell.location={{ printf "https://%s/v1"  .Values.ingress.ui.hostname  }}
ws.location={{ printf "https://%s/api/v1"  .Values.ingress.ui.hostname  }}
docs.location={{ printf "https://%s/tpaas-docs/"  .Values.ingress.ui.hostname  }}
{{- end -}}