# XNU baseline audit

Audit date: 2026-11-22

Status: **source identity verified; target-platform compatibility not yet established.** No build or boot was performed.

## 1. HakiOS source baseline

The inspected HakiOS `main` source tree explicitly identifies Apple's XNU release as `xnu-8796.121.2`.

Its `xnu/apply.sh` pins both:
- Tag: `xnu-8796.121.2`
- Expected Apple commit: `c54f35ca767986246321eb901baf8f5ff7923f6a`

The Apple GitHub commit endpoint independently confirms that this exact commit exists in `apple-oss-distributions/xnu` and its commit message is `xnu-8796.121.2`. This verifies the release identity used by the inspected HakiOS script.

## 2. Architecture and SDK alignment

The inspected HakiOS build scripts specify:
- XNU architecture: `ARM64`
- SDK: `iPhoneOS16.5.sdk`
- SDK version: `16.5`
- Kernel configuration: `DEVELOPMENT`
- XNU source directory: `xnu-src/xnu-8796.121.2`

Apple's XNU repository describes XNU as a Mach/BSD/IOKit kernel with ARM64 support. The target Moto G60's Snapdragon 732G is an ARM64 Qualcomm platform, so the CPU architecture is a plausible match. That fact alone does not establish board, SoC, firmware, or peripheral compatibility.

## 3. Important platform configuration issue

HakiOS's inspected `xnu-build.sh` invokes the XNU build with:

```sh
MACHINE_CONFIGS=${MACHINE:-BCM2837}
```

The inspected `xnu-env.sh` does not set `MACHINE`, so the default in that script is `BCM2837`. HakiOS's patch also refers to the ARM64 BCM2837 master configuration.

This is a concrete item to resolve before treating the upstream build command as a valid Moto G60 build recipe. We must understand which XNU machine/platform configuration HakiOS intends to use, how its Qualcomm support is wired in, and whether a proper SM7150 platform configuration is required. Do not assume that a Raspberry Pi-named machine configuration is suitable for the Moto G60.

## 4. SoC and device configuration are not interchangeable

The HakiOS reference device repository is the POCO X5 Pro / SM7325 (SC7280 family). Its SoC-specific addresses, clocks, interrupt routing, memory map, power rails, firmware interfaces and drivers are not transferable to the Moto G60 merely because both devices use Qualcomm ARM64 hardware.

The Moto G60 target is SM7150-AC. A separate SM7150 device entry such as HakiOS's `sweet` listing may be useful for comparison, but it is not proof of XT2135-2 support. Exact board and peripheral differences still need evidence.

HakiOS's porting guide requires a device-specific configuration and starts with other phone drivers excluded. That is the correct principle for our port: do not enable another device's display, touch, storage, camera, audio, Wi-Fi or power drivers on the Moto G60 without verifying their hardware targets.

## 5. Open-kernel test path

HakiOS's Makefile documents `make qemu-open` as a kernel + placeholder loader + minimal raw-syscall test program path that does not require Apple's proprietary system software. This is a useful upstream test concept.

It is not evidence that this repository can already build or boot XNU. Before attempting the build, we still need to pin the exact HakiOS commit (the inspected `main` branch is mutable), inspect its dependency scripts and licences, and confirm that the selected QEMU machine and toolchain are available.

## 6. Baseline decision

**Candidate baseline for further compatibility work:** Apple XNU `xnu-8796.121.2`, commit `c54f35ca767986246321eb901baf8f5ff7923f6a`, with the matching HakiOS patch set only after its exact HakiOS source commit is pinned and reviewed.

**Not approved as a Moto G60 build configuration yet.** The machine/platform configuration, Qualcomm SM7150 support, loader/UEFI assumptions, and target-specific driver boundary remain unresolved.

## 7. Next read-only engineering tasks

1. Pin the HakiOS repository to an exact commit and record the hashes of `xnu/hakios.patch`, `xnu/apply.sh`, `xnu-build.sh`, and the relevant configuration files.
2. Trace the `MACHINE_CONFIGS` setting through XNU's configuration system and identify the platform configuration actually required for Qualcomm ARM64.
3. Compare the SM7150 reference configuration and its device-tree-derived SoC data with the Moto G60's own documented hardware.
4. Inventory which HakiOS patches and drivers are common kernel changes versus SC7280/POCO-specific code.
5. Only after the above review, plan a reproducible open-kernel QEMU build. Do not use a physical phone as the first build test.

## Sources

- Apple XNU repository: https://github.com/apple-oss-distributions/xnu
- Verified Apple XNU commit: https://github.com/apple-oss-distributions/xnu/commit/c54f35ca767986246321eb901baf8f5ff7923f6a
- HakiOS source: https://github.com/oosexgang/hakios-xnu-kernel
- HakiOS XNU apply script: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/xnu/apply.sh
- HakiOS XNU build script: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/xnu-build.sh
- HakiOS XNU dependency setup: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/xnu-deps/setup.sh
- HakiOS device porting guide: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/docs/porting/index.md
- HakiOS repository layout: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/docs/porting/repositories.md
