#!/usr/bin/env bash
# List the refs that generated documentation should target
# Newest tag is excluded (as a duplicate of the "main" branch)

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# The root of the OSCAL-Reference repository
ROOT_DIR="${SCRIPT_DIR}/.."
OSCAL_DIR="${ROOT_DIR}/support/OSCAL"

TAGS=$(cd "${OSCAL_DIR}"; git tag)

# filter out non-version tags (anything that isn't in a vX.X.X, milestones, release candidates, etc.)
TAGGED_REVISIONS=$(echo "${TAGS}" | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$')
# sort tags (which should be in semver-ish format)
TAGGED_REVISIONS=$(echo "${TAGGED_REVISIONS}" | sort -t "." -k1,1n -k2,2n -k3,3n)
# exclude the last (newest) revision, which is duplicated by the "main" branch revision

# always include "main" and "develop" revisions
echo "main"
echo "develop"
echo "${TAGGED_REVISIONS}"
