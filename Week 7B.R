# Script Name: preprocessing_filtered_data.R
# Purpose: Preprocesses the Stroop task data for further analysis.
# Author: Itamar Ben Arie
# Date: 2023-12-20

# R course for beginners
# Week 7, Part B
# assignment by Itamar Ben Arie, id 207023748

load("raw_data.RData")

# Filter out invalid rows
nrow(df)
filtered_df <- df |>
  filter(!is.na(rt) & rt > 300 & rt < 3000)

# Display the filtered DataFrame
head(filtered_df)
nrow(filtered_df)

# Calculate total original trials per subject
original_trials <- df |>
  group_by(subject) |>
  summarise(total_trials_original = n())

# Calculate total remaining trials per subject
remaining_trials <- filtered_df %>%
  group_by(subject) %>%
  summarise(total_trials_remaining = n())

# Combine original trials and remaining trials
percent_remaining <- remaining_trials %>%
  left_join(original_trials, by = "subject") %>%
  mutate(percent_remaining = (total_trials_remaining / total_trials_original) * 100)

# Display the percentage remaining per subject
print(head(percent_remaining))

# Display the percentage remaining per subject
print(head(percent_remaining))

# Calculate mean and standard deviation of the percentage remaining
mean_remaining <- mean(percent_remaining$percent_remaining, na.rm = TRUE)
sd_remaining <- sd(percent_remaining$percent_remaining, na.rm = TRUE)

print(paste("Mean percentage remaining:", mean_remaining))
print(paste("Standard deviation of percentage remaining:", sd_remaining))

# Save filtered_data as a CSV & R file.
write.csv(filtered_df, "filtered_data.csv", row.names = FALSE)
save(filtered_df, file = "filtered_data.RData")
