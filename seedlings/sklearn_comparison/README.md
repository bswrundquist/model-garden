# sklearn_comparison

Head-to-head comparison of XGBoost, Random Forest, Logistic Regression, and
sklearn's HistGradientBoostingClassifier for binary classification. Covers
the full spectrum from linear baselines to modern gradient boosting, with
hyperparameter tuning, threshold optimization, feature importance, SHAP
explanations, and practical deployment considerations.

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
| `optuna_n_trials` | `20` | Number of Optuna trials per model |
| `optimize_metric` | `"f1"` | Metric to optimize (f1, precision, recall) |
| `enable_shap` | `True` | Compute SHAP values |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |

When `feature_paths` is empty, a synthetic dataset with both numeric and
categorical features is generated automatically.

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
├── models/     # Trained model files (.ubj, .joblib)
└── metrics/    # JSON metrics
```
