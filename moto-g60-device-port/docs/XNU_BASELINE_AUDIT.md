# XNU baseline audit

Audit update: 2026-11-23

Status: **candidate Apple source revision verified and pinned; Moto G60 compatibility and our build environment remain unverified.** The source-fetch script has not yet been run. No kernel compile or boot has been performed by this project.

## 1. Candidate Apple XNU source

The newer inspected HakiOS snapshot is pinned at:
- HakiOS repository: https://github.com/oosexgang/hakios-xnu-kernel
- HakiOS reference commit: `62e09f850f1f713192228cb9031da256033ede93`
- Apple XNU tag: `xnu-12377.121.6`
- Apple XNU commit: `ac9718fb1af618d5ce8678d0dc6e8a58f252216f`

The Apple commit was independently fetched from the official `apple-oss-distributions/xnu` repository. Its commit message identifies `xnu-12377.121.6`.

Our repository records this as a **candidate source baseline**, not a validated iOS 27.2 system or a Moto G60-ready kernel. The lock file is `build/XNU_BASELINE.lock`; the fetch/verification script is `scripts/fetch-xnu-baseline.sh`. Run it with:

```sh
bash scripts/fetch-xnu-baseline.sh
```

It checks the tag resolves to the pinned commit and refuses to switch a checkout with local changes. It only fetches source; it does not patch, configure, compile or boot XNU.

The earlier HakiOS snapshot used XNU `xnu-8796.121.2`, commit `c54f35ca767986246321eb901baf8f5ff7923f6a`. That older baseline is retained here as historical research, not the current candidate.

## 2. HakiOS build information and limits

The inspected HakiOS commit's `Documentation/building.md`, `kernel/build.sh`, and `build.config.arm64` describe:
- XNU architecture: plain `arm64`
- Kernel configuration: `DEVELOPMENT`
- Machine configuration: `BCM2837`
- SDK: iPhoneOS 16.5
- Build and dependency assembly through HakiOS-specific overlay, patch and host-tool scripts
- QEMU testing through HakiOS's own workbench

This is a build recipe for that HakiOS source tree and its patches. It is **not** a generic recipe for unmodified Apple XNU, and it is not an SM7150-AC or `hanoip` configuration. We must not copy its machine configuration, patches, SDK assumptions or device drivers into our project without a separate compatibility review.

In particular, the HakiOS documentation's use of an iPhoneOS 16.5 SDK does not by itself prove compatibility with the desired iOS release. Kernel source revision, SDK headers, ABI and user-space release are separate versioning questions.

## 3. Moto G60 target facts

- Device: Motorola Moto G60 XT2135-2
- Codename: `hanoip`
- SoC: Qualcomm SM7150-AC / Snapdragon 732G
- GPU: Adreno 618
- CPU architecture: ARM64

ARM64 is a necessary architecture match, not proof of platform compatibility. The POCO X5 Pro / SM7325 (SC7280-family) reference device is not interchangeable with SM7150-AC. Even a shared SoC family would not establish board-level compatibility.

## 4. Unresolved build decisions

Before creating a real compile command, we must establish:
1. The host operating system and supported compiler/linker toolchain.
2. The exact SDK and host utilities required for the selected XNU revision.
3. Whether the intended first build is a generic QEMU reference kernel or a device-target kernel.
4. The machine/platform configuration required for that QEMU target.
5. Which upstream patches are essential to build and which are HakiOS-specific.
6. How the eventual SM7150-AC platform configuration differs from the QEMU-only configuration.

Do not set `MACHINE_CONFIGS=BCM2837` and label the result a Moto G60 build. A QEMU-only result must be labelled as such.

## 5. Milestones and evidence

| Milestone | Required evidence |
|---|---|
| Source fetched | Script output showing tag and exact commit |
| Toolchain identified | Host OS, compiler/linker versions, SDK identity and checksums where available |
| Build configuration selected | Source-backed explanation of architecture, machine/platform and kernel config |
| Kernel compiles | Full reproducible command, exit status, build log and artifact hash |
| QEMU boot | Captured console log showing kernel entry and early initialization |
| Moto G60 boot | Exact XT2135-2 identification and repeatable device logs |
| Driver works | Subsystem-specific tests on the actual target hardware |

A source checkout is not a kernel build. A successful compile is not a boot. A QEMU boot is not Moto G60 hardware support.

## References

- Apple XNU repository: https://github.com/apple-oss-distributions/xnu
- Candidate Apple XNU commit: https://github.com/apple-oss-distributions/xnu/commit/ac9718fb1af618d5ce8678d0dc6e8a58f252216f
- Earlier Apple XNU commit: https://github.com/apple-oss-distributions/xnu/commit/c54f35ca767986246321eb901baf8f5ff7923f6a
- Pinned HakiOS reference snapshot: https://github.com/oosexgang/hakios-xnu-kernel/commit/62e09f850f1f713192228cb9031da256033ede93
- HakiOS build documentation: https://github.com/oosexgang/hakios-xnu-kernel/blob/62e09f850f1f713192228cb9031da256033ede93/Documentation/building.md

## Scope and safety

This is an independent XNU/Darwin research port, not Apple's complete proprietary iOS. Do not include proprietary Apple system images, private keys, certificates, activation data or unlicensed vendor firmware. Do not attempt physical-device flashing or boot-chain changes as part of the source-baseline milestone.
