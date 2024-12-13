## -----------------------------------------------------------------------------
library(cleanR)

# Example dataset
mousedata <- data.frame(
  treatment = c("d", "d", "d", "wet", "d", "w"),
  pot_id = c(1, 2, 3, 4, 5, 6),
  line = c("C1", "SXX1", "SC1", "SI1", "C1", "C1"),
  mom = c(86, 225, 231, 672, 2, 27),
  dad = c(59, 258, 245, 697, 44, 100),
  tray_id = c(1, 10, 1, 1, 1, 1),
  dry_weight = c(165, 168, 158, 170, 172, 160)
)

# Preview the data
head(mousedata)

## -----------------------------------------------------------------------------
# Detect invalid 'line' values
invalid_lines <- detect_invalid_lines(mousedata)

# Print the result
print(invalid_lines)

