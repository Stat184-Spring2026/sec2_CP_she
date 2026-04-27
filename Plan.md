# 2023 Boston Marathon - Project Plan 

---

## Goal 

Transform the raw 2023 Boston Marathon results into a structured interpretable 
dataset to examine meaningful patterns in runner performance, demographics, and 
race results using R and R studio. 

**Research Questions**
1. How does age group relate to marathon finish time?
2. Are there significant gender differences in finish times?

---

##Needs 

##Data Needs 
- 2023 Boston MArathon CSV dataset (boston_marathon_2023.csv)
- Key variables: age group, gender, finsih time, half split, and placement 
rankings 

### Technical Needs 
- R and R studio installed 
- Packages: tidyverse, lubridate, scales, knitr

### Knowledge Needs
- Data cleaning and wrangling in R (dplyr, tidyr)
- Data visualization using ggplot2
- Basic statistical testing (t-test, ANOVA, correlation)

---

## Steps

### Step 1 — Import & Inspect
- Load the CSV with read_csv()
- Explore structure using glimpse(), head(), and summary()
- Identify missing values and incorrect data types

### Step 2 — Clean & Wrangle
- Standardize gender labels (M/W → Male/Female)
- Convert age groups to an ordered factor
- Remove runners with missing half-split data (72 rows)
- Engineer new variables: finish_net_hours, split_type, pace_fade_ratio

### Step 3 — Descriptive Statistics
- Summarize finish times overall, by gender, and by age group
- Build a cross-tabulation of mean finish time by gender x age group

### Step 4 — Visualize
- Density curves by gender
- Boxplots by age group faceted by gender
- Line chart of mean finish time across age groups
- Bar chart of gender gap per age group
- Stacked bar of pacing strategy by gender
- Scatter plot of half split vs finish time

### Step 5 — Statistical Testing
- Welch's t-test for gender differences in finish time
- One-way ANOVA + Tukey HSD for age group differences
- Pearson correlation for half split vs finish time

### Step 6 — Summarize Findings
- Write up key results for each research question
- Interpret statistical outputs in plain language

---

## Authors

Shreya Chandanshive (svc6521@psu.edu), Eszter Badescu (efb5578@psu.edu), and Helly Patel (hbp5251@psu.edu)