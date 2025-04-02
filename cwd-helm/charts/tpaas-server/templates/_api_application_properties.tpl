{{- define "application-properties-api" }}
spring.profiles.active=default
server.port = {{ required "API port is required." .Values.components.api.container.port }}
spring.main.allow-circular-references=true

# Redis config
spring.redis.sentinel.master={{ .Values.infra.redis.sentinel.master }}
spring.redis.sentinel.nodes={{ default 3 .Values.infra.redis.sentinel.nodes }}

spring.redis.jedis.pool.maxActive = {{ default -1 .Values.infra.redis.maxActive }}
spring.redis.jedis.pool.maxIdle = {{ default 0 .Values.infra.redis.maxIdle }}
spring.redis.jedis.pool.maxWait = {{ default 10000 .Values.infra.redis.maxWait }}
spring.redis.jedis.pool.minIdle = {{ default 0 .Values.infra.redis.minIdle }}
spring.redis.jedis.pool.timeBetweenEvictionRuns = {{ default 10000 .Values.infra.redis.timeBetweenEvictionRuns }}
spring.redis.timeout = {{ default 10000 .Values.infra.redis.timeout }}
spring.redis.clientName = {{ default "apiserver"  .Values.infra.redis.clientName }}

# DB config
spring.datasource.url = {{ printf "jdbc:mysql://%s?useSSL=false"  .Values.infra.database.dbName }}
spring.datasource.username = {{ required "Datasource username is required." .Values.infra.database.username }}
#spring.datasource.password = {{ required "Datasource password is required." .Values.infra.database.password }}
#spring.datasource.driver-class-name = {{ default "oracle.jdbc.OracleDriver" .Values.infra.database.driverClassName }}
spring.datasource.testWhileIdle = {{ default true .Values.infra.database.testWhileIdle }}
spring.datasource.max-active = {{ default 50 .Values.infra.database.maxActive }}
spring.datasource.hikari.maximumPoolSize= {{ default 50 .Values.infra.database.hikari.maximumPoolSize}}
spring.jpa.hibernate.ddl-auto = {{ default "update" .Values.infra.database.ddlAuto }}
spring.jpa.hibernate.naming_strategy = {{ default "org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy" .Values.infra.database.namingStrategy }}
spring.jpa.properties.hibernate.dialect = {{ required "Datasource username is required." .Values.infra.database.dialect }}
#spring.jpa.properties.hibernate.jdbc.time_zone = {{ default "UTC" .Values.infra.database.timeZone }}

# ElasticSearch config
spring.data.elasticsearch.cluster-nodes = {{ required "ElasticSearch cluster is required." .Values.infra.es.clusterNodes }}
spring.data.elasticsearch.cluster-name = {{ default "docker-cluster" .Values.infra.es.clusterName}}
elasticsearch.testjob.replica = {{ required "ElasticSearch replica is required." .Values.infra.es.replica }}

# Report Server config
report.server.url = {{ required "Report Server Url is required." .Values.infra.reportServer.url }}

# OCI config for object storage service
tpaas.oci.namespace = {{ required "OCI namespace is required." .Values.oci.credentials.namespace }}
tpaas.oci.iad.tenantOcid = {{ required "OCI tenantOcid is required." .Values.oci.credentials.tenantOcid }}
tpaas.oci.iad.compartmentOcid = {{ required "OCI compartmentOcid is required." .Values.oci.credentials.compartmentOcid }}
tpaas.oci.iad.userOcid = {{ required "OCI userOcid is required." .Values.oci.credentials.userOcid }}
tpaas.oci.iad.region = {{ required "OCI region is required." .Values.oci.credentials.region }}
tpaas.oci.iad.fingerprint = {{ required "OCI fingerprint is required." .Values.oci.credentials.fingerprint }}
tpaas.oci.iad.privateKeyFile = {{ default "/workspace/API/oci_api_key.pem" .Values.oci.credentials.privateKeyFile}}
tpaas.bucket = {{ required "Report bucket name is required." .Values.components.api.reportBucket }}

