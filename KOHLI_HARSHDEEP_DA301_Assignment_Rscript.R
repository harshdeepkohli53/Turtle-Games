########## Owner - Harshdeep Kohli ##########

## LSE Data Analytics Online Career Accelerator 
## DA301:  Advanced Analytics for Organisational Impact

###############################################################################

## Assignment 5 scenario
## Turtle Games’s sales department has historically preferred to use R when performing 
## sales analyses due to existing workflow systems. As you’re able to perform data analysis 
## in R, you will perform exploratory data analysis and present your findings by utilising 
## basic statistics and plots. You'll explore and prepare the data set to analyse sales per 
## product. The sales department is hoping to use the findings of this exploratory analysis 
## to inform changes and improvements in the team. (Note that you will use basic summary 
## statistics in Module 5 and will continue to go into more detail with descriptive 
## statistics in Module 6.)

################################################################################

## Assignment 5 objective
## Load and wrangle the data. Use summary statistics and groupings if required to sense-check
## and gain insights into the data. Make sure to use different visualisations such as scatterplots, 
## histograms, and boxplots to learn more about the data set. Explore the data and comment on the 
## insights gained from your exploratory data analysis. For example, outliers, missing values, 
## and distribution of data. Also make sure to comment on initial patterns and distributions or 
## behaviour that may be of interest to the business.

################################################################################

# Module 5 assignment: Load, clean and wrangle data using R

## It is strongly advised that you use the cleaned version of the data set that you created and 
##  saved in the Python section of the course. Should you choose to redo the data cleaning in R, 
##  make sure to apply the same transformations as you will have to potentially compare the results.
##  (Note: Manual steps included dropping and renaming the columns as per the instructions in module 1.
##  Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 

## 1. Open your RStudio and start setting up your R environment. 
## 2. Open a new R script and import the turtle_review.csv data file, which you can download from 
##      Assignment: Predicting future outcomes. (Note: You can use the clean version of the data 
##      you saved as csv in module 1, or, can manually drop and rename the columns as per the instructions 
##      in module 1. Drop ‘language’ and ‘platform’ and rename ‘remuneration’ and ‘spending_score’) 
## 3. Import all the required libraries for the analysis and view the data. 
## 4. Load and explore the data.
##    - View the head the data.
##    - Create a summary of the new data frame.
## 5. Perform exploratory data analysis by creating tables and visualisations to better understand 
##      groupings and different perspectives into customer behaviour and specifically how loyalty 
##      points are accumulated. Example questions could include:
##    - Can you comment on distributions, patterns or outliers based on the visual exploration of the data?
##    - Are there any insights based on the basic observations that may require further investigation?
##    - Are there any groupings that may be useful in gaining deeper insights into customer behaviour?
##    - Are there any specific patterns that you want to investigate
## 6. Create
##    - Create scatterplots, histograms, and boxplots to visually explore the loyalty_points data.
##    - Select appropriate visualisations to communicate relevant findings and insights to the business.
## 7. Note your observations and recommendations to the technical and business users.

###############################################################################

### PREPARE WORKSTATION ###

# Import libraries
library(tidyverse)
library(skimr)
library(DataExplorer)
library(moments)
library(ggcorrplot)
library(car)
library(lmtest)
library(rstatix)
library(Metrics)


### LOAD THE DATA ###

# read the csv file (name of the csv file is 'turtle.csv')
turtle <- read.csv('turtle.csv',header=TRUE)

### DATA VALIDATION ###

# view the dimensions of the data frame
dim(turtle)

# view the column data types of the file
str(turtle)

# view the column names
colnames(turtle)

# use as_tibble(df) to view the data frame in a cleaner format
as_tibble(turtle)

# view the header data
head(turtle)

## Note - 'product' is stored as an integer variable. It should be categorical/factor

# convert product to a factor/categorical variable
turtle <- mutate(turtle,product=as.factor(product))

# check that the product is now a factor/categorical variable
as_tibble(turtle)

# count total missing values in each column
sapply(turtle, function(x) sum(is.na(x)))

# view number of missing values in the whole data frame
sum(is.na(turtle))

