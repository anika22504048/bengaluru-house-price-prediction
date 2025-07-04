# bengaluru-house-price-prediction
Predict Bangalore house prices using R with linear regression, feature engineering, and diagnostics.
# Bengaluru House Price Prediction
This project applies predictive analytics to estimate housing prices in Bangalore using R. The analysis uses multiple linear regression 
combined with thoughtful data cleaning, feature engineering, and model validation.
⚡ Key Features
- **Data cleaning**: Removed duplicates, unnecessary columns, and handled missing values.
- **Feature engineering**: 
  - Converted sqft ranges (e.g. "2100-2850") into numeric means.
  - Extracted BHK (bedrooms) from textual data.
  - Encoded locations, grouping infrequent ones as "other".
- **Modeling**: Built a multiple linear regression model with predictors: total_sqft, bhk, bath, location.
- **Diagnostics**:
  - Breusch-Pagan test confirmed no heteroscedasticity (p > 0.05).
  - VIF < 5 for all variables, showing no multicollinearity concerns.
 📈 Results
- Visualized actual vs predicted prices.
- The model provides reasonable predictions and can be extended with more features or advanced algorithms.
🛠 Tools & Libraries
- R: `dplyr`, `ggplot2`, `lmtest`, `car`
 💻 How to Run
- Open `analysis.R` in RStudio.
- Run the script to see model summary, plots, and tests.
- (Optional) Export plots from RStudio for reporting.
 📂 Dataset
The dataset used is from Kaggle: [Bengaluru House Price Data](https://www.kaggle.com/datasets/amitabhajoy/bengaluru-house-price-data)
 ✉️ About
This project demonstrates applying predictive modeling techniques in R for real estate data, combining statistical rigor with clear visual insights.
