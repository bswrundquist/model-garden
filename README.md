# Model Garden

A structured ML experimentation framework that organizes machine learning projects into lifecycle stages, from early-stage notebooks to production-ready models.

## Lifecycle Stages

| Stage | Description | Status |
|-------|-------------|--------|
| **Seedlings** | Self-contained experimental notebooks | Active |
| **Saplings** | Validated models with basic tests | Planned |
| **Greenhouse** | Models with CI, packaging, and versioning | Planned |
| **Orchard** | Production-ready, deployed models | Planned |

## Seedlings

Each seedling is a standalone ML project with its own dependencies, Dockerfile, and parameterized notebook. They can run locally, in Docker, or interactively via Jupyter.

### feature_engineering

Feature engineering and selection pipeline. Takes a raw dataset and produces a curated feature set with quality metrics, selection rankings, and diagnostic plots. Includes data quality audits, univariate scoring, interaction feature generation, target encoding, permutation importance, and leakage/drift detection.

### classification_catboost

Binary classification using CatBoost with Optuna hyperparameter tuning. Includes threshold optimization, SHAP explanations, and a full suite of evaluation plots (ROC, precision-recall, calibration, cumulative gains, lift charts). Supports entity-aware train/test splitting to prevent data leakage.

### regression_catboost

CatBoost regression with Optuna hyperparameter tuning. Produces residual analysis, predicted-vs-actual plots, and SHAP explanations. Supports optimization against RMSE, MAE, R2, or MAPE.

## Running a Seedling

All seedlings follow the same interface:

```bash
# Run notebook locally via papermill
make seedling-<name>-run-local

# Run inside Docker
make seedling-<name>-run-docker

# Launch interactive Jupyter server
make seedling-<name>-run-notebook
```

Or from within a seedling directory:

```bash
cd seedlings/classification_catboost
make run-local
```

Each notebook is parameterized with [Papermill](https://papermill.readthedocs.io/). Parameters like input paths, target column, number of Optuna trials, and which metrics to optimize are configurable at runtime. When no input data is provided, synthetic data is generated so notebooks can run out of the box.

## Outputs

Each seedling writes to a standard output structure:

```
outputs/
  runs/       # Executed notebooks + HTML reports
  plots/      # Visualizations (PNG)
  models/     # Serialized model artifacts (.cbm)
  metrics/    # Structured metrics (JSON)
  features/   # Transformed feature sets (parquet)
```

## Tech Stack

- **Python 3.11** with [uv](https://github.com/astral-sh/uv) for dependency management
- **Polars** for dataframe operations
- **CatBoost** for gradient boosting
- **Optuna** for hyperparameter optimization
- **SHAP** for model explainability
- **Papermill** for notebook parameterization and execution
- **Docker** for reproducible environments
- **GitHub Actions** for automated image builds to GHCR

## CI/CD

On pushes to `main`, changed seedlings are automatically built as Docker images and published to GitHub Container Registry. Each image is tagged by commit SHA and `latest`.
