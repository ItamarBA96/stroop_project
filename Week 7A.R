# Script Name: preprocessing_raw_data.R
# Purpose: Preprocesses the Stroop task data for further analysis.
# Author: Itamar Ben Arie
# Date: 2023-12-20

# R course for beginners
# Week 7, Part A
# assignment by Itamar Ben Arie, id 207023748

# Load the dplyr package
library(dplyr)

unzip("C:/Users/itama/Downloads/stroop_data.zip", exdir = "data")
file.exists("data")
file_list <- dir("data", full.names = TRUE)

# Create an empty DataFrame to start
df <- data.frame()

# For loop to read all files and combine them
for (file in file_list) {
  temp_data <- read.csv(file) 
  df <- rbind(df, temp_data) 
}

# Display the raw data
print(head(df))  
str(df)  
head(df) 

# Create 'task' and 'congurancy' columns with cbind
df <- cbind(df, task = ifelse(grepl("word", df$condition), "word_reading",
                              ifelse(grepl("ink", df$condition), "ink_naming", NA)))
df <- df |>
  mutate(
    congurancy = ifelse(grepl("incong", condition), "incongruent",
                        ifelse(grepl("cong", condition), "congruent", NA))
  )

# Display the result
head(df[, c("condition", "task", "congurancy")])

# Create an accuracy column
df$accuracy <- ifelse(df$participant_response == df$correct_response, 1, 0)

# Display the result
head(df[, c("participant_response", "correct_response", "accuracy")])

# Keep only relevant columns
df <- df |>
  select(subject, task, congurancy, block, trial, accuracy, rt)

# Display the updated DataFrame
head(df)

# Save raw_data as a CSV & R file.
write.csv(df, "raw_data.csv", row.names = FALSE)
save(df, file = "raw_data.RData")

