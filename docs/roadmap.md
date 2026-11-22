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

- [ ] Record host and toolchain versions.
- [ ] Confirm QEMU ARM64 `virt` environment setup.
- [ ] Build and run a tiny non-OS ARM64 test payload or a suitable educational kernel exercise.
- [ ] Capture logs and reproducible test steps.
- [ ] Document what this proves and what it does not prove about XNU.

## Milestone 003 — XNU feasibility study

- [ ] Review upstream XNU build targets and supported platforms.
- [ ] Document required platform abstractions.
- [ ] Identify an appropriate research branch and patch policy.
- [ ] Do not claim a successful build until logs and artifacts are reviewed.

## Milestone 004 — Moto G60 platform feasibility

- [ ] Verify exact device variant and board revision.
- [ ] Build a source-backed hardware inventory.
- [ ] Map documented boot and hardware interfaces.
- [ ] Review recovery and device-safety constraints before any physical-device work.

## Later milestones

Driver implementation, userland, and any physical-device experiments remain blocked on the feasibility work above. No release date or bootability promise is made.
