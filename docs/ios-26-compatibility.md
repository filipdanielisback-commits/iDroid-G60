# iOS 26 Compatibility — Research Scope

**Status: exploratory documentation only. No iOS 26 compatibility is implemented or demonstrated.**

## Purpose

This document records why iOS 26 is being used as a research reference for the iDroid-G60 project. It does not claim that Apple's operating system can be installed, reproduced, or booted on the Motorola Moto G60.

## Important distinction

iDroid-G60 is an independent Darwin/XNU-oriented operating-system research project. It is **not a genuine iOS port**.

The public XNU source is only one part of Apple's operating-system stack. A functioning iOS system also depends on proprietary components, platform-specific drivers, hardware support, signing and security mechanisms, and other Apple-controlled software. Public XNU source alone is not sufficient to recreate iOS.

The project will not redistribute proprietary Apple software, firmware, signing material, or device images.

## Current project facts

- Target device: Motorola Moto G60 (codename `hanoip`).
- Target architecture for research: ARM64.
- SoC identification in the project: Qualcomm SM7150-AC / Snapdragon 732G.
- Upstream kernel reference: [Apple Open Source XNU](https://github.com/apple-oss-distributions/xnu).
- Current device boot status: not bootable.
- Moto G60 driver status: unverified; no working drivers are claimed.

## Research questions

The following questions require evidence before implementation decisions can be made:

1. Which XNU source components and build targets are relevant to ARM64 research?
2. What platform interfaces does the selected XNU code expect?
3. Which Moto G60 hardware interfaces are documented by reliable, device-specific sources?
4. Which parts of the project can be tested independently in an ARM64 QEMU environment?
5. What licensing and attribution requirements apply to every upstream or third-party component?

## Milestones

### 1. Source and platform review

- [ ] Record the exact upstream XNU revision being studied.
- [ ] Review its license and preserve required notices.
- [ ] Document supported architectures and build targets from upstream sources.
- [ ] Separate confirmed device facts from assumptions and unknowns.

### 2. Emulator-first experiments

- [ ] Record host operating-system and toolchain versions.
- [ ] Set up a reproducible ARM64 QEMU test environment.
- [ ] Run a small educational ARM64 payload or kernel exercise.
- [ ] Save commands, logs, and test results.
- [ ] Clearly state what each experiment does and does not demonstrate.

### 3. Device feasibility study

- [ ] Verify the exact Moto G60 variant and board revision.
- [ ] Gather primary-source evidence for hardware components and interfaces.
- [ ] Document boot architecture and platform requirements.
- [ ] Review safety and recovery constraints before considering any physical-device experiment.

### 4. Compatibility assessment

- [ ] Compare documented XNU platform requirements with verified device information.
- [ ] Identify missing proprietary or undocumented dependencies.
- [ ] Publish a feasibility assessment before making any compatibility claim.

## iOS 27 note

A possible future review of newer Apple operating-system releases, including iOS 27, is only a planning idea. It is not a committed implementation target or a compatibility promise.

## Claim and release policy

A feature may be described as implemented only when its code, test method, and reproducible evidence are available in the repository. A successful QEMU experiment does not prove that the code works on the Moto G60.

Until then, describe this work as **research**, **planned**, **experimental**, or **unverified**, as appropriate.

## Disclaimer

iDroid-G60 is an independent educational research project and is not affiliated with or endorsed by Apple or Motorola. Apple names and trademarks belong to their respective owners.