# view the number of duplicate values in the whole data frame
nrow(turtle[duplicated(turtle), ])

# drop the review & summary column as not useful in this analysis
turtle <- subset(turtle, select = -c(review,summary))

### SUMMARY STATISTICS ###

# view the data summary using the skim package
skim(turtle)

# view the basic data summary
summary(turtle)

# create a summary report using the DataExplorer library
DataExplorer::create_report(turtle)

### Analysis / Visualizations ###

## Loyalty Points

# Histogram of loyalty points
ggplot(turtle, aes(x = loyalty)) +
  geom_histogram(binwidth = 100, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Loyalty Points",
       x = "Loyalty Points",
       y = "Frequency")

# Histogram of loyalty points with density plot
hist(turtle$loyalty, 
     breaks=30, 
     probability=TRUE,  
     main="Distribution of Loyalty Points",
     xlab="Loyalty Points",
     col="lightblue",
     border="white")

# Add a density curve
lines(density(turtle$loyalty), col="darkblue", lwd=2)

# Add vertical lines for important statistics
abline(v=mean(turtle$loyalty), col="red", lwd=2)
abline(v=median(turtle$loyalty), col="darkgreen", lwd=2)
abline(v=quantile(turtle$loyalty, 0.25), col="purple", lwd=2, lty=2)
abline(v=quantile(turtle$loyalty, 0.75), col="purple", lwd=2, lty=2)

# Add a legend
legend("topright", 
       legend=c("Density", "Mean", "Median", "Quartiles"),
       col=c("darkblue", "red", "darkgreen", "purple"),
       lwd=c(2,2,2,2),
       lty=c(1,1,1,2))


# Boxplot of loyalty points
boxplot(turtle$loyalty,
        main="Boxplot of Loyalty Points",
        ylab="Loyalty Points",
        col="lightblue")


## Age

# Histogram of Age
ggplot(turtle, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Age",
       x = "Age",
       y = "Frequency")


# Histogram of Age with density plot
hist(turtle$age, 
     breaks=30, 
     probability=TRUE,  # To show density instead of frequency
     main="Distribution of Age",
     xlab="Age",
     col="lightblue",
     border="white")

# Add a density curve
lines(density(turtle$age), col="darkblue", lwd=2)

# Add vertical lines for important statistics
abline(v=mean(turtle$age), col="red", lwd=2)
abline(v=median(turtle$age), col="darkgreen", lwd=2)
abline(v=quantile(turtle$age, 0.25), col="purple", lwd=2, lty=2)
abline(v=quantile(turtle$age, 0.75), col="purple", lwd=2, lty=2)

# Add a legend
legend("topright", 
       legend=c("Density", "Mean", "Median", "Quartiles"),
       col=c("darkblue", "red", "darkgreen", "purple"),
       lwd=c(2,2,2,2),
       lty=c(1,1,1,2))


# Boxplot for age
boxplot(turtle$age,
        main="Boxplot of Age",
        ylab="Age",
        col="lightblue")


## Pay (remuneration/income)

# Histogram of Pay (remuneration)
ggplot(turtle, aes(x = pay)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Pay",
       x = "Pay",
       y = "Frequency")


# Histogram of Pay (remuneration) with density plot
hist(turtle$pay, 
     breaks=30, 
     probability=TRUE,  
     main="Distribution of Pay",
     xlab="Pay",
     col="lightblue",
     border="white")

# Add a density curve
lines(density(turtle$pay), col="darkblue", lwd=2)

# Add vertical lines for important statistics
abline(v=mean(turtle$pay), col="red", lwd=2)
abline(v=median(turtle$pay), col="darkgreen", lwd=2)
abline(v=quantile(turtle$pay, 0.25), col="purple", lwd=2, lty=2)
abline(v=quantile(turtle$pay, 0.75), col="purple", lwd=2, lty=2)

# Add a legend
legend("topright", 
       legend=c("Density", "Mean", "Median", "Quartiles"),
       col=c("darkblue", "red", "darkgreen", "purple"),
       lwd=c(2,2,2,2),
       lty=c(1,1,1,2))


