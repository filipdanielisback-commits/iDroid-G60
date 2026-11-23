# iDroid-G60 System Architecture

## Purpose and status

This document defines the intended architecture for an independent operating-system research port targeting the Motorola Moto G60 (`hanoip`, reported model `XT2135-2`, Qualcomm SM7150-AC, Adreno 618).

**Current status: architecture proposal only. The project is not bootable.** No Moto G60 XNU kernel, boot firmware, native driver stack, complete system image, or working user interface has been implemented or validated. A component becomes implemented only when code exists; it becomes working only with reproducible evidence on the stated target.

The goal is an independently developed XNU/Darwin-based system. This is not Apple's complete proprietary iOS, and this project does not claim Apple activation, Apple ID, iCloud, App Store, Secure Enclave, or compatibility with proprietary iOS applications.

## Architectural layers

The intended dependency direction is from the hardware upward:

```text
Moto G60 hardware (hanoip)
        |
Boot ROM / device boot chain / verified boot constraints
        |
Independent boot firmware and loader (research required)
        |
XNU kernel + Mach / BSD / IOKit
        |
SoC support: Qualcomm SM7150-AC
        |
Board support: hanoip device configuration
        |
Native drivers and hardware services
        |
Darwin-compatible user space and system services
        |
Graphics compositor / window server / shell
        |
Applications and developer tools
```

This is a conceptual layering diagram, not a claim that the components currently exist or that every layer can be implemented with the available upstream sources.

## Component boundaries

### 1. Boot chain and loader

Responsibilities:
- Document the actual Moto G60 boot stages, partition layout, boot image format, signing requirements and hardware security constraints.
- Identify a lawful, technically viable way to load a development kernel.
- Define handoff information required by the kernel: memory map, device tree or equivalent hardware description, command line and framebuffer/console information where available.

Status: researching. Do not modify partitions, unlock the bootloader, flash firmware or attempt a physical boot as part of this documentation milestone.

### 2. XNU kernel baseline

Responsibilities:
- Pin an exact upstream XNU revision and record its licence and required build tools.
- Establish a reproducible baseline build before adding device-specific changes.
- Audit architecture configuration, platform configuration, kernel collections/extensions and the route by which platform support is selected.
- Keep upstream changes isolated and reviewable.

Status: baseline audit documented; no Moto G60 kernel build or boot verified. An ARM64 CPU alone does not establish XNU platform compatibility.

### 3. Qualcomm SoC layer

Target: SM7150-AC (Snapdragon 732G).

Responsibilities:
- Inventory interrupt controller, timers, clock/reset controls, power domains, DMA/IOMMU, GPIO, pin control, buses and memory layout.
- Record which interfaces are described by public documentation, upstream source or Android device-tree evidence.
- Implement and test only the interfaces required by the boot and kernel milestones.

Status: researching. Do not substitute SM7325/SC7280 configuration from another phone; related Qualcomm platforms are not interchangeable.

### 4. Moto G60 board/device layer

Target codename: `hanoip`.

Responsibilities:
- Keep board-specific configuration separate from reusable SoC code.
- Track exact panel, touch controller, camera modules, audio amplifier, sensors, storage and wireless components only when confirmed for the individual target.
- Maintain source references and confidence for each hardware identification.

Status: research scaffold. Android device-tree and vendor files are clues, not native XNU drivers or proof that a component is present in every hardware revision.

### 5. Native driver layer

Candidate subsystems, each developed independently:
- Console and display output
- Touch input
- Storage and filesystem interfaces
- USB and charging/power management
- Audio codec, DSP and amplifier
- Wi-Fi and later Bluetooth
- Sensors and camera interfaces
- GPU acceleration

Every driver must document the hardware revision, bus/protocol, kernel interface, initialization dependencies, error handling, test method and known limitations. A stub, imported Linux driver, mock, or successful compile is not evidence of working hardware support.

Bluetooth is intentionally excluded from the initial milestone.

### 6. Graphics and GPU

Target GPU: Qualcomm Adreno 618.

Responsibilities:
- First establish a stable text console or simple framebuffer path.
- Investigate the GPU command processor, memory management, firmware dependencies and a suitable open driver stack.
- Treat Mesa/Turnip or other graphics projects as research inputs, not drop-in XNU drivers.
- Investigate any Metal-compatible layer only after the native graphics foundation exists.

Status: not started. GPU support from a different Adreno generation must not be assumed compatible.

### 7. Storage and filesystems

Responsibilities:
- Identify the actual storage controller and boot-time access path.
- Separate block-device support from filesystem support.
- Choose a safe, documented writable data strategy only after read-only access and recovery have been proven.
- Keep filesystem experiments isolated from the phone's existing data.

Status: researching. No storage controller or filesystem support is verified.

### 8. Darwin-compatible user space

Responsibilities:
- Pin and audit separately licensed Apple open-source components and other dependencies.
- Track ABI, SDK, dynamic linker, launch services, init/service management and required kernel interfaces.
- Build a minimal diagnostic environment before attempting a full graphical system.

Open-source Apple repositories provide individual components, not the complete proprietary iOS operating system. Proprietary Apple frameworks, apps, firmware, signing material and activation components are outside this repository's scope unless explicit redistribution and usage rights exist.

Status: not started.

### 9. Graphical environment and applications

Responsibilities:
- Build a minimal display server/compositor and input path after kernel display and touch support.
- Add a shell, settings/diagnostics tools and applications incrementally.
- Keep UI work independent of claims about iOS compatibility.

Status: not started. A visual shell is not a substitute for operating-system or hardware support.

## Build and validation strategy

1. **Source audit:** pin upstream revisions, licences, toolchains and build instructions.
2. **Host baseline:** reproduce the upstream kernel build without Moto G60 patches.
3. **Emulator baseline:** use the supported QEMU path to validate generic kernel startup and diagnostics. QEMU success does not prove Moto G60 compatibility.
4. **Platform research:** establish a documented SM7150-AC hardware model and identify missing specifications.
5. **Minimal boot path:** only after the above, design a non-destructive target boot experiment with a verified recovery route.
6. **Drivers one at a time:** require subsystem-specific tests and logs.
7. **User space:** add minimal services before graphics and applications.
8. **Release discipline:** publish no image as bootable or usable unless the exact device variant and test evidence are recorded.

## Evidence and status rules

Use the status vocabulary from the project README:
- `not-started`
- `researching`
- `implemented-unverified`
- `partial`
- `working`
- `blocked`
- `disabled`

For every claim of `working`, record device model/revision, software commit, build configuration, test procedure, result and relevant logs. Emulator results must be labelled emulator-only.

## Non-goals and safety boundaries

- Do not represent this project as Apple's official iOS or a complete iOS 27.2 port.
- Do not include proprietary Apple system images, private keys, certificates, activation data or unlicensed vendor firmware.
- Do not bypass secure boot, code signing, encryption or activation mechanisms.
- Do not perform destructive flashing, repartitioning or bootloader changes as a substitute for source-level validation.
- Do not claim hardware support from copied configuration, a successful compile or another device's test results.

## Immediate engineering milestone

The next milestone is a pinned, reproducible generic XNU/QEMU baseline and a verified build-environment report. In parallel, continue read-only identification of the Moto G60 boot chain and SM7150-AC platform interfaces. Device-specific configuration files should be added only when their values are supported by source evidence.
