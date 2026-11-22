# Test plan

Tests are divided into three categories:

1. **Static/build tests:** validate manifests, source formatting, compilation and interface contracts.
2. **Emulator tests:** validate portable code and generic ARM64 behavior. These do not establish Moto G60 hardware support.
3. **Physical-device tests:** verify real hardware communication on the exact Moto G60 variant, with a recovery plan and non-destructive test data.

Every test report should include:
- Device model and board revision (omit serial numbers and other identifiers).
- Source commit and build configuration.
- Exact test steps and expected result.
- Actual result and logs with personal data removed.
- Known limitations and whether the result is reproducible.

Do not perform destructive storage, boot-chain or firmware tests as an initial validation step. Never label a driver working based only on a successful build.
