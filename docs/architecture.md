# Architecture overview

## Current status

This document describes a proposed research architecture, not a working system.

## Layers

1. **Development host:** Windows + WSL2 Ubuntu or native Ubuntu.
2. **Emulation platform:** QEMU ARM64 `virt` for controlled experiments.
3. **Boot research:** document firmware handoff, memory ownership, exception levels, and boot protocol requirements. No phone bootloader implementation is claimed.
4. **Kernel research:** study public XNU source and identify the gap between supported upstream targets and the Moto G60 platform.
5. **Platform layer:** keep device-specific descriptions and hardware discovery separate from generic kernel code.
6. **Drivers:** define interfaces and test plans before writing hardware-specific implementations.
7. **Userland:** begin with a minimal diagnostic environment only after a kernel execution path exists.

## Design rules

- Emulator first; physical hardware later.
- Keep upstream source, project patches, and device-specific code separate.
- Treat undocumented registers and firmware interfaces as unknown.
- No driver is marked supported without a test record.
- Bluetooth is disabled by project policy in the initial scope.
- Do not describe this project as iOS or claim iOS application compatibility.

## Major unknowns

The exact board revision, boot firmware interface, memory map, interrupt controller configuration, display pipeline, touch controller, wireless chipset, audio path, storage layout, and power-management interfaces require device-specific verification.
