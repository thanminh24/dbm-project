OULAD Student Performance Pass Fail

This project analyzes the Open University Learning Analytics Dataset and builds a model to predict student outcomes as pass or fail. The main work is in the notebook Project_DBM_guided_minimal.ipynb.

Dataset notes
The dataset is provided as seven CSV files. The studentVle file is the largest and contains clickstream activity by day. Dates are relative to the module presentation and can be negative when activity or registration happens before the official start. The target label comes from final_result in studentInfo. The notebook uses early warning mode by default and excludes assessment derived features from modeling to avoid leakage.

The seven CSV files are
assessments.csv for assessment metadata such as type, weight, and due date
courses.csv for module presentation length
studentAssessment.csv for student submissions and scores
studentInfo.csv for demographics and final outcome
studentRegistration.csv for registration and unregistration dates
studentVle.csv for daily VLE activity by site
vle.csv for VLE site metadata

Notebook flow summary
Section 1 Setup and configuration.
Section 2 Data loading and overview.
Section 3 Data cleaning and justification.
Section 4 Feature engineering and transformation.
Section 5 Exploratory data analysis in condensed multi plot blocks.
Section 6 Modeling baseline with a single preprocessing pipeline.
Section 7 Feature selection with leakage analysis and RFECV.
Section 8 Evaluation and interpretation.
Section 9 Bonus comparison of multiple algorithms.
Section 10 Conclusions and next steps.

How to run
1. Place the seven OULAD CSV files in the project folder or update DATA_DIR in the notebook.
2. Open Project_DBM_guided_minimal.ipynb and run all cells from top to bottom.

Files
Project_DBM_guided_minimal.ipynb is the end to end analysis notebook.
agents.md is the change log during development.
.gitignore excludes dataset files from git.
