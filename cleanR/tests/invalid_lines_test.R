# Load the required packages
library(cleanR)

file_path <- system.file("extdata", "plants_test.csv", package = "cleanR")
plants_clean <- read.csv(file_path)

head(plants_clean)

invalid_lines <- detect_invalid_lines(plants_clean)

print(invalid_lines)
