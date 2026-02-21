# feature_engineering

Feature engineering and feature selection seedling for model-garden.

Given an input parquet dataset and a declared target column, this notebook
produces a curated feature set with quality metrics, selection rankings,
engineered features, and a comprehensive suite of diagnostic plots.

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
| `input_parquet_paths` | `[]` | List of parquet paths (local or gs://); empty generates synthetic data |
| `target_col` | `"target"` | Name of the target column |
| `task_type` | `"binary"` | One of: binary, multiclass, regression |
| `id_cols` | `[]` | Entity ID columns (excluded from features) |
| `time_col` | `None` | Datetime column for time-aware features |
| `group_cols` | `[]` | Grouping keys for aggregation features |
| `categorical_cols` | `None` | Explicit categorical columns (None = auto-infer) |
| `numeric_cols` | `None` | Explicit numeric columns (None = auto-infer) |
| `text_cols` | `None` | Text columns for lightweight text features |
| `drop_cols` | `[]` | Columns to always exclude |
| `test_size` | `0.2` | Train/test split ratio |
| `enable_interactions` | `True` | Generate interaction features |
| `enable_group_aggregations` | `True` | Generate group-level aggregation features |
| `enable_time_features` | `True` | Generate time-based features (requires time_col) |
| `enable_target_encoding` | `False` | Cross-validated target encoding |
| `enable_mutual_info` | `True` | Mutual information scoring |
| `enable_permutation_importance` | `True` | Permutation importance via baseline model |
| `enable_shap` | `False` | SHAP values (heavier computation) |
| `enable_stability_checks` | `True` | Feature drift checks across time |
| `baseline_model` | `"logreg"` | Model for importance: logreg or catboost_if_available |
| `output_features_parquet_path` | `"outputs/features/features.parquet"` | Export transformed features |
| `metrics_json_path` | `"outputs/metrics/feature_report.json"` | Metrics JSON output |

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped) + HTML reports
├── plots/      # Saved figures (.png)
├── metrics/    # feature_report.json
└── features/   # features.parquet (transformed feature dataset)
```

## Notebook sections

1. **Overview** — Philosophy, outputs, and how to run
2. **Data loading** — Polars-first parquet loading with GCS support
3. **Type inference** — Column categorization and schema summary
4. **Data quality audit** — Missingness, cardinality, distributions, outliers
5. **Target exploration** — Target distribution, time trends, group breakdowns
6. **Baseline feature scoring** — Correlation, ANOVA, mutual info, univariate AUC, consensus
7. **Feature engineering** — Missingness indicators, transforms, interactions, aggregations, time features, categorical encoding
8. **Model-based feature selection** — L1 selection, permutation importance, stability selection
9. **Leakage & drift checks** — Temporal drift, leakage heuristics
10. **Final recommendations & exports** — Curated feature lists, metrics JSON, parquet export
