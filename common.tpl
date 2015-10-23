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
    - "${RABBIT_HOST}:${RABBIT_PORT}:5672"
#    - "${RABBIT_HOST}:${RABBIT_MGMT_PORT}:15672"

psql:
  image: teodorescuserban/kobo-psql:latest
  hostname: psql
  env_file:
    - ./env_common
    - ./env_sql
  ports:
    - "${PSQL_HOST}:${PSQL_PORT}:5432"
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
    - "${MONGO_HOST}:${MONGO_PORT}:27017"
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
    - "${KOBOCAT_SERVER_ADDR}:${KOBOCAT_SERVER_PORT}:8000"
  extra_hosts:
    - "db: ${PSQL_HOST}"
    - "mongo: ${MONGO_HOST}"
    - "rabbit: ${RABBIT_HOST}"
  volumes:
    - "${VOL_WB}/kobocat:/srv/static"

dkobo:
  image: teodorescuserban/kobo-dkobo:latest # still WIP
  #build: ../kobo-dockers/dkobo
  hostname: dkobo
  env_file:
    - ./env_common
    - ./env_sql
    - ./env_kobos
    - ./env_dkobo
  ports:
    - "${KOBOCAT_SERVER_ADDR}:${KOBOFORM_SERVER_PORT}:8000"
  extra_hosts:
    - "db: ${PSQL_HOST}"
    - "${KOBOFORM_PUBLIC_ADDR}: ${KOBO_WB_SERVER_IP}"
    - "${KOBOCAT_PUBLIC_ADDR}: ${KOBO_WB_SERVER_IP}"
  volumes:
    - "${VOL_WB}/koboform:/srv/static"

web:
  image: teodorescuserban/kobo-nginx:latest # still WIP
  hostname: nginx
  env_file:
    - ./env_common
    - ./env_nginx
  #  - ./env_secrets
  ports:
    - "${KOBO_WB_SERVER_IP}:${NGINX_HTTP_PORT}:80"
    - "${KOBO_WB_SERVER_IP}:${NGINX_HTTPS_PORT}:443"
  volumes:
    - "${VOL_WB}:/srv/www:ro"
  extra_hosts:
    - "${KOBOFORM_PUBLIC_ADDR}: ${KOBO_WB_SERVER_IP}"
    - "${KOBOCAT_PUBLIC_ADDR}: ${KOBO_WB_SERVER_IP}"
