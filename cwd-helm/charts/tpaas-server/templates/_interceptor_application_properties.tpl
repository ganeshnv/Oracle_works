{{- define "application-properties-interceptor" }}
spring.profiles.active=default
server.port={{ required "Interceptor port is required." .Values.components.interceptor.container.port }}

spring.jackson.property-naming-strategy={{ default "com.fasterxml.jackson.databind.PropertyNamingStrategy.SnakeCaseStrategy" .Values.spring.jackson.propertyNamingStrategy }}
console.type.process.percentage={{ default "1.0" .Values.components.interceptor.console.type.process.percentage }}

spring.data.elasticsearch.cluster-nodes={{ required "ElasticSearch cluster is required." .Values.infra.es.clusterNodes }}
{{- end -}}