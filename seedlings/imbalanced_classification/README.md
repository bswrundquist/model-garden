# imbalanced_classification

Tackles class imbalance head-on with a systematic comparison of six strategies:
no handling, class weights, SMOTE, ADASYN, random undersampling, and SMOTEENN.
Uses CatBoost as the base learner (configurable) with Optuna tuning. Focuses on
PR-AUC as the primary metric, with full threshold analysis and SHAP explanations
for the best strategy.

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
| `target_col` | `"target"` | Target column name |
| `positive_label` | `null` | Recode this value to 1; null → use as-is |
| `imbalance_ratio` | `0.05` | Positive class ratio for synthetic data |
| `test_size` | `0.2` | Fraction held out for evaluation |
| `random_state` | `42` | Random seed |
| `base_model` | `"catboost"` | Base learner: catboost, xgboost, lgbm |
| `optuna_n_trials` | `20` | Optuna trials per strategy |
| `optimize_metric` | `"f1"` | Metric to optimize: f1, precision, recall |
| `threshold_grid` | `[0.05..0.95]` | Thresholds to evaluate |
| `enable_shap` | `true` | Compute SHAP for best strategy |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |
| `model_output_path` | `"outputs/models/model_best.cbm"` | Model output |

When `feature_paths` is empty, a synthetic imbalanced dataset is generated using sklearn's `make_classification` with the specified `imbalance_ratio`.

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
├── models/     # Best trained model
└── metrics/    # JSON metrics
```
