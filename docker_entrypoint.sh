#!/bin/bash
set -e

echo "docker_entrypoint.sh"

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

cd /app

# if [ "$RUN_MIGRATION" == "true" ]; then
#   echo "docker_entrypoint.sh: bundle exec rake db:migrate"
#   bundle exec rake db:migrate
# fi

echo "RUN_ASSET_PRECOMPILE: $RUN_ASSET_PRECOMPILE"
if [ "$RUN_ASSET_PRECOMPILE" == "true" ]; then
  echo "docker_entrypoint.sh: bundle exec rake assets:precompile"
  bundle exec rake assets:precompile
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
