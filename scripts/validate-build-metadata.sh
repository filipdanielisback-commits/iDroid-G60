#!/usr/bin/env bash
# Validate the pinned source metadata and the fetch script without downloading
# or building XNU.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCK="$ROOT/build/XNU_BASELINE.lock"
FETCH="$ROOT/scripts/fetch-xnu-baseline.sh"

for file in "$LOCK" "$FETCH"; do
  [[ -f "$file" ]] || { echo "error: missing $file" >&2; exit 1; }
done

# shellcheck source=../build/XNU_BASELINE.lock
source "$LOCK"

[[ "$XNU_REPOSITORY" == "https://github.com/apple-oss-distributions/xnu.git" ]] || {
  echo "error: XNU_REPOSITORY must point to the official Apple OSS repository" >&2
  exit 1
}
[[ "$XNU_TAG" =~ ^xnu-[0-9]+\.[0-9]+\.[0-9]+$ ]] || {
  echo "error: XNU_TAG has an unexpected format: $XNU_TAG" >&2
  exit 1
}
[[ "$XNU_COMMIT" =~ ^[0-9a-f]{40}$ ]] || {
  echo "error: XNU_COMMIT must be a full 40-character lowercase Git SHA" >&2
  exit 1
}
[[ "$HAKIOS_REFERENCE_COMMIT" =~ ^[0-9a-f]{40}$ ]] || {
  echo "error: HAKIOS_REFERENCE_COMMIT must be a full 40-character lowercase Git SHA" >&2
  exit 1
}
bash -n "$FETCH"

printf 'Build metadata validation passed.\n'
printf '  XNU tag:    %s\n' "$XNU_TAG"
printf '  XNU commit: %s\n' "$XNU_COMMIT"
printf 'No source download or kernel build was performed.\n'
