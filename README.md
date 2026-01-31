# OULAD Student Performance Prediction

This project analyzes the Open University Learning Analytics Dataset (OULAD) and builds a model to predict student outcomes (Pass or Fail). The main analysis is in the notebook.

## Project Highlights
- End-to-end data pipeline from raw CSVs to model evaluation
- Early warning mode to reduce label leakage
- Compact and transparent EDA with multi-plot blocks
- Feature selection using RFECV

## Dataset Notes
The dataset includes seven CSV files:
- `assessments.csv` for assessment metadata
- `courses.csv` for module presentation length
- `studentAssessment.csv` for student submissions and scores
- `studentInfo.csv` for demographics and final outcome
- `studentRegistration.csv` for registration and unregistration dates
- `studentVle.csv` for daily VLE activity by site
- `vle.csv` for VLE site metadata

Dates are relative to module start and can be negative when activity or registration happens before the official start.

## Notebook Flow
1. Setup and configuration
2. Data loading and overview
3. Data cleaning and justification
4. Feature engineering and transformation
5. EDA in multi-plot blocks
6. Baseline modeling
7. Feature selection and leakage analysis
8. Evaluation and interpretation
9. Bonus model comparison
10. Conclusions and next steps

## How to Run
1. Place the seven OULAD CSV files in the project folder or update `DATA_DIR` in the notebook.
2. Open `Project_DBM_guided_minimal.ipynb` and run all cells.

## Files
- `Project_DBM_guided_minimal.ipynb` is the main notebook
- `agents.md` is the development log
- `.gitignore` excludes dataset files from git
