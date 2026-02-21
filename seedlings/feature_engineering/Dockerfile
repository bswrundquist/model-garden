FROM python:3.11-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /work

# Put venv outside /work so volume mounts don't hide it
ENV UV_PROJECT_ENVIRONMENT=/opt/venv

# Copy seedling contents
COPY pyproject.toml ./
COPY notebooks/ ./notebooks/

# Install dependencies
RUN uv sync

# Create output dirs
RUN mkdir -p outputs/runs outputs/plots outputs/metrics outputs/features
