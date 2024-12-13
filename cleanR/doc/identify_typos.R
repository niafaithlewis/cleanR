## -----------------------------------------------------------------------------
library(cleanR)

# Sample data
plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

# Preview the data
head(plants_clean)


# Identify typos in the 'treatment' column
potential_typos <- identify_typos(plants_clean$treatment)

# Print the result
print(potential_typos)


# Example data with potential typos
data <- c("d", "dry", "w", "wet", "d", "w", "dr", "d")

# Identify typos in the custom data
potential_typos <- identify_typos(data)

# Print the result
print(potential_typos)

