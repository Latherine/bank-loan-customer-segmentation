# 🏦 Bank Loan Customer Segmentation

> SQL-powered bank loan report analyzing 38K+ applications to segment good vs bad loan profiles and recommend targeted customers.

---

## 📁 Project Structure

```
bank-loan-customer-segmentation/
│
├── dashboard.pbix                        # Power BI interactive dashboard
├── dashboard.pdf                         # Dashboard export (PDF)
│
├── financial_loan.csv                    # Raw loan dataset
├── financial_loan_clean.csv             # Cleaned dataset
│
├── sql_query.sql                         # All SQL queries used for analysis
├── transform_df.ipynb                      # Python/Pandas notebook (EDA)
│
├── Bank_Loan_Targeted_Customer_Report.docx  # Final strategy report (Word)
│
├── Month_Loan_Report.csv                 # Loan data aggregated by month
├── State_Loan_Report.csv                 # Loan data aggregated by state
├── Term_Loan_Report.csv                  # Loan data aggregated by term
├── Employment_Length_Loan_Report.csv     # Loan data by employment length
├── Purpose_Loan_Report.csv              # Loan data by loan purpose
├── Home_ownership_Loan_Report.csv       # Loan data by home ownership
│
├── dashboard_fix.pbix                    # Updated dashboard — adds ML risk page
├── ml_risk_prediction/
│   ├── loan_risk_prediction_ml.ipynb     # ML model: predicts risk of Current loans
│   └── current_loan_risk_predictions.csv # Per-loan risk probabilities (1,098 loans)
└── report/Loan_Risk_ML_Improvement_Report.docx / .pdf   # ML improvement report
```

---

## 📊 Dashboard Overview

Built with **Power BI**, the dashboard has three views:

| View | Description |
|------|-------------|
| **Summary** | KPIs — total applications, funded amount, received amount, interest rate, DTI, good/bad loan split |
| **Overview** | Trends by month, state, term, employment length, purpose, and home ownership |
| **Detail** | Granular loan-level table with grade, sub-grade, interest rate, and installment data |

### Key KPIs

| Metric | Value |
|--------|-------|
| Total Loan Applications | 38,576 |
| Total Funded Amount | $435.76M |
| Total Amount Received | $473.07M |
| Average Interest Rate | 12.05% |
| Average DTI | 13.33% |
| Good Loan Rate | 86.2% |
| Bad Loan (Charged Off) Rate | 13.8% |

---

## 🗄️ SQL Analysis

The `sql_query.sql` file covers:

- **Good Loan metrics** — funded amount and total received for Fully Paid + Current loans
- **Bad Loan metrics** — percentage, application count, funded amount, and received amount for Charged Off loans
- **Loan Status breakdown** — applications, received, funded, interest rate, and DTI per status
- **Monthly trends** — application volume and amounts by month
- **State-level analysis** — geographic distribution of loans
- **Term analysis** — 36-month vs 60-month comparison
- **Employment Length** — loan volume by years of employment
- **Purpose** — breakdown by loan purpose (debt consolidation, credit card, etc.)
- **Home Ownership** — RENT vs MORTGAGE vs OWN comparison

---

## 🎯 Targeted Customer Segments

Detailed findings are in `Bank_Loan_Targeted_Customer_Report.docx`. Summary below:

### ✅ Segment A — Prime Target
**Long-tenured employed homeowners (Mortgage)**
- 10+ years employment, mortgage holders
- Preferred purpose: Debt consolidation (~7,600 apps in this filter)
- Recommended term: 36 months | Grade A–B
- Lowest DTI, highest repayment reliability

### ✅ Segment B — Growth Target
**Renters seeking debt consolidation**
- Largest home ownership group (18,439 apps)
- Employment: 2–5 years
- Grade B–C with DTI monitoring

### ✅ Segment C — High-Value Target
**Credit card payoff customers**
- 4,998 applications | $58.9M received
- Grade A–B | 36-month term
- Strong repayment behaviour; cross-sell opportunity

### ⚠️ Segments to Avoid / Approach with Caution
- Small business loans (variable income risk)
- 60-month term seekers below Grade B
- Employment < 1 year (income instability)
- Grade D–G applicants (high charge-off correlation)

---

## 🐍 Python Notebook

`Untitled-1.ipynb` uses **Pandas** for exploratory data analysis.

Uses a raw string path (`r''`) to safely read the CSV on Windows without unicode escape errors.

---

## 🤖 Machine Learning Risk Prediction (Update)

The original Good/Bad Loan split above counts every `Current` (still-open) loan as **Good Loan** by default — a rule, not a measurement. `ml_risk_prediction/loan_risk_prediction_ml.ipynb` replaces that assumption with a model trained on the 37,478 loans whose outcome is already known (Fully Paid / Charged Off), then scores the 1,098 open `Current` loans with a probability of default.

| Metric | Value |
|--------|-------|
| Best model | CatBoost (Optuna-tuned, 100 trials) |
| AUC-ROC | **0.6999** vs. **0.50** for the original "assume good" rule → **+40% relative improvement** |
| Current loans reclassified High Risk | 705 / 1,098 (64.2%), **$11.85M** in principal |
| Risk-adjusted Bad Loan Rate | 13.8% (reported) → **15.6–15.65%** |

Full write-up, methodology, and figures: [`report/Loan_Risk_ML_Improvement_Report.pdf`](report/Loan_Risk_ML_Improvement_Report.pdf) ([.docx](report/Loan_Risk_ML_Improvement_Report.docx)). The updated dashboard (`dashboard_fix.pbix`) adds a **Current Status Prediction** page built on `current_loan_risk_predictions.csv`.

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| **MySQL** | Data querying and aggregation |
| **Power BI** | Interactive dashboard and visualisation |
| **Python / Pandas** | Exploratory data analysis |
| **LightGBM / CatBoost / Optuna / SHAP** | Loan risk prediction model, tuning, and explainability |
| **Microsoft Word** | Strategy and risk report generation |

---

## 📌 How to Use

1. Load `financial_loan.csv` into your MySQL database as `financial_loan` table
2. Run `sql_query.sql` to reproduce all aggregated reports
3. Open `dashboard.pbix` in Power BI Desktop to explore the interactive dashboard
4. Review `Bank_Loan_Targeted_Customer_Report.docx` for the full acquisition strategy
5. Run `ml_risk_prediction/loan_risk_prediction_ml.ipynb` to reproduce the risk model, or open `dashboard_fix.pbix` / `report/Loan_Risk_ML_Improvement_Report.pdf` to see the results

---

## 📄 License

This project is for educational and analytical purposes.