# Boxplot for pay (remuneration)
boxplot(turtle$pay,
        main="Boxplot of Pay",
        ylab="Pay",
        col="lightblue")


## Spend (spending score)


# Histogram of Spend (spending score)
ggplot(turtle, aes(x = spend)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Spending Score",
       x = "Spending Score",
       y = "Frequency")


# Histogram of spend (spending score) with density plot
hist(turtle$spend, 
     breaks=30, 
     probability=TRUE,  
     main="Distribution of Spending Score",
     xlab="Spending Score",
     col="lightblue",
     border="white")

# Add a density curve
lines(density(turtle$spend), col="darkblue", lwd=2)

# Add vertical lines for important statistics
abline(v=mean(turtle$spend), col="red", lwd=2)
abline(v=median(turtle$spend), col="darkgreen", lwd=2)
abline(v=quantile(turtle$spend, 0.25), col="purple", lwd=2, lty=2)
abline(v=quantile(turtle$spend, 0.75), col="purple", lwd=2, lty=2)

# Add a legend
legend("topleft", 
       legend=c("Density", "Mean", "Median", "Quartiles"),
       col=c("darkblue", "red", "darkgreen", "purple"),
       lwd=c(2,2,2,2),
       lty=c(1,1,1,2))

# Boxplot for spend (spending score)
boxplot(turtle$spend,
        main="Boxplot of Spending Score",
        ylab="Spending Score",
        col="lightblue")



# Boxplot of loyalty points by gender
ggplot(turtle, aes(x = gender, y = loyalty, fill = gender)) +
  geom_boxplot() +
  labs(title = "Loyalty Points Distribution by Gender",
       x = "Gender",
       y = "Loyalty Points")


# Boxplot of loyalty points by education
ggplot(turtle, aes(x = education, y = loyalty, fill = education)) +
  geom_boxplot() +
  labs(title = "Loyalty Points Distribution by education",
       x = "education",
       y = "Loyalty Points")