test.notification.mail.host={{ default "smtp.us-ashburn-1.oraclecloud.com" .Values.components.api.mail.host}}
test.notification.mail.port={{ default "587" .Values.components.api.mail.port}}
test.notification.mail.username={{ default "ocid1.user.oc1..aaaaaaaa7z2hxy3omkwq2wpxnpanu6vz2jxoe6lutxrvc2rbvz5fipav2r2a@ocid1.tenancy.oc1..aaaaaaaalnpy5chkaviwo4ihaseob4riwvamwvvefhm4bxkmu5g5uu43bepq.yy.com" .Values.components.api.mail.username}}
#test.notification.mail.password={{ required "Mail password is required." .Values.components.api.mail.password}}
test.notification.mail.authenticate=true
test.notification.mail.from={{ default "tpaas-noreply@oci.oracle.com" .Values.components.api.mail.from}}

path.testInstance.infoXml = {{ default "/scratch/shared/inst/" .Values.components.api.infoXml }}
test.scheduled.task = {{ default true .Values.components.api.scheduleTask }}
test.queue.scan = {{ default true .Values.components.api.scanQueue }}
test.data.persistence = {{ default true .Values.components.api.persistData }}
test.parser.url = {{ default "http://slc04doc.us.oracle.com:28080/v1.0/parse" .Values.components.api.parserUrl }}

# Logging-redis config
test.logging.redis.host = {{ required "logging-redis host is required." .Values.infra.loggingRedis.host }}
test.logging.redis.port = {{ required "logging-redis port is required." .Values.infra.loggingRedis.port }}

tpaas.backend.api.endpoint = {{ required "API endpoint is required." .Values.components.api.apiEndpoint }}
api.service.urlbase = {{ required "API url base is required." .Values.components.api.apiUrlBase }}
rate.limit.server.url = {{ printf "http://%s:%d"  (include "tpaas-server-rate-limit-name" .) (.Values.components.rateLimit.service.port | int)  }}
interceptor.url = {{ printf "http://%s:%d"  (include "tpaas-server-interceptor-name" .) (.Values.components.interceptor.service.port | int)  }}

# Config Service
spring.cloud.config.server.prefix = {{ default "config" .Values.components.api.configServer.prefix }}
spring.cloud.config.server.git.uri = {{ default "git@slcai087vmf07.us.oracle.com:seleniumaas/tpaas-config.git" .Values.components.api.configServer.gitUri }}
spring.cloud.config.overrideNone = {{ default true .Values.components.api.configServer.overrideNone }}

# actuator
management.security.enabled = {{ default false .Values.components.api.actuator.securityEnabled }}
endpoints.actuator.enabled = {{ default false .Values.components.api.actuator.actuatorEnabled }}
endpoints.shutdown.enabled = {{ default true .Values.components.api.actuator.shutdownEnabled }}
tpaas.ui.endpoint={{printf "https://%s/index.html"  .Values.ingress.ui.hostname  }}
api.location={{ printf "https://%s/api/v1"  .Values.ingress.ui.hostname  }}

api.bootstrap.user = {{ default "yingfei.zhang@oracle.com;yefeng.chen@oracle.com;emma.xiu@oracle.com;cloud-tpaas_ww@oracle.com" .Values.components.api.bootstrapUser }}

logging.level.org.springframework.web = {{ default "ERROR" .Values.components.api.logging.webLoggingLevel }}
logging.level.org.hibernate = {{ default "ERROR" .Values.components.api.logging.hibernateLoggingLevel }}

spring.jackson.property-naming-strategy = {{ default "com.fasterxml.jackson.databind.PropertyNamingStrategy.SnakeCaseStrategy" .Values.spring.jackson.propertyNamingStrategy }}
spring.jackson.mapper.default-view-inclusion = {{ default true .Values.components.api.defaultViewIncludsion }}

springfox.documentation.swagger.v2.path = {{ default "/v1/api-docs" .Values.components.api.swaggerV2Path }}
swagger.base.path = {{ default "/ui-api/" .Values.components.api.swaggerBathPath }}

spring.data.rest.base-uri = {{ default "/" .Values.components.api.springDataBaseUri }}

api.internal.ldap = {{ default true .Values.components.api.useldap }}
{{- end -}}
