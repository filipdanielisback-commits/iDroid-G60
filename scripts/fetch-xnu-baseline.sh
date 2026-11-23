#!/usr/bin/env bash
# Fetch the exact Apple XNU source revision recorded in build/XNU_BASELINE.lock.
# This script does not patch, configure, compile, or boot the kernel.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../build/XNU_BASELINE.lock
source "$ROOT/build/XNU_BASELINE.lock"

WORKSPACE="${XNU_WORKSPACE:-${HOME:?Set HOME or XNU_WORKSPACE}/.cache/idroid-g60}"
SOURCE_DIR="${XNU_SOURCE_DIR:-$WORKSPACE/xnu-$XNU_TAG}"

command -v git >/dev/null 2>&1 || {
  echo "error: git is required" >&2
  exit 1
}

mkdir -p "$WORKSPACE"
if [[ -e "$SOURCE_DIR" && ! -d "$SOURCE_DIR/.git" ]]; then
  echo "error: $SOURCE_DIR exists but is not a Git checkout; move it aside or set XNU_SOURCE_DIR" >&2
  exit 1
fi

if [[ ! -d "$SOURCE_DIR/.git" ]]; then
  git init -q "$SOURCE_DIR"
  git -C "$SOURCE_DIR" remote add origin "$XNU_REPOSITORY"
else
  actual_remote="$(git -C "$SOURCE_DIR" remote get-url origin)"
  if [[ "$actual_remote" != "$XNU_REPOSITORY" ]]; then
    echo "error: unexpected origin in $SOURCE_DIR: $actual_remote" >&2
    exit 1
  fi
fi

echo "Fetching $XNU_TAG from the official Apple XNU repository..."
git -C "$SOURCE_DIR" fetch --no-tags --depth=1 origin "refs/tags/$XNU_TAG"
actual_commit="$(git -C "$SOURCE_DIR" rev-parse FETCH_HEAD^{commit})"
if [[ "$actual_commit" != "$XNU_COMMIT" ]]; then
  echo "error: tag resolved to $actual_commit, expected $XNU_COMMIT" >&2
  exit 1
fi

if [[ -n "$(git -C "$SOURCE_DIR" status --porcelain)" ]]; then
  echo "error: $SOURCE_DIR has local changes; preserve or clean them before switching revisions" >&2
  exit 1
fi

git -C "$SOURCE_DIR" checkout --detach "$XNU_COMMIT"
checked_out="$(git -C "$SOURCE_DIR" rev-parse HEAD)"
[[ "$checked_out" == "$XNU_COMMIT" ]] || {
  echo "error: checkout verification failed ($checked_out)" >&2
  exit 1
}

printf '\nVerified Apple XNU source checkout\n'
printf '  tag:    %s\n' "$XNU_TAG"
printf '  commit: %s\n' "$checked_out"
printf '  path:   %s\n' "$SOURCE_DIR"
printf '\nSource is fetched and pinned. No kernel build has been run.\n'
