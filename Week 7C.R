# R course for beginners
# Week 7, Part C
# assignment by Itamar Ben Arie, id 207023748

# Load the ggplot2 package
library(ggplot2)

load("filtered_data.RData")

# Calculate mean and SD for each condition
descriptive_stats <- filtered_df |>
  group_by(task, congurancy) |>
  summarise(
    mean_rt = mean(rt, na.rm = TRUE),  # Mean reaction time
    sd_rt = sd(rt, na.rm = TRUE)      # Standard deviation
  )

# Print all results (for all conditions)
print(descriptive_stats, n = Inf)

# Count unique levels of task and congurancy
table(filtered_df$task, filtered_df$congurancy)

# Create bar plot for mean reaction times
ggplot(descriptive_stats, aes(x = congurancy, y = mean_rt, fill = task)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = mean_rt - sd_rt, ymax = mean_rt + sd_rt),
                width = 0.2, position = position_dodge(0.9)) +
  labs(
    title = "Mean Reaction Time by Task and Congruency",
    x = "Congruency",
    y = "Mean Reaction Time (ms)"
  ) +
  theme_minimal()
