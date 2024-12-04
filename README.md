# Replication of How Quick Decisions Illuminate Moral Character by Critcher et al. (2013)

This project replicates **Experiment 1 from "How Quick Decisions Illuminate Moral Character"**, which examines how decision-making speed influences perceptions of moral character. Participants will read scenarios about two characters who make moral or immoral decisions either quickly or slowly and will rate the characters on moral principles, certainty, impulsiveness, and quickness. The study aims to explore how decision speed and morality interact to shape judgments of moral character.

---

## File Naming Conventions

To ensure clarity and reproducibility, the following file naming conventions are used in this repository:

1. **Raw Data Files**:
   - Individual participant data files are stored in the `data/` folder with the `.csv` extension.
   - Each file is named using a unique participant identifier (e.g., `participant_001.csv`).

2. **Cleaned Data**:
   - `quick_decisions_1_clean_data.csv`: The cleaned and processed dataset used for analysis.

3. **Scripts**:
   - `combine_clean_data.R`: R script used to combine, clean, and process raw data into a final cleaned dataset.

4. **Documentation**:
   - `data_dictionary.xlsx`: A data dictionary describing all variables in the cleaned dataset, including their types, levels, and meanings.

---

## Data Organization

The repository is structured as follows:

- **`data/`**:
  - Contains raw data, cleaned data, and associated documentation.
  - Files in this folder include:
    - **`quick_decisions_1_clean_data.csv`**: Final cleaned dataset.
    - **`data_dictionary.xlsx`**: A detailed description of all variables in the dataset.
    - **`.gitkeep`**: A placeholder file to retain the folder structure in the repository.

- **`combine_clean_data.R`**:
  - Script to merge and clean participant data files.
  - Includes filtering steps to remove invalid responses (e.g., failed attention checks) and variable transformations (e.g., reverse coding of responses).

---

## Manuscripts

This project replicates findings from Experiment 1 in Critcher et al. (2013). The final results aim to provide insights into how decision speed and morality interact to shape perceptions of moral character. The cleaned dataset and scripts can be used to generate figures, tables, and statistical models for analysis.

---

## Authors

This project was conducted by:

- Harley Clifton
- Sara Hamidi
- Prosperity Land
- Bella Mullen

---

If you have any questions about the repository or the replication project, feel free to contact us through GitHub.





