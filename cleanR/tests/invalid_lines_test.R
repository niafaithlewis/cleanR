# Load the required packages
library(cleanR)

plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

head(plants_clean)

invalid_lines <- detect_invalid_lines(plants_clean)

print(invalid_lines)
