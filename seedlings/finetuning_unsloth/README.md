# finetuning_unsloth

LLM fine-tuning seedling using Unsloth and QLoRA. Fine-tunes Gemma 3 4B IT on
the Alpaca instruction dataset by default.

## Quick start

```bash
# Launch interactive notebook
make run-notebook

# Execute end-to-end locally (requires GPU)
make run-local

# Execute inside Docker (requires NVIDIA GPU + nvidia-container-toolkit)
make run-docker
```

## Targets

| Target | Description |
|---|---|
| `run-notebook` | Jupyter server on port 8888 (no token) |
| `run-local` | Papermill execution via `uv run` |
| `run-docker` | Build image, run notebook in container (`--gpus all`) |

## Parameters

Key papermill parameters (override with `-p key value`):

| Parameter | Default | Description |
|---|---|---|
| `model_name` | `"unsloth/gemma-3-4b-it"` | Hugging Face model ID |
| `dataset_name` | `"yahma/alpaca-cleaned"` | Hugging Face dataset ID |
| `max_seq_length` | `2048` | Maximum sequence length |
| `load_in_4bit` | `True` | Enable 4-bit quantization |
| `lora_r` | `16` | LoRA rank |
| `lora_alpha` | `32` | LoRA alpha scaling factor |
| `max_steps` | `60` | Training steps (quick demo) |
| `learning_rate` | `2e-4` | Peak learning rate |
| `dataset_sample_size` | `1000` | Subsample dataset size |
| `save_merged_model` | `True` | Save merged 16-bit model |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |
| `model_output_path` | `"outputs/models/lora_adapter"` | LoRA adapter output |

## Requirements

- **GPU required.** Fine-tuning runs on CUDA-capable GPUs.
- For Docker: NVIDIA Container Toolkit (`nvidia-container-toolkit`) must be installed.
- The 4-bit quantized Gemma 3 4B model fits in ~6 GB VRAM.

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Training loss, token distribution, eval charts
├── models/     # LoRA adapters and optional merged model
└── metrics/    # JSON metrics
```
