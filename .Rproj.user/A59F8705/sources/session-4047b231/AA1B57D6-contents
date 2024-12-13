library(ggplot2)
library(tidyr)
# Make sure 'cleanR' is loaded if identify_and_plot_swaps is in that package
library(cleanR)

# Load the data
plants_clean <- read.csv("/cloud/project/cleanR/data-raw/plants_test.csv")

swaps_output <- identify_and_plot_swaps(
  data = plants_clean, 
  weight_columns = c("X10_6_weight", "X10_9_weight"), 
  key_column = "pot_id", 
  plot_filename = "/cloud/project/cleanR/inst/extdata/swaps_plot.png", 
  weight_diff_threshold = 100)



# View the swaps_output in the global environment
print(swaps_output$swaps)



