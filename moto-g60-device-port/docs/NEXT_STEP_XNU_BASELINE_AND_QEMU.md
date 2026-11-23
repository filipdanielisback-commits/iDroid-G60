# Next step: XNU baseline and compatibility audit

Status: candidate source identity pinned; target-platform compatibility not established. The source-fetch script has not yet been run, and no kernel build or device boot has been completed.

## Target

- Device: Motorola Moto G60 XT2135-2
- Codename: hanoip
- SoC family: Qualcomm SM7150-AC / Snapdragon 732G
- Android reference build: S2RIS32.32-20-9-9-2-3
- Bluetooth: intentionally out of scope

## Current source finding

The inspected HakiOS `main` tree pins Apple's XNU release to:
- Tag: `xnu-8796.121.2`
- Apple commit: `c54f35ca767986246321eb901baf8f5ff7923f6a`

The Apple commit was independently fetched from the official `apple-oss-distributions/xnu` repository and its message confirms the release tag. HakiOS's build scripts use ARM64 and the iPhoneOS 16.5 SDK. The target's ARM64 CPU architecture is a plausible match, but that is not enough to establish platform compatibility.

**Important unresolved issue:** HakiOS's `xnu-build.sh` defaults `MACHINE_CONFIGS` to `BCM2837` unless `MACHINE` is set. The inspected `xnu-env.sh` does not set it. We must trace this setting through XNU and understand how HakiOS's Qualcomm support selects its platform configuration before adapting any build recipe to SM7150.

The HakiOS source tree inspected on `main` is mutable. Its exact commit must be pinned before its patch set or build process can be treated as reproducible.

## Compatibility boundaries

- HakiOS's reference POCO X5 Pro is SM7325 / SC7280-family. Its board-level drivers and hardware values are not automatically compatible with SM7150-AC.
- A separate SM7150 device listing such as `sweet` is a comparison lead, not proof of Moto G60 XT2135-2 support.
- The Moto G60's Android/Linux device tree and vendor blobs are useful evidence about its hardware, but Linux drivers are not native XNU drivers.
- HakiOS documents an open-kernel QEMU route (`make qemu-open`) that does not require Apple's proprietary system software. We have not run that build.

## Next tasks

1. Pin the exact HakiOS commit and record hashes for its XNU patch, apply script, build script and configuration.
2. Trace XNU's `MACHINE_CONFIGS` selection and determine the required Qualcomm ARM64 platform configuration.
3. Compare SM7150 reference data with the Moto G60's own device-tree and hardware inventory.
4. Separate common XNU changes from SC7280/POCO-specific patches and drivers.
5. After source review, plan a reproducible open-kernel QEMU build. Do not use the physical phone as the first build test.

## Evidence required before claiming progress

| Milestone | Required evidence |
|---|---|
| Source baseline identified | Official Apple tag/commit, exact HakiOS commit, licences and dependency record |
| Platform configuration understood | Source-backed explanation of machine/platform selection and Qualcomm support |
| Kernel builds | Reproducible build log and artifact metadata |
| QEMU kernel boot | Captured console log showing kernel entry and early initialization |
| Device boot | Device-specific logs and repeatable boot evidence |
| Driver works | Tests on the actual XT2135-2 hardware |

## References

- Apple XNU: https://github.com/apple-oss-distributions/xnu
- Verified XNU commit: https://github.com/apple-oss-distributions/xnu/commit/c54f35ca767986246321eb901baf8f5ff7923f6a
- HakiOS source: https://github.com/oosexgang/hakios-xnu-kernel
- HakiOS porting guide: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/docs/porting/index.md

See [XNU_BASELINE_AUDIT.md](XNU_BASELINE_AUDIT.md) for the detailed source audit.

## Scope and honesty

This is an independent XNU/Darwin research port. A kernel boot or a Darwin user-space boot does not by itself establish that the complete, unmodified proprietary iOS product is running. Do not call a build genuine iOS unless the exact Apple components and their operation have been independently verified.
