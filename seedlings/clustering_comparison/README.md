# clustering_comparison

Head-to-head comparison of five clustering algorithms: K-Means, DBSCAN, HDBSCAN,
Gaussian Mixture Model (GMM), and Agglomerative Clustering. Covers parameter
search, internal validation metrics (Silhouette, Davies-Bouldin, Calinski-Harabasz),
UMAP and PCA 2D visualizations, and a ranked comparison across all methods.

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
| `n_clusters_range` | `[2,3,4,5,6,7,8]` | K values to evaluate for applicable methods |
| `dbscan_eps_range` | `[0.3,0.5,0.7,1.0,1.5]` | eps values to search for DBSCAN |
| `dbscan_min_samples` | `5` | min_samples for DBSCAN/HDBSCAN |
| `random_state` | `42` | Random seed |
| `umap_n_neighbors` | `15` | UMAP n_neighbors |
| `metrics_json_path` | `"outputs/metrics/metrics.json"` | Metrics output |

When `feature_paths` is empty, a synthetic dataset is generated with 5 anisotropic Gaussian clusters (2000 samples, 10 features).

## Outputs

```
outputs/
├── runs/       # Executed notebooks (timestamped)
├── plots/      # Saved figures
└── metrics/    # JSON metrics
```
