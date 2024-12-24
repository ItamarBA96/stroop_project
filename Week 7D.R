# Script Name: regression.R
# Purpose: Runs regression analysis to measure Stroop effect.
# Author: Itamar Ben Arie
# Date: 2023-12-20

# R course for beginners
# Week 7, Part D
# assignment by Itamar Ben Arie, id 207023748

# Load the lme4 package
library(lme4)

# Load the filtered data
load("filtered_data.RData")

# Build the mixed-effects regression model
reaction_time_model <- lmer(rt ~ task * congurancy + (1 | subject), data = filtered_df)

# Display the model summary
summary(reaction_time_model)

# Interpretation:
# 1. The average reaction time (baseline condition: ink_naming, congruent) is 1037 milliseconds.
# 2. The task "word_reading" reduces reaction time by 364 milliseconds compared to "ink_naming."
# 3. The "incongruent" condition increases reaction time by 84 milliseconds compared to "congruent."
