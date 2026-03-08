<div align="center">

# OULAD Early-Warning Modeling

### Predicting Student Success Through VLE Engagement

[![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white)](https://jupyter.org)
[![XGBoost](https://img.shields.io/badge/XGBoost-Optuna-017CEE?style=for-the-badge&logo=xgboost&logoColor=white)](https://xgboost.readthedocs.io)
[![H2O](https://img.shields.io/badge/H2O-AutoML-FFC107?style=for-the-badge&logo=h2o&logoColor=black)](https://h2o.ai)
[![License: MIT](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)

**Can we predict whether a student will pass or fail based on their early VLE (Virtual Learning Environment) behavior?**

This project uses the [OULAD dataset](https://analyse.kmi.open.ac.uk/open_dataset) to build an end-to-end ML pipeline that answers this question — from raw data through 8 question-driven EDA checks to a 4-model comparison.

[Getting Started](#-getting-started) · [Pipeline](#-pipeline-overview) · [Models](#-models) · [Results](#-results) · [References](#-references)

</div>

---

## Highlights

- **8 Question-Driven EDA Checks** — distribution separation, dose-response curves, activity composition, timing analysis, confounder context, and more
- **4 Models Compared Fairly** — Logistic Regression, Decision Tree, H2O AutoML, XGBoost + Optuna on the same 80/10/10 split
- **Leakage-Safe Features** — only early, non-leaking signals used for prediction
- **Single Notebook Pipeline** — reproducible end-to-end workflow in one file

## Getting Started

### Prerequisites

| Requirement | Version | Note |
|-------------|---------|------|
| Python | 3.10+ (3.11 recommended) | Core runtime |
| Java | 17+ | Required by H2O (auto-falls back if missing) |
| GPU + CUDA | Optional | XGBoost acceleration |

### Installation

```bash
# Core dependencies
pip install numpy pandas matplotlib scikit-learn h2o xgboost optuna

# Optional: notebook tooling
pip install nbclient nbformat ipykernel ipywidgets
```

### Data Setup

Download the [OULAD dataset](https://analyse.kmi.open.ac.uk/open_dataset) and place the 7 CSV files in a `data/` folder:

```bash
mkdir data
# Place these files inside data/
# assessments.csv | courses.csv | studentAssessment.csv | studentInfo.csv
# studentRegistration.csv | studentVle.csv (~433 MB) | vle.csv
```

### Run

```bash
jupyter notebook Prj_DBM_Final.executed_EDA.ipynb
```

Run all cells top-to-bottom. That's it.

## Pipeline Overview

```
 Data Loading ──▶ Feature Engineering ──▶ EDA ──▶ Modeling ──▶ Evaluation
```

## Models

| Model | Type | Purpose |
|-------|------|---------|
| **Logistic Regression** | Linear | Interpretability baseline |
| **Decision Tree** (depth=6) | Rule-based | Non-linear baseline |
| **H2O AutoML** | Ensemble search | Best-of-family comparison (GLM, GBM, DRF, Stacked) |
| **XGBoost + Optuna** | Tuned boosting | Peak tabular performance with Bayesian HP search |

### Runtime Configuration

Control training intensity via `TEST_MODE` in the setup cell:

| Variable | `TEST_MODE = True` | `TEST_MODE = False` |
|---|---|---|
| `AUTOML_MAX_MODELS` | 1 model | 20 models |
| `XGB_TRIALS` | 1 trial | 10 trials |

`AUTOML_MAX_RUNTIME_SECS` can be adjusted independently.

## Results

| Output | Location |
|--------|----------|
| Best XGBoost model | `results/xgboost_best_model.json` |
| AutoML leaderboard | Printed in notebook |
| Performance metrics (AUC, F1, Accuracy) | Printed in notebook |
| Project report | `docs/Report dbm.pdf` |

## Project Structure

```
dbm-project/
├── data/                                  # OULAD CSV files (gitignored)
├── h2o_logs/                              # H2O runtime logs
├── results/
│   └── xgboost_best_model.json            # Best XGBoost model from Optuna
├── Prj_DBM_Final.executed_EDA.ipynb       # Full pipeline notebook
└── README.md
```

## References

| Topic | Source |
|-------|--------|
| Logistic Regression | [Google ML Crash Course](https://developers.google.com/machine-learning/crash-course/logistic-regression/sigmoid-function) |
| Decision Trees | [scikit-learn docs](https://scikit-learn.org/stable/modules/tree.html) |
| Log Loss | [scikit-learn docs](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.log_loss.html) |
| XGBoost | [Chen & Guestrin, 2016](https://arxiv.org/pdf/1603.02754) |
| H2O AutoML | [H2O docs](https://docs.h2o.ai/h2o/latest-stable/h2o-r/docs/reference/h2o.automl.html) |

---

<div align="center">

**MIT License** · Made for DBM302m

</div>
