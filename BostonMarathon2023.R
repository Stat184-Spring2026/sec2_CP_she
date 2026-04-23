## Step One: Load package
library(tidyverse)

#Load Data set
boston_marathon_2023 <- read.csv("https://data.scorenetwork.org/data/boston_marathon_2023.csv")

# Step Two: Clean and prepare data
runners_clean <- boston_marathon_2023 |>
  mutate(
    age_group = str_trim(age_group),
    gender = str_to_title(gender),
    race_time = finish_net_sec / 60   # convert seconds to minutes
  ) |>
  select(name, age_group, gender, race_time, place_overall, place_gender, place_division) |>
  filter(
    !is.na(age_group),
    !is.na(gender),
    !is.na(race_time)
  )

# Step Three: Summary table
summary_table <- runners_clean |>
  group_by(age_group, gender) |>
  summarize(
    count = n(),
    average_time = mean(race_time),
    median_time = median(race_time)
  )

summary_table

# Step Four: Visualization 1 (Bar Chart)
ggplot(summary_table, aes(x = age_group, y = average_time, fill = gender)) +
  geom_col(position = "dodge") +
  labs(
    title = "Average Marathon Time by Age Group and Gender",
    x = "Age Group",
    y = "Average Time (minutes)"
  )

# Step Five: Visualization 2 (Boxplot)
ggplot(runners_clean, aes(x = age_group, y = race_time, fill = gender)) +
  geom_boxplot() +
  labs(
    title = "Race Time Distribution by Age Group and Gender",
    x = "Age Group",
    y = "Race Time (minutes)"
  )

# Step Six: Visualization 3 (Density Plot)
ggplot(runners_clean, aes(x = race_time, fill = gender)) +
  geom_density(alpha = 0.4) +
  labs(
    title = "Distribution of Race Times by Gender",
    x = "Race Time (minutes)",
    y = "Density"
  )