<div align="center">

# Football Performance Predictor

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![scikit-learn](https://img.shields.io/badge/scikit--learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org)
[![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://streamlit.io)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

> An end-to-end machine learning pipeline that predicts Fantasy Premier League (FPL) player performance scores from historical statistics — with an interactive web interface for querying predictions.

</div>

---

## Overview

Fantasy Premier League managers make weekly decisions based on intuition and recency bias. This project builds a data-driven alternative: a machine learning pipeline trained on historical FPL statistics that predicts a player's expected points return, surfaced through an interactive web app.

The system covers the full ML lifecycle — data ingestion, feature engineering, model training, evaluation, and deployment — making it both a practical tool and a demonstration of production ML thinking.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Data Ingestion                          │
│  FPL API → Historical gameweek data → Local cache (CSV)     │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                  Feature Engineering                        │
│  Rolling averages (3GW, 5GW) · Fixture difficulty rating     │
│  Position encoding · Form score · Home/Away flag             │
│  Minutes normalisation · Opponent strength                   │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                   Model Training                            │
│  Train/test split → Cross-validation → Model selection       │
│  Gradient Boosting / Random Forest / Ridge Regression        │
│  Hyperparameter tuning with GridSearchCV                     │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                    Inference & UI                           │
│  Streamlit app → Player search → Predicted points output     │
│  Feature importance chart · Model performance metrics        │
└─────────────────────────────────────────────────────────────┘
```

---

## Key Features

- **FPL API integration** — ingests historical gameweek data directly from the official FPL API
- **Rich feature engineering** — builds rolling performance windows, fixture difficulty ratings, and positional encodings that capture form and context
- **Model comparison** — trains and compares multiple scikit-learn regressors, selects the best by cross-validated RMSE
- **Interactive web app** — query any player by name and view predicted points, confidence, and feature contributions
- **Reproducible pipeline** — a single script runs the full pipeline from raw data to saved model

---

## Tech Stack

| Component | Technology |
|---|---|
| Language | Python 3.10+ |
| ML | scikit-learn |
| Data Processing | Pandas, NumPy |
| Visualisation | Matplotlib, Seaborn |
| Web App | Streamlit |
| Data Source | FPL API (fantasy.premierleague.com) |

---

## Getting Started

```bash
# Clone the repo
git clone https://github.com/Ghost-tech-ng/football-performance-predictor.git
cd football-performance-predictor

# Install dependencies
pip install -r requirements.txt

# Run the full training pipeline
python pipeline.py

# Launch the web app
streamlit run app.py
```

---

## Project Structure

```
football-performance-predictor/
├── data/
│   ├── raw/                  # Raw FPL API responses
│   └── processed/            # Engineered feature datasets
├── models/
│   └── best_model.pkl        # Saved trained model
├── src/
│   ├── fetch_data.py         # FPL API ingestion
│   ├── features.py           # Feature engineering pipeline
│   ├── train.py              # Model training and evaluation
│   └── predict.py            # Inference utilities
├── pipeline.py               # End-to-end pipeline runner
├── app.py                    # Streamlit web interface
└── requirements.txt
```

---

## Model Performance

| Metric | Value |
|---|---|
| Model | Gradient Boosting Regressor |
| CV RMSE | _(see training output)_ |
| Key Features | Rolling 5GW avg, fixture difficulty, form score |

---

## Author

**Eghosa Osemwegie** — [GitHub](https://github.com/Ghost-tech-ng) · [Portfolio](http://www.eghosa.tech) · [Email](mailto:osemwegiee@gmail.com)
