# Upstream source catalog (research references)

This file records upstream source repositories for independent research. It does not vendor, mirror, copy, or claim to implement those projects. Before incorporating any source file, pin an exact commit/tag, inspect that file's license and notices, and record the provenance.

## Apple-published open-source components

| Component | Official upstream | Intended research use | Important boundary |
|---|---|---|---|
| XNU kernel | https://github.com/apple-oss-distributions/xnu | Kernel, Mach/BSD interfaces, IOKit framework code and platform interfaces | Select a release/tag compatible with the chosen Darwin user-space target; preserve APSL notices and meet source-publication obligations for modifications. |
| IOKit user-space support | https://github.com/apple-oss-distributions/IOKitUser | Public user-space IOKit interfaces and libraries | Not a substitute for native Moto G60 kernel drivers. |
| HID family | https://github.com/apple-oss-distributions/IOHIDFamily | HID abstractions and input-stack research | Hardware-specific transport and controller support still need independent implementation and testing. |
| launchd | https://github.com/apple-oss-distributions/launchd | Service manager and launch infrastructure research | A public source repository does not imply every iOS-specific service or configuration is published. |
| libdispatch | https://github.com/apple-oss-distributions/libdispatch | Dispatch/concurrency library research | Repository currently identifies Apache-2.0; verify the exact revision and bundled notices. |
| libplatform | https://github.com/apple-oss-distributions/libplatform | Low-level platform support library research | Repository currently identifies Apache-2.0; verify the exact revision and bundled notices. |
| Libc | https://github.com/apple-oss-distributions/Libc | C/POSIX runtime source research | Must be version-matched with the selected kernel and user space. |
| dyld | https://github.com/apple-oss-distributions/dyld | Dynamic loader and shared-cache tooling research | Does not provide the proprietary iOS frameworks or binaries. |

Apple's public source organization is https://github.com/apple-oss-distributions. It publishes individual open-source components, not a complete source tree for every iOS release.

## HakiOS references (architecture study only)

- Main project: https://github.com/oosexgang/hakios-xnu-kernel
- Device-port guide: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/Documentation/porting.md
- Current README: https://github.com/oosexgang/hakios-xnu-kernel#readme
- HakiOS developer site: https://hakios-developers.com/

The current HakiOS README describes XNU `xnu-12377.121.6`, Darwin 26/27 user-space image builders, its own loader and drivers, IOKit stand-ins, and an APFS implementation. It reports a Darwin 27.2 (24B119) home-screen boot on a Snapdragon 780G phone using iPhone12,1 files, with software rendering (`gpu=0`). The README distinguishes phone observations, QEMU observations, and host tests.

HakiOS is a reference for architecture and publicly documented results only. This project will write its own device code and build system; it will not copy HakiOS source, patches, drivers, or generated binaries.

## Version and compatibility policy

- Do not label a kernel build "Darwin 27.2" merely because it uses a recent XNU tag. Record the exact XNU tag, commit, build configuration, and user-space provenance separately.
- Apple does not publish a complete open-source iOS 27.2 source tree. Public XNU and library repositories are individual components; proprietary frameworks, services, assets, firmware, and system binaries are not thereby open source.
- HakiOS's reported Darwin 27.2 boot is not evidence that every component of the complete, unmodified iOS 27.2 product is running.
- Do not commit IPSW contents, proprietary Apple binaries, firmware, private keys, certificates, activation material, or vendor blobs unless redistribution rights are clearly established. Do not bypass encryption, signing, activation, or access controls.
- Keep locally supplied system images outside this public repository. Record only version/provenance metadata that is safe and lawful to publish.
- Before using any Apple source, retain copyright notices and follow that repository's exact license. XNU is published under APSL 2.0; licenses differ across Apple's repositories.

## Moto G60-specific rule

The target remains Motorola Moto G60 XT2135-2 (`hanoip`). Apple source is not a Moto G60 driver. Each display, touch, storage, GPU, Wi-Fi, audio, camera, and power component needs its own hardware identification, native implementation plan, and test evidence. Android/Linux sources may be used as technical references, not represented as XNU/IOKit drivers.
