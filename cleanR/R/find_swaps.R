#' Identify and Visualize Potential Swaps in Longitudinal Weight Data
#'
#' This function identifies potential swaps in longitudinal weight data based on a 
#' threshold difference in weight between consecutive time points. It highlights 
#' the flagged rows in a plot and returns a dataset with the potential swaps. 
#'
#' @param data A data frame containing the dataset with at least 2 weight columns and a key column such as "ID".
#' @param weight_columns A character vector specifying the names of the weight columns (e.g., c("X10_6_weight", "X10_9_weight")).
#' @param key_column A character string specifying the column name used to identify rows (e.g., "pot_id").
#' @param plot_filename A character string specifying the file name to save the plot (e.g., "swaps_plot.png").
#' @param weight_diff_threshold A numeric value specifying the minimum weight difference (in grams) that defines a potential swap.
#' @return A list containing:
#'   \item{swaps}{A data frame of rows flagged as potential swaps, where weight difference exceeds the specified threshold.}
#'   \item{plot}{A ggplot object visualizing the weights and flagged potential swaps.}
#'   \item{saved_plot}{The path to the saved image file of the plot.}
#' 
#' @import ggplot2
#' @importFrom dplyr %>%
#' @importFrom tidyr pivot_longer
#' @importFrom rlang sym 
#' @importFrom rlang !!
#' @import viridis
#' @name identify_and_plot_swaps
#' @export

identify_and_plot_swaps <- function(data, weight_columns, key_column, plot_filename = "/cloud/project/cleanR/inst/extdata/swaps_plot.png", weight_diff_threshold = 1) {
  
  ### Make sure required columns are in dataset
  if (!all(c(weight_columns, key_column) %in% colnames(data))) {
    
    ### Error message if columns are missing 
    stop("Some specified columns are missing from the dataset.")
  }
  
  ### Make sure columns are numeric and handle non-numeric values (convert to NA)
  data[weight_columns] <- lapply(data[weight_columns], function(x) as.numeric(as.character(x)))
  
  ### Check for any NA values after conversion to numeric 
  if (any(sapply(data[weight_columns], function(x) any(is.na(x))))) {
    warning("Some weight values were not numeric and have been converted to NA.")
  }
  
  ### Flag potential swaps where weight difference between timepoints exceeds the threshold
  data$Flagged <- FALSE
  
  for (i in 1:(nrow(data) - 1)) {
    weight_1 <- data[[weight_columns[1]]][i]
    weight_2 <- data[[weight_columns[2]]][i]
    
    ### Skip rows with NA weights
    if (is.na(weight_1) || is.na(weight_2)) next
    
    weight_diff <- abs(weight_1 - weight_2)
    
    ### Flag if the weight difference exceeds the threshold
    if (weight_diff > weight_diff_threshold) {
      data$Flagged[i] <- TRUE
      
      ### Flag following row 
      data$Flagged[i + 1] <- TRUE  
    }
  }
  
  ### Pivot longer for plotting 
  melted_data <- data |>
    pivot_longer(cols = weight_columns, 
                 names_to = "Weight_Type", 
                 values_to = "Weight")
  
  ### Create a line graph for each observation 
  plot <- ggplot(melted_data, aes(x = !!sym("Weight_Type"), y = !!sym("Weight"), group = !!sym(key_column), color = as.factor(!!sym(key_column)))) +
    
    ### Create thin lines by default and thicker lines for flagged rows
    geom_line(alpha = 0.6, aes(size = ifelse(Flagged, 1.5, 0.5)), show.legend = FALSE) +
    
    ### Add special points for flagged rows 
    geom_point(aes(shape = !!sym("Flagged")), size = 5) +
   
    scale_shape_manual(values = c(`TRUE` = 4, `FALSE` = 8)) +
    
    ### Color
    scale_color_viridis(discrete = TRUE, option = "D") +  
    
    scale_size_continuous(range = c(0.5, 1.5)) +
    
    theme_minimal(base_size = 15) +  
    
    labs(
      title = "Comparing Weight Data with Potential Swaps Highlighted",
      x = "Weight Type", 
      y = "Weight", 
      color = "ID",
      shape = "Potential Swap"
    ) +
    
    ### Vizuals
    theme(
      legend.position = "bottom",  
      legend.title = element_text(size = 14),  
      legend.text = element_text(size = 12),  
      axis.title = element_text(size = 14), 
      axis.text = element_text(size = 12),  
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"), 
      panel.grid.major = element_line(size = 0.5, color = "gray80"), 
      panel.grid.minor = element_blank()  
    )
  
  ### Save the plot
  ggsave(plot_filename, plot = plot, width = 14, height = 10)
  
  ### Return flagged swaps and plot details
  list(swaps = data[data$Flagged == TRUE, ], plot = plot, saved_plot = plot_filename)
}
