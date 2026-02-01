# Quick Start Guide - H2O AutoML with XGBoost (Docker)

## Prerequisites Check

Before starting, verify you have:

- [ ] Docker Desktop installed
- [ ] WSL2 backend enabled (Windows)
- [ ] NVIDIA GPU drivers installed (run `nvidia-smi` in PowerShell)
- [ ] NVIDIA Container Toolkit installed

## Step 1: Install NVIDIA Container Toolkit

Open WSL2 terminal:

```bash
wsl
```

Then run:

```bash
# Add NVIDIA repository
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Install nvidia-container-toolkit
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

# Restart Docker
sudo systemctl restart docker
```

## Step 2: Test GPU in Docker

```bash
# Test GPU access
docker run --rm --gpus all nvidia/cuda:12.0-base nvidia-smi
```

**Expected**: You should see your RTX 4060 GPU listed.

## Step 3: Build H2O Container

Navigate to project directory in PowerShell:

```powershell
cd D:\Project\DBM_FINAL
```

Build the Docker image (takes 5-10 minutes):

```powershell
docker-compose build
```

## Step 4: Start Container

```powershell
docker-compose up
```

**You should see**:
```
Starting H2O with XGBoost and GPU support
...
GPU Status: NVIDIA GeForce RTX 4060...
...
H2O started with PID: xxx
...
Access Jupyter at: http://localhost:8888
Access H2O Flow at: http://localhost:54321
```

## Step 5: Verify XGBoost

In a **new PowerShell terminal** (keep container running):

```powershell
cd D:\Project\DBM_FINAL
docker-compose exec h2o-xgboost python /workspace/project/utils/docker_test_xgboost.py
```

**Expected Output**:
```
H2OXGBoostEstimator: AVAILABLE ✓
XGBoost training: SUCCESS ✓
RESULT: H2O XGBoost is WORKING in Docker! ✓
```

## Step 6: Access Jupyter

1. Open browser: **http://localhost:8888**
2. Navigate to: `Prj_DBM_AutoML.ipynb`
3. Click "Run" → "Run All Cells"

The notebook will:
- Load data from `data/` folder
- Train 3 baseline models
- Run AutoML (5 hours max)
  - Run 1: 25 diverse models (GLM, DRF, DL)
  - Run 2: 25 XGBoost models with GPU
- Export results to `data/model_logs_*.csv`

## Step 7: Monitor Training

### Option A: Jupyter Output
Watch the notebook cells for progress updates.

### Option B: H2O Flow
Open **http://localhost:54321** to see H2O Flow dashboard.

### Option C: GPU Utilization
In PowerShell:
```powershell
watch -n 1 nvidia-smi
```

## Step 8: Stop Container

When training is complete:

```powershell
# Stop container
docker-compose down
```

## Troubleshooting

### Issue: Port already in use

**Error**: `Bind for 0.0.0.0:54321 failed: port is already allocated`

**Fix**: Edit `docker-compose.yml` and change ports:
```yaml
ports:
  - "55555:54321"  # Change left side only
  - "9999:8888"    # Change left side only
```

### Issue: GPU not detected

**Check 1**: Verify GPU in host
```powershell
nvidia-smi
```

**Check 2**: Verify GPU in container
```powershell
docker-compose exec h2o-xgboost nvidia-smi
```

**Check 3**: Verify Docker runtime
```bash
wsl
docker info | grep nvidia
```

Should show: `Runtimes: nvidia`

### Issue: Out of memory

**Error**: Java heap space error

**Fix**: Edit `docker/start.sh`, reduce H2O memory:
```bash
java -Xmx3g \  # Reduce from 4g to 3g
```

### Issue: XGBoost not found

**Verify**: You're using Docker, not local Python
```powershell
# Should show H2O container
docker-compose ps
```

If container not running, start it:
```powershell
docker-compose up -d
```

## Expected Results

After 5 hours of training, you'll have:

### Files Generated
- `data/model_logs_baseline_YYYYMMDD_HHMMSS.csv` (3 models)
- `data/model_logs_diverse_YYYYMMDD_HHMMSS.csv` (25 models)
- `data/model_logs_xgboost_YYYYMMDD_HHMMSS.csv` (25 models)
- `data/model_logs_dual_automl_YYYYMMDD_HHMMSS.csv` (all models)

### Performance Metrics
Each file contains:
- AUC, Accuracy, F1 Score
- Precision, Recall, LogLoss
- Model type, rank, timestamp

## Next Steps

1. Review `data/model_logs_dual_automl_*.csv` for best model
2. Check top XGBoost model performance
3. Compare with baseline models
4. Use best model for predictions

## Useful Commands

```powershell
# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Stop container
docker-compose down

# Rebuild after changes
docker-compose build --no-cache

# Remove all Docker data (clean slate)
docker-compose down -v
```

## Questions?

Check:
1. `README.md` - Full documentation
2. `agents.md` - Development log
3. H2O Flow: http://localhost:54321
