# XNU source boundary

This directory documents how iDroid-G60 will work with Apple's open-source
XNU source. The upstream source itself is kept in a separate local checkout;
it is not copied into this repository by the current milestone.

## Reference baseline

HakiOS documents a working port based on Apple's XNU tag xnu-8796.121.2,
associated with Darwin 22.5.0 / the Darwin 16.5 user-space generation. This
is a useful compatibility reference, not proof that the same configuration
or patches are suitable for iDroid-G60.

- Upstream: https://github.com/apple-oss-distributions/xnu
- HakiOS kernel notes: https://github.com/oosexgang/hakios-xnu-kernel/blob/main/xnu/README.md
- HakiOS QEMU architecture: https://hackios-web.vercel.app/en/guide/how-it-works

## Local source checkout

Keep the upstream checkout beside this repository, not inside it:

~~~sh
git clone https://github.com/apple-oss-distributions/xnu.git ../xnu-8796.121.2
git -C ../xnu-8796.121.2 checkout xnu-8796.121.2
make xnu-check XNU_SOURCE=../xnu-8796.121.2
~~~

The check confirms the Git origin, exact tag, expected source directories,
license file, and a clean worktree. It does not download, patch, compile, or
boot XNU.

## Integration rules

1. Keep Apple's source and notices intact.
2. Keep iDroid-G60 changes in a separately reviewed patch series.
3. Record the exact upstream commit/tag and license obligations.
4. Do not assume an existing board configuration is a QEMU virt port.
5. Do not describe XNU as integrated until a reproducible build and boot log
   exist for this repository's own configuration.

The current repository still contains only the small ARM64 QEMU bring-up
payload. No XNU kernel is built here yet.
