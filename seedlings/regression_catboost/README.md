# regression_catboost

CatBoost regression seedling with Optuna hyperparameter tuning.

## Quick start

```bash
# Launch interactive notebook
make run-notebook

# Execute end-to-end locally (synthetic data by default)
make run-local

# Execute inside Docker
make run-docker
```

## Targets

| Target | Description |
|---|---|
| `run-notebook` | Jupyter server on port 8888 (no token) |
| `run-local` | Papermill execution via `uv run` |
| `run-docker` | Build image, run notebook in container |

## Parameters

Key papermill parameters (override with `-p key value`):

| Parameter | Default | Description |
|---|---|---|
| `feature_paths` | `[]` | List of parquet/csv paths (local or gs://) |
| `target_col` | `"target"` | Name of the target column |
| `test_size` | `0.2` | Train/test split ratio |
| `optuna_n_trials` | `30` | Number of Optuna trials |
| `optimize_metric` | `"rmse"` | Metric to optimize (rmse, mae, r2, mape) |
| `enable_shap` | `True` | Compute SHAP values |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |
| `model_output_path` | `"outputs/models/model.cbm"` | Model output |

When `feature_paths` is empty, a synthetic dataset is generated automatically.

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
├── models/     # Trained model files (.cbm)
└── metrics/    # JSON metrics
```
