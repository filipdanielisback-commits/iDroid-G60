# Next step: pinned XNU source and QEMU baseline

Status: **candidate source revision pinned; source fetch not yet run; no kernel compile or boot completed.** This document is a work plan, not a claim of a working kernel.

## Target

- Device: Motorola Moto G60 XT2135-2
- Codename: hanoip
- SoC: Qualcomm SM7150-AC / Snapdragon 732G
- GPU: Adreno 618
- Bluetooth: intentionally excluded from the initial scope

## Candidate upstream source

The newer inspected HakiOS snapshot is pinned at commit `62e09f850f1f713192228cb9031da256033ede93`. It identifies the Apple XNU source as:
- Tag: `xnu-12377.121.6`
- Apple commit: `ac9718fb1af618d5ce8678d0dc6e8a58f252216f`

The Apple commit was independently verified in the official `apple-oss-distributions/xnu` repository. Our lock file is `build/XNU_BASELINE.lock`. Fetch and verify the exact source with:

```sh
bash scripts/fetch-xnu-baseline.sh
```

The script fetches the official Apple tag, verifies the resolved commit, checks out that exact commit, and refuses to switch a checkout with local changes. It does not apply HakiOS patches, configure, compile or boot the kernel.

This is a candidate XNU source revision, not a validated iOS 27.2 system or a Moto G60-ready kernel. The earlier HakiOS snapshot used `xnu-8796.121.2`; that is now historical research rather than our current candidate.

## What HakiOS does—and what we must not copy blindly

The pinned HakiOS reference snapshot's build documentation describes a custom kernel assembly and patch process, an iPhoneOS 16.5 SDK, ARM64, DEVELOPMENT configuration and `MACHINE_CONFIG=BCM2837`. Its own source tree and patches are required for that recipe.

That is not a generic Apple XNU build command, and `BCM2837` is not the Moto G60's Qualcomm platform. We will not label a build using that machine setting as a Moto G60 kernel. The iPhoneOS 16.5 SDK in HakiOS's recipe also does not prove that its user-space or SDK setup matches our desired iOS release.

## Build sequence

1. **Source fetch:** run the pinned fetch script and save its output.
2. **Host identification:** record whether the build host is Ubuntu, Ubuntu under WSL2, or macOS, plus compiler and linker versions.
3. **Toolchain audit:** establish the exact host tools and SDK required for this XNU revision. Do not mix Windows-native and Linux toolchains in one build directory.
4. **QEMU platform decision:** identify a documented generic ARM64 QEMU configuration and the XNU platform support it needs.
5. **Baseline compile:** build the generic reference kernel only after the machine/platform configuration and toolchain are supported by source evidence.
6. **QEMU boot:** capture the console log and artifact hash. A QEMU boot proves only the emulator configuration.
7. **Moto G60 port:** separately develop SM7150-AC and hanoip support after the generic baseline is understood.

## Unresolved technical questions

- Which host environment will be used: native Ubuntu, Ubuntu under WSL2, or macOS?
- Which SDK and host utilities are required by the pinned XNU release?
- Which generic QEMU machine configuration can be built without pretending to support the phone?
- How should SM7150-AC platform initialization differ from the emulator platform?
- Which HakiOS patches are general XNU build support and which are tied to its own platform, loader or drivers?

## Evidence required

| Milestone | Required evidence |
|---|---|
| Source fetched | Script output showing exact tag and commit |
| Toolchain identified | OS, compiler/linker versions, SDK identity |
| Build configuration selected | Source-backed platform and machine configuration |
| Kernel compiles | Full command, exit status, log and artifact hash |
| QEMU boot | Console log showing kernel entry and early initialization |
| Moto G60 boot | Repeatable logs from exact XT2135-2 hardware |
| Driver works | Subsystem-specific test on the actual device |

A source checkout is not a build. A successful compile is not a boot. A QEMU boot is not Moto G60 hardware support.

## References

- Apple XNU: https://github.com/apple-oss-distributions/xnu
- Candidate Apple XNU commit: https://github.com/apple-oss-distributions/xnu/commit/ac9718fb1af618d5ce8678d0dc6e8a58f252216f
- Earlier Apple XNU commit: https://github.com/apple-oss-distributions/xnu/commit/c54f35ca767986246321eb901baf8f5ff7923f6a
- Pinned HakiOS reference snapshot: https://github.com/oosexgang/hakios-xnu-kernel/commit/62e09f850f1f713192228cb9031da256033ede93
- HakiOS build documentation at that commit: https://github.com/oosexgang/hakios-xnu-kernel/blob/62e09f850f1f713192228cb9031da256033ede93/Documentation/building.md

See [XNU_BASELINE_AUDIT.md](XNU_BASELINE_AUDIT.md) for the source and platform audit.

## Scope and safety

This is an independent XNU/Darwin research port, not Apple's complete proprietary iOS. Do not include proprietary Apple system images, private keys, certificates, activation data or unlicensed vendor firmware. Do not attempt physical-device flashing or boot-chain changes as part of this source-baseline milestone.
