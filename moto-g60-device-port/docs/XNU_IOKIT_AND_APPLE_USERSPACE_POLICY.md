# XNU, IOKit, and Apple user-space policy

## Project direction

The Moto G60 port may investigate Apple's open-source XNU kernel and its IOKit driver architecture. This is a device-port research project for the Motorola XT2135-2 (`hanoip`), not a claim that the phone is supported by Apple or that a complete, official iOS release has been ported.

## What we mean by IOKit

IOKit is the C++ driver framework integrated into XNU. The public XNU source tree contains IOKit-related kernel code and headers. We may study, adapt, and include applicable open-source XNU/IOKit code only while preserving its original copyright notices and complying with the applicable licence (including the Apple Public Source License 2.0 where applicable).

A native Moto G60 driver must be implemented and tested for the actual hardware and XNU environment. Android/Linux drivers, Android HALs, and vendor kernel modules are useful references for hardware behaviour, but they are not automatically XNU/IOKit drivers.

## What must not be committed

Do not add Apple's proprietary iOS/Darwin system images, extracted system files, private headers, firmware images, keys, certificates, activation material, or other files unless their redistribution rights are explicitly established. Do not add proprietary Motorola/Qualcomm firmware blobs without confirming redistribution permission.

If a file's origin or licence is uncertain, leave it out and record the uncertainty in the third-party notices/inventory for review. Do not bypass encryption, signing, activation, or access controls.

## User-supplied Apple software

If future experiments require an Apple system image, keep it outside this Git repository. Any local build or experiment must use files the user is independently entitled to access and must comply with the relevant terms and law. This document does not claim that a particular iOS version can boot on the Moto G60.

## Version and claims discipline

HakiOS's public documentation describes an open XNU-based core and says its Darwin user space is supplied separately. Its documentation has described a Darwin 16.5 user-space path; social-media claims mentioning “iOS 27.2 booted” must be independently verified before treating them as proof that Apple's complete, unmodified iOS 27.2 runs on non-Apple hardware.

For this project:
- Record the exact XNU source tag, patches, build configuration, and boot logs.
- Record the exact user-space provenance and version for each experiment.
- Distinguish a kernel boot, a Darwin user-space boot, a graphical demo, and a complete iOS installation.
- Never describe an experiment as “genuine iOS 27.2” unless the exact Apple components and their operation have been independently verified.

## Initial implementation sequence

1. Audit the selected XNU base and its licence obligations.
2. Build an open-source-only development target before introducing any Apple or vendor-supplied binaries.
3. Document the Moto G60 boot environment and hardware inventory.
4. Bring up the platform incrementally, recording evidence for each milestone.
5. Develop and test IOKit-based drivers one subsystem at a time; keep unsupported hardware marked as unknown or not started.

## References

- Apple XNU source: https://github.com/apple-oss-distributions/xnu
- HakiOS architecture and user-space boundary: https://hackios-web.vercel.app/en/guide/how-it-works
- HakiOS contribution and repository-content rules: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/CONTRIBUTING.md
- HakiOS licence information: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/LICENSE
