# script to clean three quick decisons group's data

library(tidyr)
library(dplyr)

# File path
file_path <- "/Users/bellamullen/Documents/GITHUB/critcher2013_1/data/quick_decisions_all_data.csv"

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

# Add a unique ID for each person
long_data <- long_data %>%
  mutate(ID = paste0(ceiling(row_number() / 20)))  # Assign IDs by group of 20 rows

# Add FastorSlow column
long_data <- long_data %>%
  mutate(FastorSlow = ifelse(trial_index <= 10, "f", "s"))  # Assign 'f' for 1-10 and 's' for 11-20

# Add a new column 'measure' based on the 'trial_index' values
long_data <- long_data %>%
  mutate(measure = case_when(
    trial_index %in% c(5,6,7,8,15,16,17,18) ~ "certainty",
    trial_index %in% c(2, 3, 4, 12, 13, 14) ~ "character",
    trial_index %in% c(9,10,19,20) ~ "impulsivity",
    trial_index %in% c(1, 11) ~ "quickness",
    TRUE ~ NA_character_
  ))

long_data <- long_data %>%
  mutate(
    response_reverse = case_when(
      is.na(value) ~ NA_character_,  # Retain NA if value is NA
      trial_index %in% c(6, 7, 10, 16, 17, 20) & !is.na(as.numeric(value)) ~ as.character(8 - as.numeric(value)),  # Reverse coding for numeric responses
      TRUE ~ as.character(value)  # Ensure the original value is cast to character
    )
  )

# Save the combined and cleaned dataset
write.csv(long_data, "/Users/bellamullen/Documents/GITHUB/critcher2013_1/data/quick_decisions_all_clean_data.csv", row.names = FALSE)


