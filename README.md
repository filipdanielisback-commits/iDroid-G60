# iDroid-G60

**Experimental Darwin-based operating-system research for the Motorola Moto G60.**

iDroid-G60 is an independent research project exploring what it would take to bring selected Darwin/XNU concepts to an ARM64 mobile platform. It is not iOS, does not contain Apple's proprietary iOS userland, and does not currently boot on the Moto G60.

> **Status: early research / not bootable.** No Moto G60 drivers are claimed to work yet. Do not treat this repository as a phone image, recovery package, or daily-use operating system.

## Project goals

- Study the public XNU source and document the work required for a separately maintained research port.
- Inventory the Moto G60 hardware and document evidence for each component.
- Develop and test portable components in a controlled QEMU environment before considering physical hardware.
- Keep upstream code, original project code, device-specific code, and third-party components clearly separated.
- Keep Bluetooth disabled in the project's initial device-support scope.

## Non-goals

- Recreating or distributing genuine iOS 26.2.
- Redistributing proprietary Apple or Motorola firmware.
- Claiming hardware support without reproducible tests.
- Replacing the phone's installed operating system or providing an unverified flashable image.

## Repository map

| Path | Purpose |
|---|---|
| `docs/` | Architecture, setup, roadmap, and hardware research |
| `kernel/` | XNU research notes, configuration, and project patches |
| `boot/` | Boot architecture research and diagnostic interfaces |
| `devices/moto-g60/` | Device inventory and platform-specific notes |
| `drivers/` | Driver status, interfaces, and test plans |
| `platforms/qemu-arm64/` | Safe emulator-first development notes |
| `userland/` | Experimental user-space design |
| `tools/` | Validation and development utilities |
| `tests/` | Test plans and test code |

## Development environments

- Windows 10/11 with WSL2 and Ubuntu
- Native Ubuntu Linux

See [development setup](docs/development-setup.md), [Windows + WSL2](docs/setup-windows-wsl2.md), and [Ubuntu](docs/setup-ubuntu.md).

## First compiled-code experiment

The repository now includes a small freestanding ARM64 test payload for QEMU's
generic `virt` machine. It prints a serial-console marker and is built by the
root Makefile:

```sh
make check
make arm64
make qemu
```

This is a build-system and ARM64 execution experiment only. It is **not XNU,
Darwin, iOS, or a Moto G60 boot image**. See
[the QEMU bring-up notes](docs/qemu-arm64-bringup.md). GitHub Actions also
builds the payload and checks its QEMU serial output.

## First milestone

Milestone 001 is complete only when the repository structure, documentation, hardware inventory process, and validation checks are reviewed. See [the roadmap](docs/roadmap.md).

## Hardware status

All Moto G60 hardware support is currently **unverified**. The device manifest intentionally uses unknown/TODO values until each item is confirmed from reliable device-specific sources and, later, reproducible tests.

## Upstream and licensing

XNU is maintained by Apple and is available from [apple-oss-distributions/xnu](https://github.com/apple-oss-distributions/xnu). Read the upstream license and notices before using or modifying any source. This repository does not vendor XNU at this stage.

No blanket license is granted to third-party or upstream material. Licensing for original project contributions will be documented after compatibility review. See [third-party notices](THIRD_PARTY_NOTICES.md).

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md). Research claims should include links to their sources and clearly distinguish verified facts from hypotheses.

## Disclaimer

This is an educational operating-system research project. It is not affiliated with or endorsed by Apple or Motorola. Names and trademarks belong to their respective owners.
