# Device-specific drivers

This directory is reserved for native Moto G60 driver implementations.

Do not add empty driver stubs and describe them as support. Each implementation must identify the actual controller, bus, interrupt, clock, regulator and firmware dependencies from reliable device-specific evidence.

Before implementation:
- Confirm the exact Moto G60 model and board revision.
- Trace the component through device tree, kernel sources and hardware documentation.
- Identify the target XNU driver interface and any required adaptation layer.
- Review firmware provenance and redistribution permissions.

After implementation:
- Build with warnings enabled.
- Add unit or emulator tests for portable logic where possible.
- Add a documented hardware test procedure.
- Mark the driver `implemented-unverified` until physical-device tests pass.
- Record limitations; never claim full support from a partial test.

Bluetooth is intentionally disabled in the initial project scope.
