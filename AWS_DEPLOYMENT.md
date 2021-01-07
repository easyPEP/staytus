# Dockerize App

- [ ] dockerize app
- [ ] push repository to AWS repo

./push.sh ./staffomatic-status-page/static_page 462182695862.dkr.ecr.eu-central-1.amazonaws.com/staffomatic-status-page/app latest


https://stackoverflow.com/questions/52921426/docker-compose-version-3-cache-gems-to-speed-up-run-time-bundle-install


Cache Bundler:

1. Set your BUNDLE_PATH env var to vendor/bundle
2. Mount a volume in Fargate to the bundle path

The first run will be slow since it has to build up the bundle cache, but after that it should only update gems if necessary.

