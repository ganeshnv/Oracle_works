{{- define "application-properties-rate-limit" }}
spring.profiles.active=default

server.port={{ required "Rate limit port is required." .Values.components.rateLimit.container.port }}
spring.jpa.hibernate.naming_strategy={{ default "org.hibernate.cfg.ImprovedNamingStrategy" .Values.components.rateLimit.namingStrategy }}
api.server.url={{ printf "http://%s:%d"  (include "tpaas-server-api-name" .) (.Values.components.api.service.port | int)  }}
api.token={{ required "API token is required." .Values.components.rateLimit.apiToken }}

#Define scheduler pool size limitation with a String Array storing the following info(by order):
#1. pool name, String
#2. max number of debug jobs allowed, int
#3. max number of token to generate for non-debug job per period (default 20 seconds), double
#4. min number of token to generate for non-debug job per period (default 20 seconds), double
#5. max number of token to generate for debug job per period (default 20 seconds), double
#6. min number of token to generate for debug job per period (default 20 seconds), double
#Pools are semicolon-seperated, and information within each pool are comma-seperated.
#Example: mats,30,20,0.5,20,0.2;default,15,20,0.5,10,0.1;......
scheduler.pool.size.limitation={{ required "Rate limit worker pool size is required." .Values.components.rateLimit.workerPoolSize.limit }}
limitation.period.in.seconds={{ default "10" .Values.components.rateLimit.limitation.period.seconds }}
rate.limiter.burst.seconds={{ default "10" .Values.components.rateLimit.burst.seconds }}

# H2
spring.h2.console.enabled={{ default "true" .Values.components.rateLimit.dataSource.h2.console.enabled }}
spring.h2.console.path={{ default "/h2" .Values.components.rateLimit.dataSource.h2.console.path }}
spring.h2.console.settings.web-allow-others={{ default "true" .Values.components.rateLimit.dataSource.h2.console.settings.webAllowOthers }}
# Datasource
spring.datasource.url={{ required "Rate limit datasource url is required." .Values.components.rateLimit.dataSource.url }}
spring.datasource.username={{ required "Rate limit datasource user is required." .Values.components.rateLimit.dataSource.username }}
spring.datasource.password={{ .Values.components.rateLimit.dataSource.password }}
spring.datasource.driver-class-name={{ required "Rate limit datasource url is required." .Values.components.rateLimit.dataSource.driver }}
spring.jpa.hibernate.ddl-auto={{ default "update" .Values.components.rateLimit.dataSource.ddlAuto }}

spring.data.elasticsearch.cluster-nodes={{ required "ElasticSearch cluster is required." .Values.infra.es.clusterNodes }}
{{- end -}}