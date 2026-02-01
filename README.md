# OULAD Early‑Warning Modeling (H2O AutoML + XGBoost)

This project predicts student pass/fail outcomes using early, non‑leaking signals from the OULAD dataset. The workflow is notebook‑driven and includes detailed EDA, leakage investigation, feature selection, and modeling (Logistic Regression, Decision Tree, H2O AutoML, XGBoost + Optuna).

## Requirements

- Python 3.10+ (3.11 recommended)
- Java 17+ (required by H2O)
- Optional: GPU + CUDA for XGBoost acceleration

## Install (All Libraries)

```bash
pip install numpy pandas matplotlib scikit-learn h2o xgboost optuna
```

Optional (notebook tooling):

```bash
pip install nbclient nbformat ipykernel
```

## Folder Structure

```
D:\Project\DBM_FINAL\
├── data\                 # OULAD CSV files
├── h2o_logs\             # H2O runtime logs
├── results\              # Model logs and artifacts
├── Prj_DBM_Final.ipynb   # Full pipeline (EDA -> Modeling -> Evaluation)
├── README.md
└── LICENSE
```

## Create and Populate the Data Folder

1) Create the folder:

```bash
mkdir data
```

2) Place the 7 OULAD CSV files in `data/`:

- assessments.csv
- courses.csv
- studentAssessment.csv
- studentInfo.csv
- studentRegistration.csv
- studentVle.csv
- vle.csv

## Run (Single Notebook Workflow)

Open and run **`Prj_DBM_Final.ipynb`** end‑to‑end. It includes:

- Data loading and cleaning
- Full EDA (visualizations + leakage investigation)
- Feature selection (hardcoded 40‑feature list)
- Modeling (Logistic Regression, Decision Tree, H2O AutoML, XGBoost + Optuna)
- Evaluation and interpretation

## Runtime Configuration (Final Notebook)

In the setup cell of `Prj_DBM_Final.ipynb`:

- `TEST_MODE = True` → quick validation (AutoML=1 model, XGB=1 trial)
- `TEST_MODE = False` → full run (AutoML=20 models, XGB=10 trials)

You can also adjust:
- `AUTOML_MAX_MODELS`
- `AUTOML_MAX_RUNTIME_SECS`
- `XGB_TRIALS`

## Outputs

- `results/` contains model logs and artifacts
- AutoML leaderboard + metrics are printed in the notebook
- XGBoost best parameters and metrics are printed after Optuna search

## References

```
https://developers.google.com/machine-learning/crash-course/logistic-regression/sigmoid-function
https://scikit-learn.org/stable/modules/tree.html
https://scikit-learn.org/stable/modules/generated/sklearn.metrics.log_loss.html
https://arxiv.org/pdf/1603.02754
https://docs.h2o.ai/h2o/latest-stable/h2o-r/docs/reference/h2o.automl.html
```
