# script to clean three quick decisons group's data

library(tidyr)
library(dplyr)

# File path
file_path <- "/Users/bellamullen/Documents/GITHUB/critcher2013_1/data/quick_decisions_combined.csv"

# Load the data
all_data <- read.csv(file_path)

long_data <- all_data %>%
  pivot_longer(
    cols = contains("_Q"),  # Select all columns containing "_Q"
    names_to = "question",  # Keep the entire column name in 'question'
    values_to = "value"  # Column to hold the values
  )

# Add trial_index column
long_data <- all_data %>%
  pivot_longer(
    cols = contains("_Q"),  # Select all columns containing "_Q"
    names_to = "question",  # Keep the full name in 'question'
    values_to = "value"     # Column to hold the values
  ) %>%
  mutate(
    trial_index = case_when(
      question == "Justin_Q1" ~ 1,
      question == "Justin_Q2" ~ 2,
      question == "Justin_Q3" ~ 3,
      question == "Justin_Q4" ~ 4,
      question == "Justin_Q5" ~ 5,
      question == "Justin_Q6" ~ 6,
      question == "Justin_Q7" ~ 7,
      question == "Justin_Q8" ~ 8,
      question == "Justin_Q9" ~ 9,
      question == "Justin_Q10" ~ 10,
      question == "Nate_Q1" ~ 11,
      question == "Nate_Q2" ~ 12,
      question == "Nate_Q3" ~ 13,
      question == "Nate_Q4" ~ 14,
      question == "Nate_Q5" ~ 15,
      question == "Nate_Q6" ~ 16,
      question == "Nate_Q7" ~ 17,
      question == "Nate_Q8" ~ 18,
      question == "Nate_Q9" ~ 19,
      question == "Nate_Q10" ~ 20,
      TRUE ~ NA_real_  # Handle unexpected cases
    )
  )


