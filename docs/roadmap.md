# Roadmap

## Milestone 001 — Repository and research foundation

- [x] Establish project overview and repository conventions.
- [x] Add initial documentation structure.
- [x] Add hardware inventory with explicit unknowns.
- [x] Add a lightweight repository validation script.
- [ ] Review setup instructions on Windows/WSL2 and native Ubuntu.
- [ ] Verify all hardware claims against primary sources.
- [ ] Decide component licensing after legal and compatibility review.

## Milestone 002 — ARM64 emulation research

- [x] Add a freestanding ARM64 payload and reproducible build target.
- [x] Document the QEMU virt experiment and its limitations.
- [ ] Confirm the QEMU runtime test in CI and retain its serial log.
- [ ] Record host and toolchain versions.
- [ ] Capture a reproducible runtime result.

## Milestone 003 — XNU feasibility and source baseline

- [x] Identify HakiOS's documented XNU reference tag: xnu-8796.121.2.
- [x] Document the upstream-source boundary and license-preservation rules.
- [x] Add a local checker for a pristine upstream XNU checkout.
- [ ] Review upstream XNU ARM64 build targets and dependencies.
- [ ] Identify the platform code needed for QEMU virt.
- [ ] Define a patch policy and keep project changes separate from upstream.
- [ ] Build XNU only after the platform and toolchain review.

## Milestone 004 — QEMU XNU loader and kernel boot

- [x] Document the intended UEFI -> loader -> XNU architecture.
- [ ] Specify the loader-to-kernel entry contract and memory map.
- [ ] Implement an independent QEMU loader.
- [ ] Add the QEMU platform layer and required virtual-device support.
- [ ] Build XNU for the QEMU target.
- [ ] Boot XNU in QEMU and capture a serial log.

## Milestone 005 — Darwin user space and graphical boot

- [x] Document the separate, user-supplied Darwin image boundary.
- [ ] Define a local-only image layout and validation workflow.
- [ ] Start the Darwin user-space process handoff.
- [ ] Validate essential user-space services.
- [ ] Add display support and graphical services.
- [ ] Demonstrate a graphical Darwin user-space boot in QEMU.

## Milestone 006 — Moto G60 platform feasibility

- [ ] Verify exact device variant and board revision.
- [ ] Build a source-backed hardware inventory.
- [ ] Map documented boot and hardware interfaces.
- [ ] Review recovery and device-safety constraints before any physical-device work.
- [ ] Reassess XNU platform fit after QEMU milestones are demonstrated.

## Later milestones

Driver implementation and any physical-device experiments remain blocked on
the feasibility work above. QEMU success does not prove Moto G60 compatibility.
No release date or bootability promise is made.
