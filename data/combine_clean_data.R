library(dplyr)
library(stringr)
library(tidyr)

#path to individual response folders
path_to_csvs <- "/Users/bellamullen/Documents/CSS_204/replication_project/final_files/final_data"

# Combine all CSV files into one dataset
csv_files <- list.files(path = path_to_csvs, pattern = "*.csv", full.names = TRUE)
cleaned_data <- csv_files %>%
  lapply(read.csv) %>%   
  bind_rows()

# Save the combined dataset as 'combined_pilotB.csv'
write.csv(cleaned_data, "/Users/bellamullen/Documents/CSS_204/replication_project/final_files/combined_final_data.csv", row.names = FALSE)

# Add an 'ID' column with the file name
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
    TRUE ~ NA_character_
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
    TRUE ~ NA_character_
  ))

# Create index mapping to ensure consistency
index_mapping <- cleaned_data %>%
  select(trial_index, FastorSlow, measure) %>%
  distinct()

# Complete the dataset to ensure all trial indexes exist for each ID
cleaned_data <- cleaned_data %>%
  complete(ID, trial_index = 4:25, fill = list(response = NA)) %>%
  left_join(index_mapping, by = "trial_index") %>%
  group_by(ID) %>%
  mutate(condition = first(condition, order_by = trial_index)) %>%
  ungroup()

# Rename 'FastorSlow.x' and 'measure.x' to 'FastorSlow' and 'measure'
# Remove 'FastorSlow.y' and 'measure.y'
cleaned_data <- cleaned_data %>%
  rename(
    FastorSlow = FastorSlow.x,
    measure = measure.x
  ) %>%
  select(-FastorSlow.y, -measure.y)

# Add a new column 'response_reverse' with reverse coding for specific questions
cleaned_data <- cleaned_data %>%
  mutate(
    response_reverse = case_when(
      trial_index %in% c(9, 10, 13, 19, 20, 23) & grepl("^[0-9]+$", response) ~ as.character(8 - as.numeric(response)),  # Reverse coding for numeric responses
      TRUE ~ response  # Keep original response for all others, including strings
    )
  )

# Save the combined and cleaned dataset
write.csv(cleaned_data, "/Users/bellamullen/Documents/CSS_204/replication_project/final_files/quick_decisions_1_clean_data.csv", row.names = FALSE)

