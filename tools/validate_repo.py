#!/usr/bin/env python3
"""Lightweight structural checks for the iDroid-G60 research repository."""

from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
REQUIRED_FILES = [
    "README.md", "CONTRIBUTING.md", "THIRD_PARTY_NOTICES.md",
    "docs/architecture.md", "docs/roadmap.md", "docs/hardware-inventory.md",
    "devices/moto-g60/device.yaml", "platforms/qemu-arm64/README.md",
    "drivers/bluetooth/README.md",
]

missing = [path for path in REQUIRED_FILES if not (ROOT / path).is_file()]
if missing:
    print("Missing required project files:")
    for path in missing:
        print(f"  - {path}")
    sys.exit(1)

manifest = (ROOT / "devices/moto-g60/device.yaml").read_text(encoding="utf-8")
if "not-implemented" not in manifest or "status: disabled" not in manifest:
    print("Device manifest must explicitly record current support status.")
    sys.exit(1)

print(f"Repository structure check passed ({len(REQUIRED_FILES)} required files).")
print("This check does not build XNU, test drivers, or verify device bootability.")
