# Moto G60 hardware inventory

This document is the source-of-truth checklist for identifying the exact target hardware. Treat every reported value as provisional until it is tied to the exact model/board revision.

## Device identity

- Retail model number: TODO
- Region / variant: TODO
- Board revision: TODO
- Device codename: `hanoip` (reported; verify)
- SoC: Qualcomm SM7150-AC / Snapdragon 732G (reported; verify)

## Components to identify

| Area | Required facts | Status |
|---|---|---|
| CPU | Core topology, architectural features, timer and interrupt details | unknown |
| Memory | RAM layout, reserved regions, memory map | unknown |
| Boot | Boot chain, firmware interfaces, verified boot constraints | unknown |
| Display | Panel model, display controller, backlight | unknown |
| Touch | Controller, bus, interrupt and reset lines | unknown |
| Storage | eMMC/UFS type, controller and partition layout | unknown |
| GPU | Adreno revision, firmware and userspace/kernel interfaces | unknown |
| Wi-Fi | Chipset, bus, firmware and calibration dependencies | unknown |
| Audio | Codec, DSP, routing and firmware | unknown |
| Cameras | Sensor models, buses, regulators and ISP | unknown |
| Power | Charger, fuel gauge, regulators and thermal sensors | unknown |
| USB | Controller, PHY and supported roles | unknown |
| Haptics | Actuator and controller | unknown |

## Evidence policy

For each discovered fact, record:
- A source URL and the exact file/path or section.
- Whether the source matches the exact retail model and board revision.
- The source's license and whether redistribution is permitted.
- Confidence: verified, strongly supported, reported, or unknown.

Do not copy addresses, GPIOs, interrupts, regulator names or firmware names from a different Snapdragon phone and assume they apply here.

## Data handling

Do not publish serial numbers, IMEIs, Wi-Fi credentials, account identifiers, personal files or other device-owner data in logs or issue reports.
