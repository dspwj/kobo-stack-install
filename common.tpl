# copyleft 2015 teodorescu.serban@gmail.com

rabbit:
  image: teodorescuserban/kobo-rabbit:latest
  hostname: rabbit
  env_file:
    - ./env_common
  environment:
    - RABBITMQ_LOGS=-
    - RABBITMQ_SASL_LOGS=-
  ports:
    - "${KOBO_DB_SERVER_IP}:${RABBIT_PORT}:5672"
#    - "${KOBO_DB_SERVER_IP}:${RABBIT_MGMT_PORT}:15672"

psql:
  image: teodorescuserban/kobo-psql:latest
  hostname: psql
  env_file:
    - ./env_common
    - ./env_sql
  ports:
    - "${KOBO_DB_SERVER_IP}:${PSQL_PORT}:5432"
  volumes:
    - "${VOL_DB}/db:/srv/db"

mongo:
  image: teodorescuserban/kobo-mongo:latest
  hostname: mongo
  env_file:
    - ./env_common
  environment:
    - MONGO_DATA=/srv/db
  ports:
    - "${KOBO_DB_SERVER_IP}:${MONGO_PORT}:27017"
  volumes:
    - "${VOL_DB}/mongo:/srv/db"


kobocat:
  image: teodorescuserban/kobo-kobocat:latest # still WIP
  #build: ./kobocat
  hostname: kobocat
  env_file:
    - ./env_common
    - ./env_sql
    - ./env_kobos
    - ./env_kobocat
  ports:
    - "${KOBO_WB_SERVER_IP}:${KOBOCAT_SERVER_PORT}:8000"
  extra_hosts:
    - "db: ${KOBO_DB_SERVER_IP}"
    - "mongo: ${KOBO_DB_SERVER_IP}"
    - "rabbit: ${KOBO_DB_SERVER_IP}"
  volumes:
    - "${VOL_WB}/kobocat:/srv/static"

dkobo:
  #image: teodorescuserban/kobo-dkobo:latest # still WIP
  build: ../kobo-dockers/dkobo
  hostname: dkobo
  env_file:
    - ./env_common
    - ./env_sql
    - ./env_kobos
    - ./env_dkobo
  ports:
    - "${KOBO_WB_SERVER_IP}:${KOBOFORM_SERVER_PORT}:8000"
  extra_hosts:
    - "db: ${KOBO_DB_SERVER_IP}"
    - "${KOBO_PREFIX}kobo.${KOBO_DOMAIN}: ${KOBO_WB_SERVER_IP}"
    - "${KOBO_PREFIX}kc.${KOBO_DOMAIN}: ${KOBO_WB_SERVER_IP}"
  volumes:
    - "${VOL_WB}/koboform:/srv/static"

web:
  image: teodorescuserban/kobo-nginx:latest # still WIP
  hostname: nginx
  env_file:
    - ./env_common
    - ./env_kobos
  #  - ./env_secrets
  ports:
    - "${KOBO_WB_SERVER_IP}:${NGINX_HTTP_PORT}:80"
    - "${KOBO_WB_SERVER_IP}:${NGINX_HTTPS_PORT}:443"
  volumes:
    - "${VOL_WB}:/srv/www:ro"
  extra_hosts:
    - "${KOBO_PREFIX}kobo.${KOBO_DOMAIN}: ${KOBO_WB_SERVER_IP}"
    - "${KOBO_PREFIX}kc.${KOBO_DOMAIN}: ${KOBO_WB_SERVER_IP}"
  environment:
    - KOBO_NGINX_BASE_DIR=/etc/nginx
    - KOBO_NGINX_LOG_DIR=/var/log/nginx
    - KOBO_SSL_KEY=${KOBO_SSL_KEY}
    # for BM staging :)
    #- VIRTUAL_HOST=${KOBO_PREFIX}kc.${KOBO_DOMAIN},${KOBO_PREFIX}kobo.${KOBO_DOMAIN}
