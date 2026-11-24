/*
 * iDroid-G60 ARM64 bring-up experiment.
 *
 * Prints a marker through the PL011 UART used by QEMU's generic virt
 * machine. This does not contain XNU and does not demonstrate Moto G60
 * hardware support.
 */

#include <stdint.h>

#define PL011_BASE 0x09000000UL
#define UART_DR (*(volatile uint32_t *)(PL011_BASE + 0x00))
#define UART_FR (*(volatile uint32_t *)(PL011_BASE + 0x18))
#define UART_IBRD (*(volatile uint32_t *)(PL011_BASE + 0x24))
#define UART_FBRD (*(volatile uint32_t *)(PL011_BASE + 0x28))
#define UART_LCR_H (*(volatile uint32_t *)(PL011_BASE + 0x2c))
#define UART_CR (*(volatile uint32_t *)(PL011_BASE + 0x30))
#define UART_ICR (*(volatile uint32_t *)(PL011_BASE + 0x44))

static void uart_init(void)
{
    UART_CR = 0;
    UART_ICR = 0x7ff;
    UART_IBRD = 13;
    UART_FBRD = 1;
    UART_LCR_H = (3U << 5) | (1U << 4);
    UART_CR = (1U << 9) | (1U << 8) | 1U;
}

static void uart_putc(char value)
{
    while ((UART_FR & (1U << 5)) != 0U) {
        /* Wait until the transmit FIFO has space. */
    }
    UART_DR = (uint32_t)value;
}

static void uart_write(const char *text)
{
    while (*text != '\0') {
        if (*text == '\n') {
            uart_putc('\r');
        }
        uart_putc(*text);
        ++text;
    }
}

void kernel_main(void)
{
    uart_init();
    uart_write("\niDroid-G60 ARM64 QEMU bring-up: PASS\n");
    uart_write("This is a minimal freestanding test payload, not XNU.\n");
    uart_write("Next: validate the XNU platform requirements.\n");
}
