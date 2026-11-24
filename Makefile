SHELL := /bin/sh

BUILD_DIR ?= build
PYTHON ?= python3
CLANG ?= clang
LLD ?= ld.lld
QEMU ?= qemu-system-aarch64

TARGET := --target=aarch64-none-elf
ARCH_FLAGS := -mcpu=cortex-a57 -mgeneral-regs-only
COMMON_FLAGS := $(TARGET) $(ARCH_FLAGS) -ffreestanding -fno-builtin \
	-fno-stack-protector -fno-pic -fno-unwind-tables \
	-fno-asynchronous-unwind-tables -Wall -Wextra -Werror -O2 -g
C_FLAGS := $(COMMON_FLAGS) -std=c11
ASM_FLAGS := $(COMMON_FLAGS)
ELF := $(BUILD_DIR)/idroid-qemu.elf

.PHONY: all help check arm64 qemu clean

all: check arm64

help:
	@echo "iDroid-G60 development targets:"
	@echo "  make check   - validate required project files"
	@echo "  make arm64   - compile the freestanding ARM64 QEMU test payload"
	@echo "  make qemu    - run the test payload on QEMU's generic virt machine"
	@echo "  make clean   - remove generated build output"

check:
	$(PYTHON) tools/validate_repo.py

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/start.o: boot/qemu-arm64/start.S | $(BUILD_DIR)
	$(CLANG) $(ASM_FLAGS) -c $< -o $@

$(BUILD_DIR)/main.o: kernel/bringup/main.c | $(BUILD_DIR)
	$(CLANG) $(C_FLAGS) -c $< -o $@

$(ELF): $(BUILD_DIR)/start.o $(BUILD_DIR)/main.o boot/qemu-arm64/linker.ld
	$(LLD) -T boot/qemu-arm64/linker.ld -nostdlib -static \
		-o $@ $(BUILD_DIR)/start.o $(BUILD_DIR)/main.o

arm64: $(ELF)
	@echo "Built $<"
	@file $<

qemu: arm64
	$(QEMU) -machine virt -cpu cortex-a57 -m 256M \
		-nographic -monitor none -serial stdio -no-reboot \
		-kernel $(ELF)

clean:
	rm -rf $(BUILD_DIR)
