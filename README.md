
<!-- README.md is generated from README.Rmd. Please edit that file -->

# edar

<!-- badges: start -->
<!-- badges: end -->

The goal of edar is to provide some convenient functions for users on
some common tasks during exploratory data analysis (EDA).

## Installation

You can install the development version of edar from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("soutomas/edar")
```

## Example

Commonly, we want to add a label indicating the source file in the
output.

``` r
library(tsr)

# Generate label of current file with run time 
lab1 = label_src(1)
```

<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so: -->
<!-- ```{r cars} -->
<!-- summary(cars) -->
<!-- ``` -->
<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. -->
<!-- You can also embed plots, for example: -->
<!-- ```{r pressure, echo = FALSE} -->
<!-- plot(pressure) -->
<!-- ``` -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->
