# Turtle Games (Final Grade: Pending)
Turtle Games - Advanced analytics for organisational impact

Project Summary: In this 6 week analytics project, my objective was to investigate customer loyalty and optimise sales performance for Turtle Games,  a global gaming retailer and manufacturer. I leveraged predictive modelling (linear regression, K means clustering) and machine learning (natural language processing) to help me complete this project. 

Tools used: Python & R

The business problem I identified centres around underperforming sales performance at Turtle Games.

This report considered the following main questions:

**1. How to customers accumulate loyalty points?**

**2. How can customers be segmented into groups?**

**3. How can customer reviews be used to inform marketing campaigns?**

**4. How can descriptive statistics be used to enhance insights?**


**Analytical Approach Highlights:**

**Data import and wrangling**: Raw data was provided as a .csv file which was loaded into Jupyter Notebook using Pandas. Data was validated using a custom built user defined function to check for duplicates/null values and data types. Columns were renamed or dropped depending the focus of the analysis. Exploratory visualisation was used extensively.

**Predictive modelling and machine learning**: Utilised Skikit-learn, Scipy, Statsmodels libraries to conduct linear regression, K means clustering and decsion trees. Used Vader and TextBlob libraries to conduct natural language processing. Models were tested by evaluating all 6 assumptions for a linear regresstion model. Model validity was evaluated by using train/test splits and comparing RMSE and R-Squared.

**Strategic Recommendations**: Identified 5 distinct customer segments based on income and spending score to help Turtle Games for customised marketing campaigns. Identified outliers in the loyalty points variable, which strongly correlated with pay and suggested Turtle Games to leverage this segment to increase loyalty. Processed text data to identify common words and themes using wordclouds to help Turtle Games divert resources to customers leaving negative reviews.


**Presentation** - https://youtu.be/Mu08xcuKayA


**Key Insights and Recommendations:**


**Customer Segmentation**

1. K means clustering of income and spending score showed possibilities of 5 different customer groups:

Cluster 0 (Blue) - High Income, High Spending Score - "Luxury Enthusiasts" (18% of customers)
- Summary: Customers in this group have high remuneration (~ 60k€-105k€) and high spending scores (~ 60-100).
- Insight: Likely represents high-value customers who have significant purchasing power and spend a lot.
- Action: VIP customer service, premium loyalty programs, exclusive offers.

Cluster 1 (Orange) - Medium to Low Income, Medium Spending Score - "Value Seekers" (39% of customers)
- Summary: This cluster has remuneration ranging from ~30k€-60k€ and spending scores between ~40-60.
- Insight: Represents the general consumer group, spending moderately.
- Action: Marketing Strategy: Regular promotions, discounts, and personalized offers to encourage loyalty.

Cluster 2 (Green) - High Income, Low Spending Score - "Practical Professionals" (17% of customers)
- Summary: Customers here have high remuneration (~ 60k€-105k€) but low spending scores (~ 0-40).
- Insight: These customers can afford to spend but choose not to.
- Action: Marketing Strategy: Investigate barriers to spending (e.g., preferences, brand perception), offer tailored promotions.

Cluster 3 (Red) - Low Income, High Spending Score - "Aspirational Shoppers" (13% of customers)
- Summary: Customers in this group have low remuneration (~ 10k€-30k€) but high spending scores (~ 60-100)
- Insight: They may prioritize discretionary spending despite a lower income.
- Action: Marketing Strategy: Payment plans, installment options, or budget-friendly product lines.

Cluster 4 (Purple) - Low Income, Low Spending Score - "Budget-Conscious Consumers" (14% of customers)
- Summary: Customers in this group have low remuneration (~ 10k€-30k€) and low spending scores (~ 5-40).
- Insight: They are budget-conscious and spend very little.
- Action: Marketing Strategy: Cost-effective deals, discounts, and affordability-focused promotions.


![kmeans final](https://github.com/user-attachments/assets/0dd0ebec-0f87-4410-8013-10889b332f5a)


**Linear Regression**

1. Multiple Linear Regression models were built using income and spending to score to predict loyalty points
2. Achieved an R-Squared of 83%, but presence of heteroscedasticity and non normality of residuals undermined the validity of the model
3. Tried to address the issue of heteroscedasticity by LOG transforming loyalty points variable but this reduced R-Squared and still showed presence of heteroscedasticity
4. Recommended addressing data quality issues or using alternative models such as a weighted least sqaures regression to reduce heteroscedasticity


![correlation](https://github.com/user-attachments/assets/ef1806ff-dd61-4eff-9afe-45ef570859a0)

![MLR - model1 - python](https://github.com/user-attachments/assets/0fd8bed4-393b-41d7-bbbe-57a840168b5f)


**Natural Language processing** 

1. Sentiment analysis using TextBlob and Vader confirmed most reviews were positive
2. Recommended to invest in customer experience. Using positively mentioned words in advertising campaigns and addressing product quality and usability issues as highlighted in negative reviews.


![vader_review_histogram](https://github.com/user-attachments/assets/dc1716ba-0748-4384-80ce-256b20caa054)

![wordcloud_review](https://github.com/user-attachments/assets/96d53755-84d6-4773-98d6-b2e6f7d710dd)

![frequent_words_review](https://github.com/user-attachments/assets/3f7b06ba-3e6f-470b-9b4c-cdc6f5e7781b)


**Statistical analysis** 

1. Statistical analysis in R using histograms, boxplots allowed me to identify right skewness in loyalty points variable, as well as outliers accounting for 13.3% of the data
2. Conducted skewness and kurtosis tests e.g Shapiro Wilkes which confirmed non normality in loyalty points
3. Recommended to leverage the outliers as a strategic segment as they have on average 4 times as many loyalty points. Further analysis showed a 79% correlation between pay and loyalty in the outlier data with the top 25% income ranges accumulating the highest average loyalty points. Recommended enhanced loyalty programs for this segment.

![histogram loyalty](https://github.com/user-attachments/assets/925a72b6-c26c-4d7c-861c-13befd0cfb84)

![pay_loyalty_outlier_scatter](https://github.com/user-attachments/assets/7bdd7039-0c35-42b5-8160-0ba238899b8b)


**Professional Development and Impact:**

This project served as a deep dive into the intersection of data analytics and strategic business decision-making. The wide variety of skills and tools used (Python, R, MLR, K-means clustering, and NLP) really allowed me to understand and consolidate several key areas of analysis.
