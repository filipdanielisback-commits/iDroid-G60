# Moto G60 Device Port

Device-specific platform work for the Motorola Moto G60 (reported codename: `hanoip`).

This directory is designed to become the root of a separate device repository, keeping device-specific code and documentation separate from common XNU research in `iDroid-G60`.

## Status

**Research scaffold only — not bootable.** No real Moto G60 driver is implemented or verified by this scaffold. A driver is only marked working after it communicates with the actual target hardware and has reproducible test evidence.

## Scope

- Identify the exact board revision, SoC peripherals, controllers, sensors and firmware dependencies.
- Maintain device-specific configuration and hardware evidence.
- Develop native, hardware-specific driver implementations against documented kernel interfaces.
- Keep proprietary firmware out of source control unless redistribution is explicitly permitted.
- Keep Bluetooth disabled in the initial scope.

## Layout

- `device.yaml`: conservative device manifest; unknown values stay unknown.
- `DRIVER_MATRIX.md`: status and evidence for each subsystem.
- `drivers/`: real device-specific driver implementations, once supported by evidence.
- `docs/HARDWARE_INVENTORY.md`: source-backed hardware identification.
- `docs/PORTING_TO_ANOTHER_DEVICE.md`: workflow for adapting this project to another phone.
- `tests/`: reproducible build and hardware test plans.

## Status vocabulary

- `not-started`: no implementation work.
- `researching`: hardware or interface investigation in progress.
- `implemented-unverified`: code exists but has not been proven on the Moto G60.
- `partial`: some documented functionality works, with limitations.
- `working`: reproducible tests demonstrate the stated functionality on the target device.
- `blocked`: a documented dependency prevents progress.
- `disabled`: intentionally excluded from project scope.

Never use `working` for a stub, mock, compile-only test, or emulator-only result.

## Relationship to iDroid-G60

The common XNU/kernel research belongs in the main `iDroid-G60` repository. This port contains Moto G60-specific configuration, hardware research, drivers and tests. Record the exact upstream commit or interface revision used when integrating common code.

## Safety and licensing

Do not commit device secrets, private keys, user data, or proprietary firmware without redistribution permission. Do not distribute unverified flashable images. Physical-device experiments require a tested recovery plan.
