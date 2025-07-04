#importing dataset
df<-Bengaluru_House_Data
View(df)
str(df)
#cleanup of data
#removed duplicates
df <- df[!duplicated(df), ]
df
#removing unnecessary columns
df$society <- NULL
#handled missing values
df <- Bengaluru_House_Data[, c("location", "size", "bath", "balcony", "total_sqft")]
df <- na.omit(df)
df
#converted area (total_sqft) and bedrooms (bhk) to numeric
df$location <- as.factor(df$location)
df$location
convert_sqft <- function(x) {
  x <- trimws(x)
  if (grepl("-", x)) {
    parts <- strsplit(x, "-")[[1]]
    return(mean(as.numeric(parts)))
  }
  if (!is.na(as.numeric(x))) {
    return(as.numeric(x))
  }
  return(NA)
}
convert_sqft
df$total_sqft <- sapply(df$total_sqft, convert_sqft)
df$total_sqft
df <- df[!is.na(df$total_sqft), ]
df$bhk <- as.numeric(gsub("([0-9]+).*", "\\1", df$size))
df$size <- NULL
df
df$bhk
# price matching with the cleaned data
df$price <- Bengaluru_House_Data$price[match(rownames(df), rownames(Bengaluru_House_Data))]
df$price
#multiple linear regression 
model<- lm(price~total_sqft+bhk+bath+location, data = df)
summary(model)
# visualization
df$predicted_price <- predict(model, df)

plot(df$price, df$predicted_price,
     xlab = "Actual Price (Lakh ₹)",
     ylab = "Predicted Price (Lakh ₹)",
     main = "Actual vs Predicted Price",
     pch = 16, col = "steelblue")
abline(0, 1, col = "red", lwd = 2)
#residuals and visualization 
pred<-fitted(model)
pred
resi<-residuals(model)
resi
plot(model, which = 1)
#breusch-pagan test for heteroscedasticity
#if p-value < 0.05: Heteroscedasticity detected
#if p-value > 0.05: Residuals have constant variance
install.packages("lmtest")
library(lmtest)
bptest(model)
location_counts <- table(df$location)
frequent_locations <- names(location_counts[location_counts > 10])
df$location <- ifelse(df$location %in% frequent_locations, df$location, "other")
df$location <- as.factor(df$location)
location_counts
frequent_locations
df$location
#this is ideal, since p-value is grater than 0.05
#multicollinearity using vif
#Vif< 5: No multicollinearity concern 
#vif between 5–10: Moderate concern 
#vif> 10: Serious multicollinearity 
model_numeric <- lm(price ~ total_sqft + bhk + bath + balcony, data = df)
model_numeric
installed.packages("car")
library(car)
vif(model) 
vif(model_numeric)
#all vif values are below 5, which indicates no multicollinearity issues.

