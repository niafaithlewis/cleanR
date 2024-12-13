
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cleanR

<!-- badges: start -->
<!-- badges: end -->

The goal of cleanR is to equip users with functions that can make
identifying potential errors in datasets a little bit easier.

## Description

The `cleanR` package provides tools for cleaning and processing data,
via the following functions:

1.  Coercing non-numeric values to numeric: This function takes a column
    that a user assumes should have numeric inputs, but which may have
    non-numeric values such as word (example: “dead”). Regular coercion
    can turn values into NAs, which can disrupt any operations you might
    want to perform on the data down the line such as mathematical
    operations. This function coerces the column to numeric, but is also
    set to deal with special cases such as “dead”. It alerts the user of
    where there were non-numeric values.

2.  Identifying typos: This function analyzes a character column to
    identify potential typos by using string length and distance checks
    against the most common string in that column (which it uses as the
    non-typo string).

3.  Identifying potential swaps via visualizing data: This function is
    designed to compare weight measurements between separate timepoints
    to identify potential swaps that might have occured in the data,
    where the weight for one row was swapped for the weight for another
    row. It specifically works in datasets where the weight increases or
    is expected to increase over time. It also provides user with a
    visualization of the results so that it is easier to see the
    potential swap that took place, rather than looking at huge swaths
    of numbers.

4.  Identiying invalid lines (specific to my example dataset):
    Additionally, this package contains a 4th function that is
    particularly suited to example dataset provided (plants_clean). This
    is a cut of data collected by me for a future project. In this
    dataset, plants are tracked by weight over months (only two days are
    included in the cut of data used for the example), and have been
    divided into two lines that will eventually receive different
    watering treatments to achieve conditions of drought (treatment:“d”)
    or control (treatment: “w”). The plants used are the result of
    artificial selection done to create families that are either
    self-incompatible -\> SI (the plant cannot reproduce with itself),
    self-compatible -\> SC(the plant can reproduce with itself), or
    control -\> C. This will become important later on in my project
    when we begin to do experiments on them to understand how their
    reproductive abilities are responding to the drought treatment, so
    it is important that these lines are correctly labelled in the
    dataset. Multiple people in my lab work with these lines as well, so
    this function is applicable to other datasets. Because of that, I
    wanted to create a function that addressed this specific feature of
    my data. This is function \#4 and it identifies invalid lines in the
    data, prints out the result to the user and suggests the line IDs
    that the should be instead.

## Installation

Here’s how you can install the cleanR package:

``` r
# Install the following packages:
install.packages(c("devtools", "readr", "stringdist"))



# Install cleanR from GitHub
devtools::install_github("niafaithlewis/cleanR/cleanR")
```

## Example 1

Here is an example of the invalid lines function in action:

``` r
### Load the required packages
library(cleanR)

### Load data
data("plants_clean")

head(plants_clean)
#>   treatment pot_id line mom dad tray_id target_weight X10_6_weight X10_9_weight
#> 1         d      1   C1  86  59       1        388.90        288.7          293
#> 2       wet      2  SI1 672 697       1        687.50        417.0        423.5
#> 3         w      3   C1  27 100       1        653.15        263.5        273.5
#> 4         w      4   C2  60  77       1        653.40        433.0          460
#> 5         w      5   C1  27 100       1        679.80        421.5         dead
#> 6        dr      6  SI1 610 667       1        387.30        322.0        324.5

invalid_lines <- detect_invalid_lines(plants_clean)
#> The following rows contain invalid 'line' values:
#>   treatment pot_id line mom dad tray_id target_weight X10_6_weight X10_9_weight
#> 4         w      4   C2  60  77       1        653.40          433          460
#> 7         d      7 SXX1 246 265       2        393.93          371          392
#> 8         w      8   V1 106 111       2        674.20          526          399
#>   suggested_correction
#> 4                   C1
#> 7                  SC1
#> 8                   C1
```

## Example 2

This is an example of how to use the find_swaps function to identify and
visualize potential swaps in the data:

Note: this function will drop NA values from the data, while converting
columns to numeric.

``` r
### Load libraries 
library(ggplot2)
library(tidyr)
library(cleanR)

data("plants_clean")


### Apply the identify_and_plot_swaps function
swaps_output <- identify_and_plot_swaps(
  data = plants_clean,
  weight_columns = c("X10_6_weight", "X10_9_weight"),
  key_column = "pot_id",  
  plot_filename = "swaps_plot.png",  
  weight_diff_threshold = 100  
)
#> Warning in FUN(X[[i]], ...): NAs introduced by coercion
#> Warning in identify_and_plot_swaps(data = plants_clean, weight_columns =
#> c("X10_6_weight", : Some weight values were not numeric and have been converted
#> to NA.
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_line()`).
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_point()`).


### View the flagged swaps
print(swaps_output$swaps)
#>   treatment pot_id line mom dad tray_id target_weight X10_6_weight X10_9_weight
#> 8         w      8   V1 106 111       2         674.2        526.0          399
#> 9       dry      9  SC1 247 263       2         411.2        397.5          527
#>   Flagged
#> 8    TRUE
#> 9    TRUE
```

<figure>
<img src="inst/extdata/swaps_plot.png"
alt="The plot will be saved under “inst/extdata/swaps_plot”! This plot shows the potential swaps as thicker lines than the rest of the graph to highlight them to the user. The IDs that have been flagged aas potential swaps (Flagged = TRUE) also have a distinct marker than those that are not likely to be swaps." />
<figcaption aria-hidden="true">The plot will be saved under
“inst/extdata/swaps_plot”! This plot shows the potential swaps as
thicker lines than the rest of the graph to highlight them to the user.
The IDs that have been flagged aas potential swaps (Flagged = TRUE) also
have a distinct marker than those that are not likely to be
swaps.</figcaption>
</figure>

Find more detailed examples in the vignettes folder. The vignettes
provide detailed explanations of the functions and show examples of how
to use each one, and what results you can expect.

You can access the vignettes in the vignettes folder or by viewing them
directly:

1.  Coercing non-numeric values to numeric

``` r
vignette("coerce_to_numeric")
#> Warning: vignette 'coerce_to_numeric' not found
```

2.  Identifying typos

``` r
vignette("identifying_typos")
#> Warning: vignette 'identifying_typos' not found
```

3.  Identifying potential swaps via visualizing data

``` r
vignette("find_swap")
#> Warning: vignette 'find_swap' not found
```

4.  Identifying invalid lines

``` r
vignette("invalid_lines")
#> Warning: vignette 'invalid_lines' not found
```
