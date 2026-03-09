# time_series_forecasting

Multi-step time series forecasting with three approaches: a naive moving-average
baseline, SARIMA (statsmodels), and LightGBM trained on lag and rolling-window
features with Optuna tuning. Covers STL decomposition, ACF/PACF analysis,
time-based train/test split, walk-forward evaluation, and forecast visualizations.

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
| `date_col` | `"date"` | Date/timestamp column name |
| `target_col` | `"value"` | Target column name |
| `freq` | `"D"` | Series frequency: D, W, M |
| `forecast_horizon` | `30` | Steps ahead to forecast |
| `n_lags` | `28` | Number of lag features for LightGBM |
| `rolling_windows` | `[7, 14, 28]` | Rolling mean/std window sizes |
| `optuna_n_trials` | `20` | Optuna trials for LightGBM tuning |
| `test_size` | `0.2` | Fraction of data held out for test |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |
| `model_output_path` | `"outputs/models/model.lgb"` | Model output |

When `feature_paths` is empty, a synthetic daily series is generated (3 years, trend + weekly + yearly seasonality + noise).

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
├── models/     # Trained LightGBM model (.lgb)
└── metrics/    # JSON metrics
```
