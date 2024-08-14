# Machine Learning Pipeline Project

This project involves developing a comprehensive master function to automate key data science tasks and then to employ multiple class imbalance solutions and compare their effectiveness and model performance. The project is divided into two main parts: data preprocessing and feature selection, followed by class imbalance treatment and model evaluation.

## Part 1: Data Preprocessing and Feature Selection

In this notebook, we:
- **Preprocess the data**, including tasks such as:
  - Data cleaning
  - Handling missing values
  - Outlier detection and treatment
  - Standardization and encoding
  - Exploratory Data Analysis (EDA)
- **Feature Selection** through *forward feature selection* using accuracy as the scoring metric and Random Forest as the chosen model.

The processed dataset is exported to a CSV file, ready for further analysis.

## Part 2: Class Imbalance Solutions and Model Evaluation

In this notebook, we:
- **Import the preprocessed dataset** from Part 1.
- **Apply various class imbalance treatment solutions**, including:
  - ADASYN (Adaptive Synthetic Sampling)
  - Class weighting
  - One-Class Learning

- **Test and compare multiple machine learning models** on the balanced dataset:
  - Logistic Regression
  - Random Forest
  - XGBoost
  - Support Vector Machine (SVM)
  - K-Nearest Neighbors (KNN)

The performance of each model is evaluated and compared to determine the most effective approach.
