# model-garden root Makefile
#
# Lifecycle stages (only seedlings/ implemented now):
#   seedlings/    — experimental notebooks, self-contained per model
#   saplings/     — (future) validated models with basic tests
#   greenhouse/   — (future) models with CI, packaging, versioning
#   orchard/      — (future) production-ready, deployed models

# Discover seedlings from directory listing
SEEDLINGS := $(notdir $(wildcard seedlings/*))

.PHONY: help seedlings-list

help: ## Show this help
	@grep -E '^[a-zA-Z_%-]+:.*##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*##"}; {printf "  \033[36m%-45s\033[0m %s\n", $$1, $$2}'

seedlings-list: ## List available seedlings
	@echo "Available seedlings:"
	@ls -1 seedlings/ 2>/dev/null | while read d; do echo "  $$d"; done

# ---------------------------------------------------------------------------
# Forward targets into individual seedling Makefiles.
#
# Usage:
#   make seedlings-<name>-run-local
#   make seedlings-<name>-run-docker
#   make seedlings-<name>-run-notebook
#
# Example:
#   make seedlings-classification_catboost-run-local
# ---------------------------------------------------------------------------

define seedling_rules
.PHONY: seedlings-$(1)-run-local seedlings-$(1)-run-docker seedlings-$(1)-run-notebook

seedlings-$(1)-run-local: ## Run $(1) locally via papermill
	$$(MAKE) -C seedlings/$(1) run-local

seedlings-$(1)-run-docker: ## Run $(1) inside Docker
	$$(MAKE) -C seedlings/$(1) run-docker

seedlings-$(1)-run-notebook: ## Launch interactive notebook for $(1)
	$$(MAKE) -C seedlings/$(1) run-notebook
endef

$(foreach s,$(SEEDLINGS),$(eval $(call seedling_rules,$(s))))
