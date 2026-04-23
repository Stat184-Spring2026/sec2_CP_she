# Step One: Clear environment
rm(list = ls())

# Step Two: Load packages
suppressPackageStartupMessages({
  library(tidyverse)
})

# Step Three: Read in the dataset
boston <- read_csv("boston_marathon_2023.csv")

# Step Four: Look at the column names
names(boston)

# Step Five: Clean and wrangle the data
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
head(boston_clean)
glimpse(boston_clean)

# Step Seven: Create summary table by gender
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
ggplot(boston_clean, aes(x = finish_net_minutes)) +
  geom_histogram(bins = 40) +
  labs(
    title = "Distribution of Boston Marathon Finish Times",
    x = "Net Finish Time (Minutes)",
    y = "Count"
  )

# Graph Two: Boxplot of finish times by gender
ggplot(boston_clean, aes(x = gender, y = finish_net_minutes)) +
  geom_boxplot() +
  labs(
    title = "Boston Marathon Finish Times by Gender",
    x = "Gender",
    y = "Net Finish Time (Minutes)"
  )

# Graph Three: Boxplot of finish times by age group
ggplot(boston_clean, aes(x = age_group, y = finish_net_minutes)) +
  geom_boxplot() +
  labs(
    title = "Boston Marathon Finish Times by Age Group",
    x = "Age Group",
    y = "Net Finish Time (Minutes)"
  )

# Graph Four: Boxplot of finish times by age group and gender
ggplot(boston_clean, aes(x = age_group, y = finish_net_minutes, fill = gender)) +
  geom_boxplot() +
  labs(
    title = "Finish Times by Age Group and Gender",
    x = "Age Group",
    y = "Net Finish Time (Minutes)"
  )

# Graph Five: Mean finish time by age group and gender
ggplot(age_gender_summary, aes(x = age_group, y = mean_time, group = gender, color = gender)) +
  geom_line() +
  geom_point(size = 2) +
  labs(
    title = "Average Finish Time by Age Group and Gender",
    x = "Age Group",
    y = "Average Net Finish Time (Minutes)"
  )

# Graph Six: Count of runners by age group and gender
ggplot(boston_clean, aes(x = age_group, fill = gender)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Number of Runners by Age Group and Gender",
    x = "Age Group",
    y = "Count"
  )
