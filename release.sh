#!/bin/bash

source name.sh

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "$0 BUMP"
    echo "Available BUMPs: major, minor, patch"
    exit 1
fi

BUMP="$1"

[ "$BUMP" != "major" -a \
  "$BUMP" != "minor" -a \
  "$BUMP" != "patch" -a ] && echo "Invalid BUMP" && exit 1

function errorCheck {
    ERROR_CODE="$?"
    if [ "$ERROR_CODE" -ne 0  ]; then
      echo "[ERROR] $1 : ($ERROR_CODE)"
        exit 1
    fi
}

# ensure we're up to date
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
git fetch && git pull origin $CURRENT_BRANCH
errorCheck "Failed to pull $CURRENT_BRANCH"

# bump version
docker run --rm -v "$PWD":/app treeder/bump $BUMP
errorCheck "Failed to run \"treeder/bump\" container"

BUMPED_VERSION="$(cat VERSION)"
echo "Bumped version: $BUMPED_VERSION"

# tag
BRANCH="rel_$BUMPED_VERSION"
git checkout -b $BRANCH
errorCheck "Failed to create branch: \"$BRANCH\""
git commit -am "release $BUMPED_VERSION"
errorCheck "Failed to create commit"
git tag -a "$BUMPED_VERSION" -m "version $BUMPED_VERSION"
errorCheck "Failed to create tag: \"$BUMPED_VERSION\""
git push origin $BRANCH
errorCheck "Failed to push branch: \"$BRANCH\""
git push --tags
errorCheck "Failed to push tags"
