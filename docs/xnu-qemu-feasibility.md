# XNU and Darwin on QEMU: feasibility plan

## Reference implementation

HakiOS documents three distinct layers: an open XNU/loader/driver core, a
Darwin user space supplied and assembled separately by the user, and Apple
online services that are outside the project's goals.

Its kernel notes identify Apple's XNU tag xnu-8796.121.2 (Darwin 22.5.0)
as the base for its Darwin 16.5 user-space path. Its QEMU documentation
describes an AArch64 virt machine with UEFI and virtio devices. These are
research references, not code or binaries imported into iDroid-G60.

References:
- https://github.com/oosexgang/hakios-xnu-kernel
- https://github.com/oosexgang/hakios-xnu-kernel/blob/main/xnu/README.md
- https://hackios-web.vercel.app/en/guide/how-it-works
- https://hackios-web.vercel.app/en/docs/getting-started/qemu
- https://github.com/apple-oss-distributions/xnu

## Proposed order

### 1. Establish an upstream XNU baseline

- Use a separate checkout of the exact upstream tag under review.
- Verify its origin, tag, license, and clean worktree with make xnu-check.
- Review the ARM64 build configuration and platform-specific source.
- Do not import HakiOS patches wholesale; first map each change to an
  independently documented requirement and review its license.

### 2. Define the QEMU platform layer

The generic QEMU virt machine is not a Moto G60 emulator. Document the
virtual memory map, exception-level entry, interrupt controller, timer,
UART, device tree, and virtio devices. Identify which XNU platform
abstractions must be implemented or adapted.

### 3. Specify the loader contract

Write down the UEFI-to-loader and loader-to-XNU handoffs before implementing
the loader. The current boot/qemu-arm64 startup code is only a tiny test
payload entry point; it is not an XNU loader.

### 4. Build and boot XNU without Darwin user space

First target a reproducible kernel build and serial log in QEMU. A kernel
build, an XNU boot, and a functioning user space are three separate results
and must be reported separately.

### 5. Add a user-supplied Darwin image path

Only after the kernel and loader work should a local image-building interface
be designed. Do not put Apple system files or restore images in GitHub.
Do not implement decryption bypasses or service/activation workarounds.

### 6. Add graphical services

Graphical output requires a working kernel, user-space launch path, display
device support, and compatible window-server components. Treat the first
visible graphical screen as a later milestone, not as a consequence of a
successful kernel boot.

## Current status

- [x] Small freestanding ARM64 QEMU payload exists in this repository.
- [x] XNU reference baseline and source boundary documented.
- [x] Local upstream source identity checker added.
- [ ] Verify the existing QEMU payload runs in CI and retain its log.
- [ ] Review XNU ARM64 build dependencies and platform assumptions.
- [ ] Define the QEMU device-tree and loader handoff contract.
- [ ] Build XNU for the QEMU target.
- [ ] Boot XNU in QEMU with serial diagnostics.
- [ ] Define a separate local Darwin image workflow.
- [ ] Reach a graphical Darwin user-space boot.

Nothing in this plan establishes XNU bootability or Moto G60 support today.
