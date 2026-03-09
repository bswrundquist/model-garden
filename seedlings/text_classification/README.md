# text_classification

Binary (and multi-class) text classification with two complementary approaches:
TF-IDF + Logistic Regression (fast, interpretable, strong baseline) vs.
sentence-transformer embeddings + LightGBM (modern, semantic). Covers synthetic
text generation, preprocessing, cross-validated grid search, top TF-IDF terms,
embedding visualization, and a full metric comparison.

## Quick start

```bash
make run-notebook
make run-local
make run-docker
```

## Targets

| Target | Description |
|---|---|
| `run-notebook` | Jupyter server on port 8888 (no token) |
| `run-local` | Papermill execution via `uv run` |
| `run-docker` | Build image, run notebook in container |

## Parameters

| Parameter | Default | Description |
|---|---|---|
| `feature_paths` | `[]` | List of parquet/csv paths (local or gs://) |
| `text_col` | `"text"` | Column containing raw text |
| `target_col` | `"label"` | Column containing the class label |
| `test_size` | `0.2` | Fraction held out for evaluation |
| `random_state` | `42` | Random seed |
| `tfidf_max_features` | `10000` | Max vocabulary size for TF-IDF |
| `embedding_model` | `"all-MiniLM-L6-v2"` | sentence-transformers model name |
| `embedding_batch_size` | `64` | Batch size for embedding extraction |
| `optuna_n_trials` | `20` | Optuna trials for LightGBM tuning |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |
| `model_output_path` | `"outputs/models/model_lgbm.lgb"` | LightGBM model output |

When `feature_paths` is empty, a synthetic multi-topic text dataset is generated (4 categories: sports, technology, politics, entertainment).

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
├── models/     # Trained LightGBM model (.lgb)
└── metrics/    # JSON metrics
```
