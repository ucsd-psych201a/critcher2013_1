# Load necessary libraries
library(dplyr)
library(stringr)

path_to_csvs <- "/Users/bellamullen/Documents/CSS_204/replication_project/pilot_B/pilot_B_data"

# Combine all CSV files into one dataset
csv_files <- list.files(path = path_to_csvs, pattern = "*.csv", full.names = TRUE)

cleaned_data <- csv_files %>%
  lapply(read.csv) %>%   
  bind_rows()

# Save the combined dataset as 'combined_data.csv'
write.csv(cleaned_data, "/Users/bellamullen/Documents/CSS_204/replication_project/pilot_B/combined_pilotB.csv", row.names = FALSE)

# Add an 'ID' column with the file name (excluding the '.csv' extension)
cleaned_data <- list.files(path = path_to_csvs, pattern = "*.csv", full.names = TRUE) %>%
  lapply(function(file) {
    data <- read.csv(file)
    data$ID <- str_replace(basename(file), "\\.csv$", "")  # Extract the file name and remove '.csv'
    return(data)
  }) %>%
  bind_rows()

# Clean the 'response' column to extract content between ':' and '}'
cleaned_data <- cleaned_data %>%
  mutate(response = str_extract(response, "(?<=:)[^}]+"))

# Remove rows where the 'response' column is '0'
cleaned_data <- cleaned_data %>%
  filter(response != "0")

# Remove specified columns from the dataset
cleaned_data <- cleaned_data %>%
  select(-rt, -stimulus, -trial_type, -plugin_version, -question_order)

# Add a new column 'FastorSlow' based on the 'trial_index' values
cleaned_data <- cleaned_data %>%
  mutate(FastorSlow = case_when(
    trial_index %in% c(4, 5, 6, 7, 8, 9, 10, 11, 12, 13) ~ "f",
    trial_index %in% c(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23) ~ "s",
    trial_index == 24 ~ "attention",
    trial_index == 25 ~ "feedback",
    TRUE ~ NA_character_  # Assign NA for any other values of 'trial_index'
  ))

# Add a new column 'measure' based on the 'trial_index' values
cleaned_data <- cleaned_data %>%
  mutate(measure = case_when(
    trial_index %in% c(8, 9, 10, 11, 18, 19, 20, 21) ~ "certainty",
    trial_index %in% c(5, 6, 7, 15, 16, 17) ~ "character",
    trial_index %in% c(12, 13, 22, 23) ~ "impulsivity",
    trial_index %in% c(4, 14) ~ "quickness",
    trial_index == 24 ~ "attention",
    trial_index == 25 ~ "feedback",
    TRUE ~ NA_character_  # Assign NA for any other values of 'trial_index'
  ))


# Save the combined and cleaned dataset
write.csv(cleaned_data, "/Users/bellamullen/Documents/CSS_204/replication_project/pilot_B/cleaned_combined_pilotB.csv", row.names = FALSE)

