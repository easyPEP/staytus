#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

cd /usr/src/app

if [ "$RUN_MIGRATION" == "true" ]; then
  bundle exec rake db:migrate
fi

if [ "$RUN_ASSET_PRECOMPILE" == "true" ]; then
  bundle exec rake assets:precompile
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
