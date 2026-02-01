#!/bin/bash
set -e

echo "============================================================"
echo "Starting H2O with XGBoost and GPU support"
echo "============================================================"
echo ""
echo "Environment:"
echo "  CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
echo "  NVIDIA_VISIBLE_DEVICES: $NVIDIA_VISIBLE_DEVICES"
echo ""

# Check for GPU
if command -v nvidia-smi &> /dev/null; then
    echo "GPU Status:"
    nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv,noheader
    echo ""
fi

# Start H2O in background
echo "Starting H2O server on port 54321..."
java -Xmx4g \
     -jar /opt/h2oai/h2o-3/h2o.jar \
     -port 54321 \
     -name H2O_AutoML_GPU \
     -log_dir /workspace/project/h2o_logs &

H2O_PID=$!
echo "H2O started with PID: $H2O_PID"

# Wait for H2O to start
echo "Waiting for H2O to initialize..."
sleep 15

# Check if H2O is running
if ps -p $H2O_PID > /dev/null; then
    echo "H2O is running successfully!"
else
    echo "ERROR: H2O failed to start"
    exit 1
fi

# Start Jupyter
echo ""
echo "============================================================"
echo "Starting Jupyter Notebook"
echo "============================================================"
echo "Access Jupyter at: http://localhost:8888"
echo "Access H2O Flow at: http://localhost:54321"
echo "============================================================"
echo ""

jupyter notebook \
  --ip=0.0.0.0 \
  --port=8888 \
  --no-browser \
  --allow-root \
  --NotebookApp.token='' \
  --NotebookApp.password='' \
  --notebook-dir=/workspace/project

# Wait for background process
wait $H2O_PID
