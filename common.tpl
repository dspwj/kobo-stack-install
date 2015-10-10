rabbit:
  image: teodorescuserban/kobo-rabbit:latest
  # build: ./rabbit
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
  # build: ./psql
  hostname: psql
  env_file:
    - ./env_common
    - ./env_sql
  ports:
    - "${KOBO_DB_SERVER_IP}:${PSQL_PORT}:5432"
#  volumes:
#    - ./vols/db:/srv/db"

mongo:
  image: teodorescuserban/kobo-mongo:latest
  # build: ./mongo
  hostname: mongo
  env_file:
    - ./env_common
  environment:
    - MONGO_DATA=/srv/db
  ports:
    - "${KOBO_DB_SERVER_IP}:${MONGO_PORT}:27017"
#  volumes:
#    - ./vols/mongo:/srv/db"

dkobo:
#  # image: teodorescuserban/kobo-dkobo:latest # still WIP
  build: ./dkobo
  hostname: dkobo
  env_file:
    - ./env_common
    - ./env_sql
    - ./env_kobos
    - ./env_dkobo
  ports:
    - "${KOBO_WB_SERVER_IP}:${KOBOFORM_SERVER_PORT}:8000"
#    - "${KOBO_WB_SERVER_IP}:${KOBOFORM_SERVER_PORT}:80"
  extra_hosts:
    - "db: ${KOBO_DB_SERVER_IP}"

kobocat:
  # image: teodorescuserban/kobo-dkobo:latest # still WIP
  build: ./kobocat
  hostname: kobocat
  env_file:
    - ./env_common
    - ./env_sql
    - ./env_kobos
    - ./env_kobocat
  ports:
    - "${KOBO_WB_SERVER_IP}:${KOBOCAT_SERVER_PORT}:8000"
#    - "${KOBO_WB_SERVER_IP}:${KOBOCAT_SERVER_PORT}:80"
  extra_hosts:
    - "db: ${KOBO_DB_SERVER_IP}"
    - "mongo: ${KOBO_DB_SERVER_IP}"
    - "rabbit: ${KOBO_DB_SERVER_IP}"
