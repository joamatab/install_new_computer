#!/bin/bash


email=$(PGPASSWORD=${CLOUDRON_POSTGRESQL_PASSWORD} psql -h ${CLOUDRON_POSTGRESQL_HOST} -p ${CLOUDRON_POSTGRESQL_PORT} -U ${CLOUDRON_POSTGRESQL_USERNAME} -d ${CLOUDRON_POSTGRESQL_DATABASE} -c 'select email from "Users";' -t)

for e in $email; do
  [[ -z "$e" ]] && continue
  # echo $e
  u="${e%%@*}"
  echo $u
  PGPASSWORD=${CLOUDRON_POSTGRESQL_PASSWORD} psql -h ${CLOUDRON_POSTGRESQL_HOST} -p ${CLOUDRON_POSTGRESQL_PORT} -U ${CLOUDRON_POSTGRESQL_USERNAME} -d ${CLOUDRON_POSTGRESQL_DATABASE} -c "update \"Users\" set profileid = 'LDAP-$u' where  email = '$e';" -t
done

