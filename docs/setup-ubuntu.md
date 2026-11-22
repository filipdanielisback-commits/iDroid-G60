# Native Ubuntu setup

This is a development-host checklist, not a phone-flashing guide.

1. Install a supported Ubuntu release on a development machine or virtual machine.
2. Install Git, Python 3, build-essential, Clang/LLVM, CMake, Ninja, and QEMU's AArch64 system-emulation package using Ubuntu's package manager.
3. Clone this repository.
4. Record versions with `git --version`, `python3 --version`, `clang --version`, `cmake --version`, and `qemu-system-aarch64 --version`.
5. Run `python3 tools/validate_repo.py`.

Package names and versions vary by Ubuntu release. This setup is not yet a validated XNU build environment.
