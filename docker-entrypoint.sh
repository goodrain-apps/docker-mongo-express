#!/bin/bash

[ $DEBUG ] && set -x


set -e

export ME_CONFIG_EDITORTHEME="default"
export ME_CONFIG_MONGODB_SERVER=${MONGO_HOST:-127.0.0.1}
export ME_CONFIG_MONGODB_PORT=${MONGO_PORT:-27017}
export ME_CONFIG_MONGODB_ENABLE_ADMIN="true"
export ME_CONFIG_BASICAUTH_USERNAME=${ME_USER:-""}
export ME_CONFIG_BASICAUTH_PASSWORD=${ME_PASS:-""}
export VCAP_APP_HOST="0.0.0.0"

for i in {30..0}; do
  if nc -w 1  -v $ME_CONFIG_MONGODB_SERVER $ME_CONFIG_MONGODB_PORT; then
  break
  fi
  echo 'Waiting Mongodb start...'
  sleep 1
done

exec "$@"
