#!/bin/bash

REGISTRY="localhost:5000"

# Get all repositories
repos=$(curl -s -X GET http://${REGISTRY}/v2/_catalog | jq -r '.repositories[]')

# Iterate through each repository and list its tags
for repo in $repos; do
    echo "Repository: $repo"
    tags=$(curl -s -X GET http://$REGISTRY/v2/${repo}/tags/list | jq -r '.tags[]')
    if [ -n "$tags" ]; then
        echo "  Tags:"
        for tag in $tags; do
            echo "  - ${tag}"
        done
    else
        echo "  No tags found."
    fi
    echo ""
done
