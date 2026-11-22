# Windows + WSL2 setup

This is a development-host checklist, not a phone-flashing guide.

1. Use a supported Windows 10/11 installation with WSL2 available.
2. Install an Ubuntu distribution through the official Windows/WSL documentation.
3. Open the Ubuntu terminal and update its package index.
4. Install Git, Python 3, build-essential, Clang/LLVM, CMake, Ninja, and QEMU's AArch64 system-emulation package using the distribution's package manager.
5. Clone this repository inside the Linux filesystem (for example, under the Ubuntu home directory) rather than a mounted Windows path for Linux builds.
6. Record versions with `git --version`, `python3 --version`, `clang --version`, `cmake --version`, and `qemu-system-aarch64 --version`.
7. Run `python3 tools/validate_repo.py`.

Package names can differ between Ubuntu releases. This setup is not yet a validated XNU build environment. See the official [Microsoft WSL documentation](https://learn.microsoft.com/windows/wsl/).
