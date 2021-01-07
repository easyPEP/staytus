#!/bin/bash
#
# Builds a Docker image and pushes to an AWS ECR repository

# name of the file - push.sh

set -e

source_path="$1" # 1st argument from command line
repository_url="$2" # 2nd argument from command line
tag="${3:-latest}" # Checks if 3rd argument exists, if not, use "latest"
docker_file_name="$4" # docker file name

# splits string using '.' and picks 4th item
region="$(echo "$repository_url" | cut -d. -f4)"

# splits string using '/' and picks 2nd item
image_name="$(echo "$repository_url" | cut -d/ -f2)"

echo "repository_url: $repository_url"
echo "repository_url: $source_path"
echo "image_name: $image_name"
echo "image_name: $docker_file_name"

# builds docker image
(cd "$source_path" && docker build -f "$docker_file_name" -t "$image_name" .)

## get password login to ecr
# see: https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecr/get-login-password.html
aws ecr get-login-password \
    --region "$region" \
| docker login \
    --username AWS \
    --password-stdin "$repository_url"

# tag image
docker tag "$image_name" "$repository_url":"$tag"

# push image
docker push "$repository_url":"$tag"