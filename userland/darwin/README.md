# Darwin user-space boundary

The future Darwin user-space experiment is separate from the XNU kernel and
loader. This directory intentionally contains no Apple system files, restore
images, firmware, keys, or prebuilt proprietary binaries.

HakiOS documents a QEMU path that uses a Darwin 16.5 user space assembled
locally by the user from a compatible restore image. Its documentation also
states that Apple's activation, Apple ID, iCloud, and App Store services are
not supported. See:

- https://hackios-web.vercel.app/en/docs
- https://hackios-web.vercel.app/en/docs/getting-started/qemu

## Planned engineering tasks

1. Specify the expected image layout and filesystem format.
2. Define a local-only input interface for files the user is entitled to use.
3. Keep unpacking/build outputs outside Git and add ignore rules before any
   image-building implementation.
4. Validate the resulting image structure without publishing its contents.
5. Start with a minimal user-space handoff; graphical services come later.

No restore-image download, decryption bypass, activation workaround, or
proprietary file redistribution is part of this project. A successful XNU
boot does not by itself mean that Darwin user space or a graphical desktop
has started.
