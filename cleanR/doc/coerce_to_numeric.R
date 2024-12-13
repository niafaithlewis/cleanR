## -----------------------------------------------------------------------------
library(cleanR)

# Example dataset
plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

# Preview the data
head(plants_clean)

## -----------------------------------------------------------------------------
# Coerce the target_weight column to numeric
updated_data <- coerce_numeric_columns(
  data = plants_clean, 
  numeric_columns = c("target_weight")
)

# Print the updated data
print(updated_data)

