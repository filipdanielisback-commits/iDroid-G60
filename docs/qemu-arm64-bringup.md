# ARM64 QEMU bring-up experiment

## Purpose

This is the first compiled-code milestone for iDroid-G60. It builds a tiny
freestanding AArch64 payload and runs it on QEMU's generic `virt` machine.
The payload writes a diagnostic message to the emulated PL011 serial console.

It is deliberately **not** XNU, Darwin, iOS, a phone bootloader, or a Moto G60
kernel. It proves only that this repository can compile and launch a small
ARM64 program in a controlled emulator.

## Requirements

- Linux, or Windows through WSL2 with Ubuntu;
- Git, Make, Python 3;
- Clang/LLVM with the AArch64 bare-metal target and LLD;
- QEMU with `qemu-system-aarch64`.

## Build

From the repository root:

```sh
make check
make arm64
```

The resulting ELF file is `build/idroid-qemu.elf`.

## Run

```sh
make qemu
```

The serial console should include:

```text
iDroid-G60 ARM64 QEMU bring-up: PASS
This is a minimal freestanding test payload, not XNU.
```

Stop QEMU with `Ctrl-C`.

## What this proves

- the ARM64 source files compile with a freestanding toolchain;
- the linker produces an AArch64 ELF executable;
- the generic QEMU `virt` machine can start the test payload;
- the test can write to the emulated PL011 UART.

## What this does not prove

- that XNU has been imported, patched, or built;
- that the payload is a complete operating-system kernel;
- that the Moto G60 boot chain is compatible;
- that any Moto G60 driver works;
- that iOS or Apple's proprietary user space is present.

## Next engineering work

1. Make the emulator run reproducible in CI and retain its serial log.
2. Document the QEMU machine's memory map and exception-level handoff.
3. Study XNU's supported ARM64 build configuration and platform dependencies.
4. Define a separate, reviewable XNU integration plan before importing or
   modifying upstream source.
5. Keep Moto G60 hardware research separate from the generic QEMU target.

Do not use this artifact on a physical phone.
