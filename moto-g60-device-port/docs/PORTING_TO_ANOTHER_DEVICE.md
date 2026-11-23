# Porting to Another Device

This guide describes how to adapt the iDroid-G60 research and porting workflow to a different device. It is a repeatable engineering process, not a promise that every phone can run the same kernel or operating system.

> **Current project status:** this repository is a research scaffold. It does not yet contain a bootable kernel or verified Moto G60 drivers. A port to another device is a separate hardware bring-up project.

## 1. Establish the device identity

Record evidence for every field. Do not infer a controller or board revision from a marketing name alone.

- Manufacturer and exact model number / regional variant
- Codename, board name and hardware revision
- SoC model, CPU architecture and GPU
- Boot ROM / bootloader chain, unlock status and boot image format
- Display panel and touch controller
- Storage, RAM, power-management IC and charging path
- Wi-Fi, cellular modem, audio codec / amplifier, cameras and sensors
- Secure-boot, verified-boot and firmware dependencies

Use read-only system properties, kernel logs, official documentation, device trees and reputable upstream source trees. Keep unknown values explicitly marked as unknown.

## 2. Create a device profile

Create a new directory under `devices/<codename>/` (or a separate device repository when the port becomes substantial). Start with:

- `device.yaml` — exact model, SoC, board and evidence links
- `HARDWARE_INVENTORY.md` — component inventory and confidence level
- `DRIVER_MATRIX.md` — subsystem status, dependencies and test evidence
- `docs/BOOT_CHAIN.md` — documented boot stages and supported formats
- `tests/README.md` — safe, reproducible test plan

Do not copy another device's values and label them verified. Reuse common code only after checking SoC and peripheral compatibility.

## 3. Audit the upstream kernel and user space

Before writing device drivers:

1. Identify the exact upstream XNU revision and its licence.
2. Check supported CPU architecture, compiler/toolchain, SDK and build dependencies.
3. Record the exact HakiOS commit and inspect its build scripts, patches and device configuration.
4. Compare the target SoC and board with existing supported devices.
5. Separate open-source code from proprietary operating-system components, firmware and vendor blobs.
6. Confirm redistribution rights before adding any binary or firmware to the repository.

Do not assume that an iOS/Darwin version number, a device-directory label, or a successful build on another phone proves compatibility with this device.

## 4. Map the boot chain before device experiments

Document the expected chain from the device's existing bootloader through any supported UEFI/U-Boot stage, loader, kernel and user space. Confirm which stages are actually available for the target device.

Start with source inspection and supported emulator/QEMU workflows. Do not flash, repartition, unlock, or replace boot components as an exploratory first step. Physical-device work requires a known-good recovery route, backups, and a tested procedure appropriate to the exact model.

Never attempt to bypass secure boot, signature checks, encryption, activation, or access controls.

## 5. Bring up hardware incrementally

Build a dependency map and tackle one subsystem at a time. Typical order (the actual order depends on the board):

1. Early console and basic boot diagnostics
2. Interrupt controller, timers and memory management
3. Storage and filesystem access
4. Display output and input
5. Power, thermal and battery reporting
6. USB and networking
7. Audio, cameras, sensors and other peripherals

For each subsystem, document the hardware identity, bus, register/interface documentation, required firmware, kernel API, implementation status, known limitations and test method. Never mark a driver as working based only on compilation or emulator output.

## 6. Test and report honestly

Use staged evidence:

- Static review and reproducible build logs
- Unit tests and mocked-interface tests where useful
- Emulator/QEMU boot and early-kernel logs
- Device-specific logs for each hardware subsystem
- Repeated functional tests, including suspend/resume and thermal behaviour where relevant

Clearly label results as `not-started`, `researching`, `implemented-unverified`, `partial`, `working`, `blocked` or `disabled`. State exactly which device variant and software revision were tested. Keep failure logs and known limitations.

## 7. Keep the port maintainable

- Pin upstream repositories to commits or tags; avoid floating branches for reproducible builds.
- Keep common kernel changes separate from device-specific code.
- Record licences and preserve required notices.
- Never commit private keys, credentials, personal data, activation material or proprietary files without explicit redistribution permission.
- Do not publish a flashable image until its provenance, contents, safety and recovery procedure have been reviewed.

## Definition of a credible device port

A device is not “ported” merely because a configuration exists or a kernel compiles. A credible milestone names the exact hardware variant, provides reproducible source/build instructions, documents the boot evidence, and demonstrates each claimed subsystem with repeatable tests.

## Applying this workflow to Moto G60

The current target is Motorola Moto G60 `XT2135-2`, codename `hanoip`, Snapdragon 732G / SM7150-AC. Existing Android device-tree information is useful for identifying likely hardware and vendor dependencies, but it is not proof that those Linux drivers can be reused in XNU. Confirm each controller on the actual target before implementing a native driver.
