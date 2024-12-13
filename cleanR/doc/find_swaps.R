## -----------------------------------------------------------------------------
library(cleanR)

# Example dataset
plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

# Preview the data
head(plants_clean)

## -----------------------------------------------------------------------------
# Call the function to identify and visualize swaps
swaps_output <- identify_and_plot_swaps(
  data = plants_clean,
  weight_columns = c("X10_6_weight", "X10_9_weight"), 
  key_column = "pot_id", 
  plot_filename = "swaps_plot.png"
)

# View the flagged swaps
print(swaps_output$swaps)

