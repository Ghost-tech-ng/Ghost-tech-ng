<div align="center">

# Explainable AI Crime Prediction System

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=tensorflow&logoColor=white)](https://tensorflow.org)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> A final-year research project building a crime prediction pipeline with **interpretable** machine learning — going beyond black-box accuracy to explain *why* a prediction is made.

</div>

---

## Overview

Most crime prediction systems sacrifice interpretability for performance. This project addresses that trade-off head-on by integrating **SHAP** (SHapley Additive exPlanations) and **LIME** (Local Interpretable Model-agnostic Explanations) into a full ML pipeline, making the model's decisions auditable and trustworthy for real-world use.

Built as a final-year capstone, the system demonstrates how explainability techniques can be applied to high-stakes predictions in public safety contexts.

---

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                        Data Layer                            │
│  Raw Dataset → Feature Engineering → Train/Test Split        │
└─────────────────────────┬────────────────────────────────────┘
                          │
┌─────────────────────────▼────────────────────────────────────┐
│                      Model Layer                             │
│  TensorFlow/Keras Neural Network + scikit-learn Ensemble     │
│  Cross-validation · Hyperparameter tuning · Model selection  │
└─────────────────────────┬────────────────────────────────────┘
                          │
┌─────────────────────────▼────────────────────────────────────┐
│                  Explainability Layer                        │
│  SHAP → Global feature importance + local prediction reasons │
│  LIME → Perturbation-based local explanations per instance   │
└─────────────────────────┬────────────────────────────────────┘
                          │
┌─────────────────────────▼────────────────────────────────────┐
│                   Dashboard Layer                            │
│  Streamlit UI → Interactive queries, charts, SHAP plots      │
└──────────────────────────────────────────────────────────────┘
```

---

## Key Features

- **Multi-model pipeline** — compares neural network and ensemble classifiers to select the best performer
- **SHAP global explanations** — waterfall charts and beeswarm plots showing which features drive predictions across the dataset
- **LIME local explanations** — per-instance explanations that show why a specific prediction was made
- **Interactive Streamlit dashboard** — query the model, visualise explanations, and explore feature importance without writing code
- **Preprocessing pipeline** — handles missing values, encodes categorical features, and normalises inputs consistently between train and inference

---

## Tech Stack

| Component | Technology |
|---|---|
| ML Framework | TensorFlow / Keras |
| Classical ML | scikit-learn |
| Explainability | SHAP, LIME |
| Dashboard | Streamlit |
| Data Processing | Pandas, NumPy |
| Visualisation | Matplotlib, Seaborn |

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/crime-prediction-explainable-ai.git
cd crime-prediction-explainable-ai

# Install dependencies
pip install -r requirements.txt

# Run the Streamlit dashboard
streamlit run app.py
```

---

## Project Structure

```
crime-prediction-explainable-ai/
├── data/                   # Raw and processed datasets
├── models/                 # Saved model checkpoints
├── notebooks/              # Exploratory analysis and experiments
├── src/
│   ├── preprocessing.py    # Feature engineering pipeline
│   ├── model.py            # TensorFlow model definition
│   ├── explain.py          # SHAP and LIME integration
│   └── evaluate.py         # Metrics and evaluation
├── app.py                  # Streamlit dashboard entry point
└── requirements.txt
```

---

## Results

The system achieves competitive prediction accuracy while providing full interpretability at both the global (dataset-level) and local (individual prediction) levels — a combination that makes it viable for real-world deployment in scenarios where accountability matters.

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
