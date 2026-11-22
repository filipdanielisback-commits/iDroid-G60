# Contributing to iDroid-G60

Thanks for your interest. This is an early-stage operating-system research project.

## Ground rules

- Keep changes small, reviewable, and documented.
- Do not claim a driver, boot path, or hardware feature works without repeatable evidence.
- Label uncertain hardware details as `reported`, `hypothesis`, or `unknown`.
- Link primary sources for hardware and kernel claims.
- Do not commit proprietary firmware, device dumps, private keys, credentials, or personal data.
- Keep upstream XNU code and license notices separate from original project code.
- Do not submit code copied from HakiOS or another project. Architectural inspiration is fine; implementations must be independently authored and properly attributed.

## Suggested change flow

1. Open an issue describing the research question or change.
2. Explain the evidence and expected behavior.
3. Add or update tests and documentation.
4. Submit a pull request with a concise summary and limitations.

## Hardware safety

Early work should use source review, static analysis, and emulation. Physical-device experiments are out of scope until there is a reviewed recovery plan and a demonstrably safe, reversible test procedure.
