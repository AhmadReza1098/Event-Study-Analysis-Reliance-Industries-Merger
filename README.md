# Event-Study-Analysis-Reliance-Industries-Merger
Event study analysis of Reliance Industries’ merger announcement using R, examining stock price response over a 21-day event window with a market model. Findings indicate no significant abnormal returns on event days, but cumulative abnormal returns show a significant negative impact.
# 📊 Event Study Analysis — Reliance Industries Merger Announcement

## 📝 Project Overview
This project conducts an **event study analysis** on **Reliance Industries Ltd.** to assess the stock market reaction to a **merger announcement**.  
The analysis uses a **±10-day event window** around the announcement date (`2020-11-08`) with a **Market Model** to measure **Abnormal Returns (AR)** and **Cumulative Abnormal Returns (CAR)**.

---

## 🎯 Objectives
- Identify whether the merger announcement had a statistically significant effect on Reliance’s stock price.
- Compare immediate abnormal returns (AR) with accumulated effects (CAR).
- Interpret whether the market perceived the announcement positively, negatively, or neutrally.

---

## 📅 Event Study Setup
- **Event Date:** 2020-11-08
- **Event Window:** -10 to +10 trading days around the event date (21 trading days total)
- **Estimation Window:** 60 trading days prior to the event window
- **Benchmark:** NIFTY 50 index

---

## 🧮 Methodology
1. **Data Collection:**
   - Download daily adjusted closing prices for Reliance Industries (`RELIANCE.NS`) and NIFTY 50 (`^NSEI`) from Yahoo Finance.
   
2. **Return Calculation:**
   - Daily returns for stock and market.

3. **Market Model Estimation:**
   - Use estimation window to fit the model:  
     \[
     R_{it} = \alpha + \beta R_{mt} + \epsilon_t
     \]

4. **Abnormal Return (AR) Computation:**
   - AR = Actual Return − Expected Return (from Market Model).

5. **Cumulative Abnormal Return (CAR):**
   - CAR = cumulative sum of ARs over the event window.

6. **Hypothesis Testing:**
   - **Null hypothesis:** No abnormal returns (AR or CAR = 0).
   - One-sample t-tests for AR and CAR.

7. **Visualization:**
   - AR plot over event window.
   - CAR plot to show cumulative price impact.

---

## 📌 Findings
- **Abnormal Returns (AR):**
  - ARs are **not statistically significant** for most individual days.
  - Indicates no strong immediate daily reaction to the merger announcement.
  
- **Cumulative Abnormal Returns (CAR):**
  - CAR is **statistically significant at the 5% level**.
  - Mean CAR is **negative (-3.68%)**, indicating an overall **negative market sentiment** over the event window.
  
- **Interpretation:**
  - While short-term daily fluctuations were not significant, the accumulated effect over the 21-day period was meaningfully negative.
  - Suggests gradual negative sentiment/repricing rather than an immediate one-day shock.

---

## 📦 Requirements

install.packages(c("quantmod", "PerformanceAnalytics", "tidyverse", "tseries"))
---

## 📖 References
- MacKinlay, A.C. (1997). "Event Studies in Economics and Finance." *Journal of Economic Literature*.
- Yahoo Finance (historical stock data).
- R packages: `quantmod`, `PerformanceAnalytics`, `tidyverse`, `tseries`.

---

## 📢 Conclusion
The merger announcement by Reliance Industries led to a **statistically significant negative cumulative market reaction** over the event window, despite no significant impact on individual daily abnormal returns. This finding underlines the importance of analysing **CAR** alongside **AR** when assessing market reactions to corporate events.
