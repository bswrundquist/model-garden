# model-garden root Makefile
#
# Lifecycle stages (only seedlings/ implemented now):
#   seedlings/    — experimental notebooks, self-contained per model
#   saplings/     — (future) validated models with basic tests
#   greenhouse/   — (future) models with CI, packaging, versioning
#   orchard/      — (future) production-ready, deployed models

.PHONY: seedlings help

help: ## Show this help
	@grep -E '^[a-zA-Z_%-]+:.*##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*##"}; {printf "  \033[36m%-35s\033[0m %s\n", $$1, $$2}'

seedlings: ## List available seedlings
	@echo "Available seedlings:"
	@ls -1 seedlings/ 2>/dev/null | while read d; do echo "  $$d"; done

# ---------------------------------------------------------------------------
# Forward targets into individual seedling Makefiles.
#
# Usage:
#   make seedling-<name>-run-local
#   make seedling-<name>-run-docker
#   make seedling-<name>-run-notebook
#
# Example:
#   make seedling-classification_catboost-run-local
# ---------------------------------------------------------------------------

seedling-%-run-local: ## Run a seedling locally via papermill
	$(MAKE) -C seedlings/$* run-local

seedling-%-run-docker: ## Run a seedling inside Docker
	$(MAKE) -C seedlings/$* run-docker

seedling-%-run-notebook: ## Launch interactive notebook for a seedling
	$(MAKE) -C seedlings/$* run-notebook
