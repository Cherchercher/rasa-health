#!/usr/bin/env bash
set -x
set -e

readonly BRANCH="master"
readonly VERSION_FILE="VERSION"

get_updated_version() {
  major=$(cut -d '.' -f 1 ${VERSION_FILE})
  minor=$(cut -d '.' -f 2 ${VERSION_FILE} | xargs -I '{}' expr '{}' + 1)
  echo "${major}.${minor}.0"
}

# build() {}

update_package_versions() {
  dirs=$(find . -type d -maxdepth 1 -not -path '*/\.*' -not -path .)
  git add $dirs
}

commit_and_tag() {
  echo "$1" > ${VERSION_FILE}
  git add ${VERSION_FILE}
  git commit -m "$1"
  git tag "$1"
  if [ "$?" -ne 0 ]; then
    echo "Failed to commit or tag new version: $1"
    exit 1
  fi
}

push_update() {
  git push --tags origin $BRANCH
  if [ "$?" -ne 0 ]; then
    echo "Failed to push new version commit to ${BRANCH}"
    exit 1
  fi
}

main() {
  git checkout $BRANCH
  version=$(get_updated_version)
  # build
  update_package_versions $version
  commit_and_tag $version
  push_update
  exit 0
}

main
