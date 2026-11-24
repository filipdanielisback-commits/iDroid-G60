# XNU loader integration boundary

The loader is a separate component between the QEMU firmware and XNU. This
directory is currently an architecture note; no HakiOS loader binary or
loader source has been copied here.

## Intended QEMU path

~~~text
QEMU AArch64 virt
  -> AArch64 UEFI firmware
  -> iDroid-G60 EFI loader (not implemented)
  -> validated memory map and boot arguments
  -> XNU ARM64 entry point (not integrated)
  -> kernel platform initialization
~~~

## Work required before implementation

- Document the firmware handoff and the exact XNU entry contract.
- Define memory-map ownership, alignment, reserved regions, and device-tree
  handoff for the QEMU virt machine.
- Define how the loader locates the kernel and optional init/user-space image.
- Add serial logging and explicit failure codes.
- Test only with QEMU artifacts until the boot protocol is independently
  reviewed and repeatable.

The loader must not assume that a phone boot image, a Moto G60 boot chain, or
HakiOS's device-specific loader can be used unchanged on generic QEMU.

## Scope boundary

This project may study public documentation and independently implement a
compatible loader. Any reused third-party code must be tracked with its exact
origin, license, notices, and required source availability before inclusion.
No proprietary firmware or Darwin system image belongs in this directory.
