# Load the required packages
library(cleanR)

file_path <- system.file("extdata", "plants_test.csv", package = "cleanR")
plants_clean <- read.csv(file_path)

head(plants_clean)

potential_typos <- identify_typos(plants_clean$treatment)

print(potential_typos)

#OR if the user knows the values that should be there: 
potential_typos <- identify_typos(plants_clean$treatment, expected_values = c("w", "d"))




