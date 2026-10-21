#!/bin/bash

CONTAINER="registry" # local registry conatainer name
REGISTRY="localhost:5000"

# List of images to be deleted
images=(
  "alpine"
)

delete_image()
{
  local image=$1
  local tag=$2
  echo "Deleting image: $image:$tag"
  
  digest=$(curl -I -s -H "Accept: application/vnd.docker.distribution.manifest.v2+json" "http://${REGISTRY}/v2/${image}/manifests/${tag}" | grep Docker-Content-Digest | awk '{print $2}' | tr -d '\r')
  echo "digest: ${digest}"
  if [[ -z "${digest}" ]]; then
    echo "Error: Digest not found for image ${image}:${tag}"
    return 1
  fi
  curl -X DELETE "http://${REGISTRY}/v2/${image}/manifests/${digest}"
}

# Function to get all tags for an image
get_tags()
{
  local image=$1
  curl -s "http://${REGISTRY}/v2/${image}/tags/list" | jq -r '.tags[]'
}

# Prompt user for confirmation
read -p "Are you sure you want to delete the specified images? Type 'yes' to confirm: " conf
if [[ "$conf" == "yes" ]]; then
  for image in "${images[@]}"; do
    echo "image: ${image}"
    tags=$(get_tags "${image}")
    echo "tags: ${tags}"

    for tag in ${tags}; do
      delete_image "${image}" "${tag}"
    done
  done
  echo "Images deleted successfully."


  # Remove repository folders
  for image in "${images[@]}"; do

    # Delete the image
    echo "deleting image: ${image}"
    docker exec -it "${CONTAINER}" rm -r "/var/lib/registry/docker/registry/v2/repositories/${image}"

    # Run garbage collection
    docker exec -it "${CONTAINER}" registry garbage-collect /etc/distribution/config.yml
    echo "Deleted directory for image: ${image}"

  done
  # Show final view of the catalog
  curl -X GET http://${REGISTRY}/v2/_catalog | jq
else
  echo "Operation cancelled."
fi
