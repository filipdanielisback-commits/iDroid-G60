/*
 * Minimal AArch64 entry point for the QEMU bring-up experiment.
 *
 * This is an educational test payload, not an XNU entry point or phone
 * bootloader. QEMU supplies the execution environment.
 */

.section .text.boot, "ax"
.align 4
.global _start
.type _start, %function

_start:
    msr     daifset, #0xf
    ldr     x0, =__stack_top
    mov     sp, x0
    mov     x29, xzr
    bl      kernel_main

1:
    wfe
    b       1b

.size _start, . - _start
