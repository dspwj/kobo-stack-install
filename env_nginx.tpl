KOBO_PREFIX=${KOBO_PREFIX}
KOBO_DOMAIN=${KOBO_DOMAIN}
KOBOCAT_PUBLIC_ADDR=${KOBOCAT_PUBLIC_ADDR}
KOBOFORM_PUBLIC_ADDR=${KOBOFORM_PUBLIC_ADDR}

KOBO_NGINX_BASE_DIR=/etc/nginx
KOBO_NGINX_LOG_DIR=/var/log/nginx

# setup SSL
KOBO_SSL_KEY=${KOBO_SSL_KEY}
KOBO_SSL_CRT=${KOBO_SSL_CRT}

# for BM staging :)
VIRTUAL_HOST=${KOBOCAT_PUBLIC_ADDR},${KOBOFORM_PUBLIC_ADDR}

# configure upstreams
KOBOFORM_SERVER_ADDR=${KOBOFORM_SERVER_ADDR}
KOBOFORM_SERVER_PORT=${KOBOFORM_SERVER_PORT}
KPI_SERVER_ADDR=${KPI_SERVER_ADDR}
KPI_SERVER_PORT=${KPI_SERVER_PORT}
KOBOCAT_SERVER_ADDR=${KOBOCAT_SERVER_ADDR}
KOBOCAT_SERVER_PORT=${KOBOCAT_SERVER_PORT}
