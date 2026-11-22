# Next step: XNU baseline and compatibility audit

Status: research plan; no kernel build or device boot has been completed.

## Target

- Device: Motorola Moto G60 XT2135-2
- Codename: hanoip
- SoC family: Qualcomm SM7150-AC / Snapdragon 732G
- Android reference build: S2RIS32.32-20-9-9-2-3
- Bluetooth: intentionally out of scope

## What the upstream evidence currently says

HakiOS documents a boot chain consisting of the phone's existing bootloader, a UEFI or U-Boot stage, its EFI loader, a patched XNU kernel with device drivers, then launchd and a separately supplied Darwin user space.

Its public documentation describes:
- an open-kernel QEMU path that does not require Apple's system image;
- a separate user-space path assembled from a user-supplied restore image;
- per-device and per-SoC configuration, with device drivers enabled selectively.

The public HakiOS device directory currently lists:
- `sweet`: SM7150, Darwin 22.6.0;
- `redwood`: SM7325, Darwin 16.5;
- `hanoip`: appears in the codename index, but no verified completed Moto G60 build details were found in the listing.

These are leads, not proof that a HakiOS image or its drivers will work on XT2135-2. In particular, the SM7150 `sweet` port is a comparison target, not a drop-in device port.

## XNU baseline decision: not pinned yet

Do not pin `xnu-12377.121.6` solely because it appears in third-party project discussion or documentation. Before choosing a base, verify all of the following against Apple's official source:
1. The exact tag or commit exists in Apple's XNU source repository.
2. The tag's build configuration and supported architecture match the intended target.
3. HakiOS's patch set applies to that exact revision, or document every required adaptation independently.
4. Kernel headers, SDK interfaces, libraries and user-space expectations are version-matched.
5. All imported source files retain required copyright notices and comply with their own licences.

Until this audit is complete, the kernel baseline is recorded as **unselected**.

## Work sequence

### Phase 1 — source and build audit
- Inspect Apple's official XNU repository and release tags.
- Record candidate tags, commit hashes, source licences and build dependencies.
- Inspect HakiOS's published build documentation for architecture and version assumptions without copying its source or patches.
- Produce a compatibility matrix for candidate XNU revisions and Darwin user-space versions.

### Phase 2 — independent open-kernel build
- Create our own minimal build configuration using only appropriately licensed public source.
- Aim first for a reproducible build artifact and build log.
- Keep all Apple proprietary system images, private headers, signing material, and vendor firmware out of the public repository.
- Record failures accurately; a successful compiler exit is not evidence of a boot.

### Phase 3 — emulator validation
- Establish an open-source-only QEMU test path, if the selected XNU baseline and available platform support permit it.
- Verify kernel entry, early console/log output, memory setup, and a controlled shutdown.
- Do not require or include a proprietary Apple system image for this milestone.

### Phase 4 — Moto G60 feasibility
- Compare the SM7150 `sweet` reference with the XT2135-2 hardware inventory.
- Identify board-level differences, boot firmware requirements, memory map, interrupt controller, storage, display and input interfaces.
- Keep each unknown marked unknown until supported by device-specific evidence.
- Do not flash, repartition, or modify the phone as part of this research milestone.

## Evidence required before claiming progress

| Milestone | Required evidence |
|---|---|
| Source baseline selected | Official Apple tag/commit, licence and dependency record |
| Kernel builds | Reproducible build log and artifact metadata |
| QEMU kernel boot | Captured console log showing kernel entry and successful early initialization |
| Device boot | Device-specific logs and repeatable boot evidence |
| Driver works | Test evidence from the actual XT2135-2 hardware |

## Upstream references

- Apple XNU: https://github.com/apple-oss-distributions/xnu
- Apple Open Source: https://opensource.apple.com/
- HakiOS boot architecture: https://hackios-web.vercel.app/en/guide/how-it-works
- HakiOS build instructions: https://hackios-web.vercel.app/en/docs/getting-started/building
- HakiOS device directory: https://hakios-developers.com/
- HakiOS FAQ: https://hackios-web.vercel.app/en/faq

## Scope and honesty

This project is an independent XNU/Darwin research port. A kernel boot or a Darwin user-space boot does not by itself establish that the complete, unmodified proprietary iOS product is running. Do not call a build genuine iOS unless the exact Apple components and their operation have been independently verified.
