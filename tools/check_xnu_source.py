#!/usr/bin/env python3
"""Verify a separate, pristine checkout of the selected upstream XNU tag.

This tool does not download, modify, patch, or build XNU. It only checks the
provenance and shape of a source tree supplied by the developer.
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path


def git(source: Path, *args: str) -> str:
    result = subprocess.run(
        ["git", "-C", str(source), *args],
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        raise RuntimeError(detail or f"git {' '.join(args)} failed")
    return result.stdout.strip()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path,
                        help="path to a separate upstream XNU Git checkout")
    parser.add_argument("--tag", default="xnu-8796.121.2",
                        help="exact upstream tag expected at HEAD")
    args = parser.parse_args()

    source = args.source.expanduser().resolve()
    if not source.is_dir():
        print(f"XNU source directory does not exist: {source}", file=sys.stderr)
        return 2

    try:
        root = Path(git(source, "rev-parse", "--show-toplevel")).resolve()
        if root != source:
            print("The supplied path must be the root of the XNU checkout.",
                  file=sys.stderr)
            return 2

        origin = git(source, "remote", "get-url", "origin").lower()
        if "apple-oss-distributions/xnu" not in origin:
            print(f"Unexpected XNU origin: {origin}", file=sys.stderr)
            return 2

        actual_tag = git(source, "describe", "--tags", "--exact-match", "HEAD")
        if actual_tag != args.tag:
            print(f"Expected exact tag {args.tag}; found {actual_tag}.",
                  file=sys.stderr)
            return 2

        required = ("LICENSE", "osfmk", "bsd", "EXTERNAL_HEADERS")
        missing = [name for name in required if not (source / name).exists()]
        if missing:
            print("Checkout is missing expected upstream paths: "
                  + ", ".join(missing), file=sys.stderr)
            return 2

        status = git(source, "status", "--porcelain")
        if status:
            print("XNU checkout is not pristine. Keep local project changes "
                  "in iDroid-G60 patches, not in the upstream checkout.",
                  file=sys.stderr)
            return 2

    except (RuntimeError, OSError) as error:
        print(f"XNU source check failed: {error}", file=sys.stderr)
        return 2

    print(f"XNU source check passed: {args.tag}")
    print(f"Origin: {origin}")
    print("This verifies source identity only; it does not build or boot XNU.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
