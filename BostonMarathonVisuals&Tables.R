# Step One: Clear environment
##Cleaning everything out of the environment to make things clear and easy to use
rm(list = ls())

# Step Two: Load packages
##Load any necessary packages needed to wrangle and tidy the data to make 
##proper visualizations and tables 
suppressPackageStartupMessages({
  library(tidyverse)
})

# Step Three: Read in the data set
##Reading the csv file into R
boston <- read_csv("boston_marathon_2023.csv")

# Step Four: Look at the column names
##Looking at column names to see which are necessary and meaningful 
names(boston)

# Step Five: Clean and wrangle the data
##Clean and wrangle the data in order to keep necessary for data analysis and 
##proper comparisons
boston_clean <- boston |>
  select(
    age_group,
    gender,
    place_overall,
    place_gender,
    place_division,
    name,
    finish_net,
    finish_gun,
    finish_net_sec,
    finish_gun_sec,
    finish_net_minutes
  ) |>
  filter(
    !is.na(age_group),
    !is.na(gender),
    !is.na(finish_net_minutes)
  ) |>
  mutate(
    gender = str_to_upper(gender),
    age_group = factor(age_group)
  )

# Step Six: Preview the cleaned data
##Look at cleaned data 
head(boston_clean)
glimpse(boston_clean)

# Step Seven: Create summary table by gender
##Creates summary table by gender with the cleaned data for visualziations 
gender_summary <- boston_clean |>
  group_by(gender) |>
  summarize(
    runners = n(),
    mean_time = mean(finish_net_minutes),
    median_time = median(finish_net_minutes),
    min_time = min(finish_net_minutes),
    max_time = max(finish_net_minutes),
    .groups = "drop"
  )

gender_summary

# Step Eight: Create summary table by age group
##Making a summary table based off age to be looked at for comparison based off 
##age 
age_summary <- boston_clean |>
  group_by(age_group) |>
  summarize(
    runners = n(),
    mean_time = mean(finish_net_minutes),
    median_time = median(finish_net_minutes),
    min_time = min(finish_net_minutes),
    max_time = max(finish_net_minutes),
    .groups = "drop"
  )

age_summary

# Step Nine: Create summary table by age group and gender
##Now combining to create a summary table by age and gender to be able to use 
##data analysis to make accurate comparisons to each group. 
age_gender_summary <- boston_clean |>
  group_by(age_group, gender) |>
  summarize(
    runners = n(),
    mean_time = mean(finish_net_minutes),
    median_time = median(finish_net_minutes),
    .groups = "drop"
  )

age_gender_summary

# Graph One: Histogram of finish times
##Making a histogram of the runners finishing times 
ggplot(boston_clean, aes(x = finish_net_minutes)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribution of Boston Marathon Finish Times",
    x = "Net Finish Time (Minutes)",
    y = "Count"
  )

# Graph Two: Box plot of finish times by gender
##Making a new visualization of a box plot that represnets the finishign times 
##based on gender 
ggplot(boston_clean, aes(x = gender, y = finish_net_minutes)) +
  geom_boxplot() +
  labs(
    title = "Boston Marathon Finish Times by Gender",
    x = "Gender",
    y = "Net Finish Time (Minutes)"
  )

# Graph Three: Box plot of finish times by age group
##making another visualization to make a box plot based on finsihing race times 
##based off age group 
ggplot(boston_clean, aes(x = age_group, y = finish_net_minutes)) +
  geom_boxplot() +
  labs(
    title = "Boston Marathon Finish Times by Age Group",
    x = "Age Group",
    y = "Net Finish Time (Minutes)"
  )

# Graph Four: Box plot of finish times by age group and gender
##Making a visualization on group and gender based off the finishing times 
ggplot(boston_clean, aes(x = age_group, y = finish_net_minutes, fill = gender)) +
  geom_boxplot() +
  labs(
    title = "Finish Times by Age Group and Gender",
    x = "Age Group",
    y = "Net Finish Time (Minutes)"
  )

# Graph Five: Mean finish time by age group and gender
##Calculating the mean finish time based on age group and gender to make 
##meaningful comparisons between each group 
ggplot(age_gender_summary, aes(x = age_group, y = mean_time, group = gender, color = gender)) +
  geom_line() +
  geom_point(size = 2) +
  labs(
    title = "Average Finish Time by Age Group and Gender",
    x = "Age Group",
    y = "Average Net Finish Time (Minutes)"
  )

# Graph Six: Count of runners by age group and gender
##Calculating the counts of each runner based off their age and gender in order 
##to have a total and be able to at any necessary meaningful comparisons 
ggplot(boston_clean, aes(x = age_group, fill = gender)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Number of Runners by Age Group and Gender",
    x = "Age Group",
    y = "Count"
  )