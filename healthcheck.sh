#!/bin/bash
set -e

PGPASSWORD=${POSTGRES_PASSWORD} \
  echo "SELECT 1+1;" \
  | psql -U "${POSTGRES_USER}" -w \
  > /dev/null

exit $?
