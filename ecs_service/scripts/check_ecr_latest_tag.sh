#!/usr/bin/env bash
set -euo pipefail

eval "$(jq -r '@sh "REPOSITORY_NAME=\(.repository_name)"')"

IMAGE_DETAILS=$(aws ecr describe-images \
  --repository-name "${REPOSITORY_NAME}" \
  --output json 2>/dev/null) || IMAGE_DETAILS='{"imageDetails":[]}'

TAG=$(echo "${IMAGE_DETAILS}" | jq -r '
  [.imageDetails[] | select(.imageTags != null)]
  | sort_by(.imagePushedAt) | reverse
  | (.[0].imageTags // [])
  | map(select(. != "latest"))
  | .[0] // "latest"
')

jq -n --arg tag "${TAG}" '{tag: $tag}'
