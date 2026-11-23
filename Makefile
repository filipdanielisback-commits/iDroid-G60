# HakiOS / Moto G60 project build entry points.
# These targets prepare and validate the source workflow; they do not claim
# that a Moto G60 kernel can currently be compiled or booted.

.PHONY: help validate fetch-xnu

help:
	@printf '%s\n' \
	  'Available targets:' \
	  '  make validate   Check pinned source metadata and shell syntax' \
	  '  make fetch-xnu  Fetch and verify the pinned Apple XNU source' \
	  '  make help       Show this help'

validate:
	@bash scripts/validate-build-metadata.sh

fetch-xnu: validate
	@bash scripts/fetch-xnu-baseline.sh
