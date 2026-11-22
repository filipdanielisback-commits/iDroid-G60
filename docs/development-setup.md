# Development setup

Supported development paths for this research project:

- Windows 10/11 with WSL2 and an Ubuntu distribution.
- Native Ubuntu Linux.

The exact toolchain versions will be pinned after the first reproducible ARM64 emulation experiment. Avoid mixing Windows-native and Linux toolchains in the same build directory.

## Common tools

- Git
- Python 3
- C/C++ compiler toolchain (Clang/LLVM or GCC, as required by a specific experiment)
- CMake and Ninja where needed
- QEMU system emulation for AArch64
- A text editor

See [Windows + WSL2](setup-windows-wsl2.md) and [native Ubuntu](setup-ubuntu.md).

## Build hygiene

Use a separate build directory per host environment. Keep generated files out of Git. Record tool versions and full commands in test notes. Never place credentials, firmware blobs, or device dumps in the repository.
