# seedlings/finetuning_unsloth/Makefile

SEEDLING     := finetuning_unsloth
NOTEBOOK_IN  := notebooks/001_finetuning_unsloth.ipynb
TIMESTAMP    := $(shell date +%Y%m%d_%H%M%S)
NOTEBOOK_OUT := outputs/runs/$(TIMESTAMP)_executed.ipynb
HTML_OUT     := outputs/runs/$(TIMESTAMP)_executed.html
DOCKER_TAG   := model-garden-seedling-finetuning-unsloth

OUTPUT_DIRS  := outputs outputs/runs outputs/plots outputs/models outputs/metrics

.PHONY: run-local run-docker run-notebook dirs help

help: ## Show targets (GPU required for run-local and run-docker)
	@grep -E '^[a-zA-Z_%-]+:.*##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*##"}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

dirs: ## Create output directories
	@mkdir -p $(OUTPUT_DIRS)

run-local: dirs ## Execute notebook via papermill (uv run) — requires GPU
	uv run papermill $(NOTEBOOK_IN) $(NOTEBOOK_OUT) \
		-p executed_notebook_path "$(NOTEBOOK_OUT)"
	uv run jupyter nbconvert --to html --no-input $(NOTEBOOK_OUT) --output-dir outputs/runs
	@echo ""
	@echo "Executed notebook saved to $(NOTEBOOK_OUT)"
	@echo "HTML report saved to $(HTML_OUT)"
	open $(HTML_OUT)

run-docker: dirs ## Build & run notebook in Docker (outputs mounted) — requires GPU
	docker build -t $(DOCKER_TAG) .
	docker run --rm \
		--gpus all \
		--shm-size=4g \
		-v $(CURDIR):/work \
		-w /work \
		$(DOCKER_TAG) \
		sh -c 'uv run papermill $(NOTEBOOK_IN) $(NOTEBOOK_OUT) \
			-p executed_notebook_path "$(NOTEBOOK_OUT)" \
			&& uv run jupyter nbconvert --to html --no-input $(NOTEBOOK_OUT) --output-dir outputs/runs'
	@echo ""
	@echo "Docker run complete. Outputs are in outputs/"

run-notebook: dirs ## Launch interactive Jupyter notebook server
	uv run --with jupyter jupyter notebook \
		--NotebookApp.token='' \
		--ip=0.0.0.0 \
		--port=8888