# Scatterplot of loyalty points vs age
ggplot(turtle, aes(x = jitter(age), y = loyalty)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Age vs Loyalty points", x = "Age", y = "Loyalty points")


# Scatterplot of loyalty points vs pay
ggplot(turtle, aes(x = jitter(pay), y = loyalty)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Pay vs Loyalty points", x = "Pay", y = "Loyalty points")



# Scatterplot of loyalty points vs spend (spending score)
ggplot(turtle, aes(x = jitter(spend), y = loyalty)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Spending score vs Loyalty points", x = "Spending score", y = "Loyalty points")


# Scatterplot of pay (remuneration) vs spend (spending score)
ggplot(turtle, aes(x = jitter(pay), y = spend)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Pay vs Spending Score", x = "Pay", y = "Spending Score")



# Scatterplot of age vs spend (spending score)
ggplot(turtle, aes(x = jitter(age), y = spend)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Age vs Spending Score", x = "Age", y = "Spending Score")


# Scatterplot of age vs pay (remuneration)
ggplot(turtle, aes(x = jitter(age), y = pay)) +
  geom_point(alpha = 0.5) +
  geom_smooth()+
  labs(title = "Age vs Pay", x = "Age", y = "Pay")



### Observations from analysis ###


# loyalty points

# The distribution of the 'loyalty' variable is uneven showing a positive/right skew.
# This is shown by the Mean (1578) being greater than the Median (1276).
# The positive skew indicates that while most customers have moderate loyalty point balances, 
# there's a smaller group of high-value customers with substantially larger point balances 
# pulling the mean upward.
# The density plot also shows multiple peaks, indicating a multimodal distribution.
# The large range (minimum=25, maximum=6847) suggests there are customers at various stages:
   # New or occasional customers (near minimum)
   # Regular customers (around median)
   # Highly engaged, long-term loyal customers (upper quartile and beyond)
# This type of distribution is very common in loyalty programs and reflects the 
# Pareto principle (80/20 rule) where a smaller percentage of customers typically account 
# for a disproportionate amount of business value 


# gender

# The data contains uneven distributions of gender Male(880),Female(1120)
# On average, male and females both accumulate loyalty points equally.
# Outliers exist for both genders when analysing loyalty points,with females having 
# a wider outlier spread.


# education

# 'Basic' education customers, accumulate on average higher loyalty points than
# the rest of education categories and also don't show any presence of outliers.
# However there is potential presence of outliers for the other educational categories.


# Age

# Central tendency: The mean (39.49) and median (38) are fairly close, suggesting 
# the distribution is reasonably symmetric.
# Spread: The IQR (Q3-Q1 = 20 years) indicates moderate variability in ages.
# Range: Ages span from 17 to 72 years, meaning there are both young and elderly
# people in the sample.
# no correlation between age and loyalty points.



# Pay

# Shape of distribution: The mean (48.08) is slightly higher than the median (47.15), suggesting a slight positive skew, but they're close enough that the distribution is fairly symmetric.
# Spread: The interquartile range (Q3-Q1 = 33.62) indicates moderate variability in income.
# Range: Income values span from 12.30 to 112.34, with a range of 100.04. This wide range could indicate some outliers on the higher end.
# Data concentration: Half of the falls between 30.34 and 63.96, suggesting most customers have incomes in this moderate range.
# Potential outliers: The maximum (112.34) is considerably higher than Q3, which could indicate some high-income outliers.


# The line of best fit is showing an upwards positive trend, indicating there
# is a strong linear relationship between pay and loyalty points
# We can also see that  majority of the dots are clustered at lower values
# of pay (15-50), and they are darker, meaning there are many customers with lower
# pay values within the data.



# spend (spending score)


# Perfect symmetry: The mean and median are exactly equal (both 50), which strongly suggests a symmetric distribution. This could indicate a normal distribution or another symmetric distribution shape.
# Range: The spending scores range from 1 to 99, as weve been told this variable is a score between 1-100 from the metadata
# Quartile positions: The distance from minimum to Q1 (31 points) is similar to the distance from Q3 to maximum (26 points), further supporting symmetry.
# Interquartile range: The IQR (Q3-Q1 = 41) is quite large, indicating substantial spread in spending behavior among the middle 50% of the data.



# The line of best fit is showing an upwards positive trend, indicating there
# is a strong linear relationship between spending score and loyalty points
# We can also see that  majority of the dots are clustered at middle values
# of spending score (around the 50 mark), and they are darker, meaning there are 
# many customers with mid spending scores within the data.



# outlier analysis

## outliers - identified using rstatix library, identify_outliers function
outlier_loyalty <-identify_outliers(data=turtle,variable = 'loyalty')
outlier_pay <- identify_outliers(data=turtle,variable = 'pay')
outlier_spend <- identify_outliers(data=turtle,variable = 'spend')
outlier_age <- identify_outliers(data=turtle,variable = 'age')


# summary statistics of outliers
summary(outlier_loyalty)
var(outlier_loyalty$loyalty)
sd(outlier_loyalty$loyalty)

# Histogram of loyalty point outliers
hist(outlier_loyalty$loyalty, main='Distribution of Loyalty Outliers', xlab='Loyalty')


# Extract outlier values
outlier_values <- outlier_loyalty$loyalty


# Create a dataframe of non-outliers
non_outlier_turtle <- turtle %>%
  filter(!loyalty %in% outlier_values)

# Calculate descriptive statistics for non-outliers
summary(non_outlier_turtle$loyalty)
sd(non_outlier_turtle$loyalty)
var(non_outlier_turtle$loyalty)
IQR(non_outlier_turtle$loyalty)


# plot outlier rows on a scatterplot - pay vs loyalty
plot(outlier_loyalty$pay,outlier_loyalty$loyalty, main='relationship between pay and loyalty - outlier data',
     xlab='pay',ylab='loyalty')
cor(outlier_loyalty$pay,outlier_loyalty$loyalty)


# plot outlier rows on a scatterplot - spend vs loyalty
plot(outlier_loyalty$spend,outlier_loyalty$loyalty)
cor(outlier_loyalty$spend,outlier_loyalty$loyalty)

# plot outlier rows on a scatterplot - age vs loyalty
plot(outlier_loyalty$age,outlier_loyalty$loyalty)
cor(outlier_loyalty$age,outlier_loyalty$loyalty)


# outliers by gender
table(outlier_loyalty$gender)

# outliers by education
table(outlier_loyalty$education)

# plot outlier rows on a boxplot - pay vs gender
ggplot(outlier_loyalty, aes(x = gender, y = pay)) +
  geom_boxplot() +
  labs(title = "Income Distribution by gender - outlier data",
       x = "Gender",
       y = "Income")


# plot outlier rows on a boxplot - pay vs education
ggplot(outlier_loyalty, aes(x = education, y = pay)) +
  geom_boxplot() +
  labs(title = "Income Distribution by education - outlier data",
       x = "Education",
       y = "Income")
# data quality issue on this to be investigated by Turtle Games
# For postgraduates, Q1 and Q2 were the same at 63.96 - investigate
# For diploma, Q2 and Q3 were the same at 84.46 - investigate


# create an income range column
outlier_loyalty <- outlier_loyalty %>%
  mutate(pay_range = case_when(
    pay <= quantile(pay, 0.25) ~ "Lower",
    pay > quantile(pay, 0.25) & pay <= quantile(pay, 0.75) ~ "Mid",
    pay > quantile(pay, 0.75) ~ "Higher",
    TRUE ~ "Unknown"
  ))

# group income ranges by average loyalty points
avg_loyalty_pay_range_outlier <- outlier_loyalty %>%
  group_by(pay_range) %>%
  summarize(avg_loyalty = mean(loyalty))


# visualise average loyalty by income range (outlier data)
ggplot(avg_loyalty_pay_range_outlier, aes(x = pay_range, y = avg_loyalty)) +
  geom_bar(stat='identity') +
  labs(title = "Average loyalty points by pay range - outlier data",
       x = "Pay range",
       y = "Average loyalty points")


# 266 out of 2000 records (13.3%) were identified as outliers 
# males accounting for 55% and females 45% of outliers
# 48% of outliers are graduates - the majority
# pay and loyalty points in the outlier data are postively correlated (79%)
# average loyalty points in outlier group = 4,328
# average loyalty points in non outlier group = 1,156
# 4 times as many loyalty points in outlier group - worth targetting for turtle games
# customers in higher pay range (top 26%) accumulate highest average loyalty points (5,535)
# Action - target high income customers for more loyalty
# leverage strong pay-loyalty correlation to design income informed loyalty segments and targeted marketing




###############################################################################
###############################################################################

# Assignment 6 scenario

## In Module 5, you were requested to redo components of the analysis using Turtle Games’s preferred 
## language, R, in order to make it easier for them to implement your analysis internally. As a final 
## task the team asked you to perform a statistical analysis and create a multiple linear regression 
## model using R to predict loyalty points using the available features in a multiple linear model. 
## They did not prescribe which features to use and you can therefore use insights from previous modules 
## as well as your statistical analysis to make recommendations regarding suitability of this model type,
## the specifics of the model you created and alternative solutions. As a final task they also requested 
## your observations and recommendations regarding the current loyalty programme and how this could be 
## improved. 

################################################################################

## Assignment 6 objective
## You need to investigate customer behaviour and the effectiveness of the current loyalty program based 
## on the work completed in modules 1-5 as well as the statistical analysis and modelling efforts of module 6.
##  - Can we predict loyalty points given the existing features using a relatively simple MLR model?
##  - Do you have confidence in the model results (Goodness of fit evaluation)
##  - Where should the business focus their marketing efforts?
##  - How could the loyalty program be improved?
##  - How could the analysis be improved?

################################################################################

## Assignment 6 assignment: Making recommendations to the business.

## 1. Continue with your R script in RStudio from Assignment Activity 5: Cleaning, manipulating, and 
##     visualising the data.
## 2. Load and explore the data, and continue to use the data frame you prepared in Module 5.
## 3. Perform a statistical analysis and comment on the descriptive statistics in the context of the 
##     review of how customers accumulate loyalty points.
##  - Comment on distributions and patterns observed in the data.
##  - Determine and justify the features to be used in a multiple linear regression model and potential
##.    concerns and corrective actions.
## 4. Create a Multiple linear regression model using your selected (numeric) features.
##  - Evaluate the goodness of fit and interpret the model summary statistics.
##  - Create a visual demonstration of the model
##  - Comment on the usefulness of the model, potential improvements and alternate suggestions that could 
##     be considered.
##  - Demonstrate how the model could be used to predict given specific scenarios. (You can create your own 
##     scenarios).
## 5. Perform exploratory data analysis by using statistical analysis methods and comment on the descriptive 
##     statistics in the context of the review of how customers accumulate loyalty points.
## 6. Document your observations, interpretations, and suggestions based on each of the models created in 
##     your notebook. (This will serve as input to your summary and final submission at the end of the course.)

################################################################################


# re-confirm the data frame and its data types
head(turtle)
str(turtle)


# determine correlation between numeric variables
correlation_matrix <- cor(turtle[, sapply(turtle, is.numeric)])
correlation_matrix

# visualise correlation between numeric variables
ggcorrplot(correlation_matrix,lab = T)


# pay and spend have the highest correlation with loyalty
# correlation between pay&loyalty = 0.62
# correlation between spend&loyalty = 0.67
# no correlation between age&loyalty (-0.04)
# no multicollinearity between pay and spend (correlation=0.01)



# scatterplot - pay vs loyalty
ggplot(turtle, aes(x = jitter(pay), y = loyalty)) +
  geom_point(alpha = 0.5) +
  labs(title = "Pay vs Loyalty points", x = "Pay", y = "Loyalty points")


# scatterplot - spend vs loyalty
ggplot(turtle, aes(x = jitter(spend), y = loyalty)) +
  geom_point(alpha = 0.5) +
  labs(title = "Spending score vs Loyalty points", x = "Spending score", y = "Loyalty points")


# scatterplot - age vs loyalty
ggplot(turtle, aes(x = jitter(age), y = loyalty)) +
  geom_point(alpha = 0.5) +
  labs(title = "Age vs Loyalty points", x = "Age", y = "Loyalty points")

# scatterplot - pay vs spend
ggplot(turtle, aes(x = jitter(pay), y = spend)) +
  geom_point(alpha = 0.5) +
  labs(title = "Pay vs Spending score", x = "Pay", y = "Spending score")

# scatterplot - age vs spend
ggplot(turtle, aes(x = jitter(age), y = spend)) +
  geom_point(alpha = 0.5) +
  labs(title = "Age vs Spending score", x = "Age", y = "Spending score")

# scatterplot - age vs pay
ggplot(turtle, aes(x = jitter(age), y = pay)) +
  geom_point(alpha = 0.5) +
  labs(title = "Age vs Pay", x = "Age", y = "Pay")



# pay vs loyalty: There's a positive trend suggesting that higher pay might be associated with higher loyalty points.
# spend vs loyalty: A positive trend is visible, suggesting that higher spending scores might correlate with higher loyalty points.
# age vs loyalty: The scatter plot suggests some clustering, indicating different age groups might have varying loyalty points.
# pay vs spend: There appears to be a positive trend indicating that higher pay might be associated with higher spending scores
# age vs spend: The scatter plot shows some clustering but does not show a clear trend.
# age vs pay: This scatter plot shows several clusters, which might indicate different groups of people with distinct pay patterns across age ranges.



### measures of shape ###


# shapiro wilk - loyalty
shapiro.test(turtle$loyalty)
# W = 0.84307 is significantly below 1, suggesting the data deviates from a normal distribution
# p-value(<2.2e-16) assuming alpha(significance level)=0.05, we reject the null hypothesis as there is evidence the data is not normally distributed

# shapiro wilk - pay (income)
shapiro.test(turtle$pay)
# W = 0.96768 is reasonably close to 1, indicating potential for a normal distribution
# p-value(<2.2e-16) assuming alpha(significance level)=0.05, we reject the null hypothesis as there is evidence the data is not normally distributed
# even though our W value is close to 1, our P value is so small that we would conclude the data is not normally distributed

# shapiro wilk - spend (spending score)
shapiro.test(turtle$spend)
# W = 0.96835 is reasonably close to 1, indicating potential for a normal distribution
# p-value(<2.2e-16) assuming alpha(significance level)=0.05, we reject the null hypothesis as there is evidence the data is not normally distributed
# even though our W value is close to 1, our P value is so small that we would conclude the data is not normally distributed

# skewness - loyalty
skewness(turtle$loyalty)
# skew = 1.463694 suggests a positively skewed distribution
# majority of the customers have lower loyalty points, and a smaller group of customers with higher loyalty points

# skewness - pay
skewness(turtle$pay)
# skew = 0.412842 suggests slight positive skew
# majority of the customer base falls within a lower-moderate income range
# there is a smaller portion of customers who earn significantly higher incomes

# skewness - spend
skewness(turtle$spend)
# skew = -0.04161713 suggests slight negative skew/almost symmetrical
# customers exhibit a relatively balanced range of spending behavior. 
# There are not significantly more customers with very low or very high spending scores.

# kurtosis - loyalty
kurtosis(turtle$loyalty)
# kurtosis = 4.70883, indicates heaver tails and sharper peaks (leptojurtic distribution)
# indicates presence of outliers i.e customers with extremely high/low loyalty points
# many customers have loyalty points clustered around the mean
# kurtosis value is large, therefore loyalty points are not normally distributed

# kurtosis - pay
kurtosis(turtle$pay)
# kurtosis = 2.591949, indicates thinner tails and flatter peak (platykurtic distribution)
# indicates customer income are more varied and less clustered around the mean
# few customers with very high or very low incomes

# kurtosis - spend
kurtosis(turtle$spend)
# kurtosis = 2.110333, indicates thinner tails and flatter peak (platykurtic distribution)
# indicates spending scores are more varied and less clustered around the mean
# few customers with very high or very low spending scores



########## Multiple Linear Regression ##########

# Note - due to the significant linear relationship between Pay/Spend & Loyalty
# We will use these 2 variables to predict loyalty points in our MLR model.


##### model 1 #####
# pay and spend to predict loyalty
model_1 <- lm(loyalty ~ pay+spend,data=turtle)


# view the model summary
summary(model_1)
# R-Squared = 83% - GOOD
# P value: < 2.2e-16 - statistically significant result


# coefficients from model_1
coefficients(model_1)

# residuals from model_1 - scatterplot
plot(model_1$residuals)


# residuals from model_1 - qqplot
qqnorm(residuals(model_1),main='QQ plot for Model 1 to predict Loyalty')
qqline(residuals(model_1), col = 'blue')


# VIF to check for multicollinearity 
vif(model_1)
# VIF equals 1 for both pay and spend so there is no multicollinearity

# test for heteroscedasticity using bp test
bptest(model_1)
# LM Test p-value is less than our significance level (alpha=0.05), 
# reject the null hypothesis and assume there is evidence of heteroscedasticity

# Add predicted values to data
turtle$predicted_loyalty <- predict(model_1)

# Plot predicted vs actual
ggplot(turtle, aes(x = predicted_loyalty, y = loyalty)) +
  geom_point(color = "steelblue") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Predicted vs Actual Loyalty",
       x = "Predicted Loyalty",
       y = "Actual Loyalty") +
  theme_minimal()


##### model 2 ######
# pay and spend to predict 'log' loyalty

# create a new variable in the turtle dataframe for the log of 'loyalty'
turtle <- mutate(turtle,log_loyalty = log(loyalty))

# sense check column was added
head(turtle)


# model_2 - pay and spend to predict 'log' loyalty
model_2 <- lm(log_loyalty ~ pay+spend,data=turtle)

# view the model_2 summary
summary(model_2)
# R-Squared = 80% - GOOD but less than model_1
# P value: < 2.2e-16 - statistically significant result

# coefficients from model_2
coefficients(model_2)

# residuals from model_2 - scatterplot
plot(model_2$residuals)

# residuals from model_2 - qqplot
qqnorm(residuals(model_2),main='QQ plot for Model 2 to predict LOG Loyalty')
qqline(residuals(model_2), col = 'green')

# VIF to check for multicollinearity 
vif(model_2)
# VIF equals 1 for both pay and spend so there is no multicollinearity

# test for heteroscedasticity using bp test
bptest(model_2)
# LM Test p-value is less than our significance level (alpha=0.05), 
# reject the null hypothesis and assume there is evidence of heteroscedasticity


# Add predicted values to data
turtle$predicted_log_loyalty <- predict(model_2)

# Plot predicted vs actual
ggplot(turtle, aes(x = predicted_log_loyalty, y = log_loyalty)) +
  geom_point(color = "steelblue") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Predicted vs Actual LOG Loyalty",
       x = "Predicted LOG Loyalty",
       y = "Actual LOG Loyalty") +
  theme_minimal()


# add predicted values to the data (original scale)
turtle$predicted_loyalty_log_model <- exp(predict(model_2))

# Plot predicted vs actual (original scale) for model 2
ggplot(turtle, aes(x = predicted_loyalty_log_model, y = loyalty)) +
  geom_point(color = "steelblue") +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Predicted vs Actual Loyalty (Original Scale) - Log Model",
       x = "Predicted Loyalty (Log Model)",
       y = "Actual Loyalty") +
  theme_minimal()


# residual analysis

# Residuals for model 1 (actual - predicted)
turtle$residual_model1 <- turtle$loyalty - turtle$predicted_loyalty

# Residuals for model 2 (on original scale after exp transformation)
turtle$residual_model2 <- turtle$loyalty - turtle$predicted_loyalty_log_model


# RMSE for Model 1
rmse_model1 <- rmse(turtle$loyalty, turtle$predicted_loyalty)

# RMSE for Model 2 (after converting back to original scale)
rmse_model2 <- rmse(turtle$loyalty, turtle$predicted_loyalty_log_model)


# Print both RMSEs
cat("RMSE for Model 1 (linear on loyalty):", rmse_model1, "\n")
cat("RMSE for Model 2 (linear on log loyalty, back-transformed):", rmse_model2, "\n")



# residual plot for model 1
ggplot(turtle, aes(x = predicted_loyalty, y = residual_model1)) +
  geom_point(color = "steelblue") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residual Plot - Model 1 (Predicting Loyalty)",
       x = "Predicted Loyalty",
       y = "Residuals") +
  theme_minimal()


# residual plot for model 2
ggplot(turtle, aes(x = predicted_loyalty_log_model, y = residual_model2)) +
  geom_point(color = "darkgreen") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residual Plot - Model 2 (Predicting log(Loyalty), back-transformed)",
       x = "Predicted Loyalty (from log model)",
       y = "Residuals") +
  theme_minimal()



# model 1
# R-Squared = 83%, RMSE = 534
# negatives - presence of heteroscedasticity, outliers in loyalty, non normality


# model 2
# R-Squared = 80%, RMSE = 866 - worse than model 1
# negatives - presence of heteroscedasticity


# models not validated using train/test split which might help the fit
# investigate other models, adding new features to the models
# i.e customer purchase frequency/time since last purchase/sales
# corrective actions - transform loyalty points, investigate multimodal distribution, outlier management
# include time/date variables to check for autocorrelation assumption




# extension - for stakeholder to input data for pay/spend to predict loyalty


# Stakeholder inputs
#stakeholder_data <- data.frame(
#  pay = c(20, 50),       # replace with their values
#  spend = c(15, 40),     # replace with their values
#)

# Predict loyalty
#stakeholder_data$predicted_loyalty <- predict(model_1, newdata = stakeholder_data)
#prediction_results <- cbind(stakeholder_data, predicted_loyalty_points = predicted_loyalty)
#print(prediction_results)



# NOTE - further statistical analysis and MLR analysis can be found in the technical report

###############################################################################
###############################################################################

### Thank you for reading ###

### Harshdeep Kohli ###
