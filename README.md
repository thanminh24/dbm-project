# H2O AutoML Project with XGBoost (Docker)

This project uses **H2O AutoML with XGBoost** for student performance prediction using the OULAD dataset.

## 🐳 Running with Docker (Recommended for XGBoost)

XGBoost is **only available** in the official H2O Docker images. The pip installation doesn't include XGBoost on Windows.

### Prerequisites

1. **Docker Desktop** with WSL2 backend
2. **NVIDIA Container Toolkit** (for GPU support)

#### Install NVIDIA Container Toolkit (WSL2)

```bash
wsl
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

### Quick Start

```bash
# Build the Docker image
docker-compose build

# Start H2O + Jupyter
docker-compose up

# Access:
# - Jupyter Notebook: http://localhost:8888
# - H2O Flow: http://localhost:54321
```

### Test XGBoost Availability

```bash
# In another terminal while container is running:
docker-compose exec h2o-xgboost python /workspace/project/utils/docker_test_xgboost.py
```

### Run AutoML Notebook

1. Open Jupyter: http://localhost:8888
2. Navigate to `Prj_DBM_AutoML.ipynb`
3. Run all cells

The container automatically:
- Loads your data from `data/` folder
- Enables GPU for XGBoost
- Saves logs to `h2o_logs/`
- Exports results to `data/model_logs_*.csv`

### Stop Container

```bash
docker-compose down
```

## 📁 Project Structure

```
D:\Project\DBM_FINAL\
├── Dockerfile                 # H2O with XGBoost image
├── docker-compose.yml         # GPU-enabled orchestration
├── docker/
│   └── start.sh              # Container startup script
├── data/                      # CSV datasets and results
├── utils/                     # Python utility scripts
├── h2o_logs/                  # H2O runtime logs
├── Prj_DBM_AutoML.ipynb      # Main AutoML notebook
└── README.md                  # This file
```

## 🎯 Dual AutoML Strategy

- **Run 1**: Diverse models (GLM, DRF, DeepLearning) - 2.5 hours
- **Run 2**: GBM-focused with GPU - 2.5 hours
- **Total**: 50+ models, 5 hours

## 📊 GPU Support

- **Your GPU**: NVIDIA GeForce RTX 4060 (8GB)
- **CUDA Version**: 13.1 (compatible)
- **Status**: Enabled via Docker GPU passthrough

## 🔧 Troubleshooting

### GPU not detected in container

```bash
# Verify GPU in container
docker-compose exec h2o-xgboost nvidia-smi
```

### Port conflicts

If ports 54321 or 8888 are in use, edit `docker-compose.yml`:

```yaml
ports:
  - "55555:54321"  # Change host port
  - "9999:8888"    # Change host port
```

### Container won't start

Check Docker logs:

```bash
docker-compose logs -f
```

## 📝 Notes

- Container requires ~6GB RAM for H2O + XGBoost
- GPU memory usage: ~1-2GB during XGBoost training
- Data folder is mounted read-only for safety
- H2O logs are persisted in `h2o_logs/`
