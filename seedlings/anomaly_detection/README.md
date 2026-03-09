# anomaly_detection

Unsupervised anomaly detection comparison: Isolation Forest, Local Outlier Factor
(LOF), One-Class SVM, and Elliptic Envelope — all from scikit-learn. Covers
contamination tuning, ROC-AUC/PR-AUC evaluation (using injected ground truth),
2D decision boundary plots, and a ranked comparison of all methods.

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
| `feature_cols` | `null` | Subset of columns; null → all |
| `label_col` | `null` | Ground-truth anomaly column (1=anomaly); null → unsupervised only |
| `contamination` | `0.05` | Expected fraction of anomalies |
| `test_size` | `0.3` | Fraction held out for evaluation |
| `random_state` | `42` | Random seed |
| `n_synthetic_samples` | `2000` | Inlier count for synthetic data |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |

When `feature_paths` is empty, a synthetic dataset is generated: Gaussian blobs as inliers with uniform random outliers injected at the edges (ground truth labels available).

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
└── metrics/    # JSON metrics
```
