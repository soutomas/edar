
<!-- README.md is generated from README.Rmd. Please edit that file -->

# edar

<!-- badges: start -->

[![R-CMD-check](https://github.com/soutomas/edar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/soutomas/edar/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/edar)](https://CRAN.R-project.org/package=edar)
<!-- badges: end -->

The goal of edar is to provide some convenient functions to facilitate
tasks in exploratory data analysis.

## Citation

Sou T (2025). *edar: Convenient Functions for Exploratory Data
Analysis*. R package version 0.0.5.9000,
<https://github.com/soutomas/edar>.

``` r
citation("edar")
#> To cite package 'edar' in publications use:
#> 
#>   Sou T (2025). _edar: Convenient Functions for Exploratory Data
#>   Analysis_. R package version 0.0.5,
#>   <https://CRAN.R-project.org/package=edar>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {edar: Convenient Functions for Exploratory Data Analysis},
#>     author = {Tomas Sou},
#>     year = {2025},
#>     note = {R package version 0.0.5},
#>     url = {https://CRAN.R-project.org/package=edar},
#>   }
```

## Installation

You can install edar from CRAN or [GitHub](https://github.com/) with:

``` r
# CRAN 
install.packages("edar")

# The latest development version 
# install.packages("pak")
pak::pak("soutomas/edar")
```

## Example

Commonly, we want to generate a quick summary of variables in a dataset.

``` r
library(edar)

# Data 
dat = mtcars |> dplyr::mutate(vs=factor(vs), am=factor(am))

# Summaries of all continuous variables in a data frame. 
dat |> summ_by()
#> Dropped: vs am
#> Adding missing grouping variables: `name`
#> # A tibble: 9 × 10
#>   name      n   nNA   Mean      SD   Min    P25    Med    P75    Max
#>   <chr> <int> <int>  <dbl>   <dbl> <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#> 1 carb     32     0   2.81   1.62   1      2      2      4      8   
#> 2 cyl      32     0   6.19   1.79   4      4      6      8      8   
#> 3 disp     32     0 231.   124.    71.1  121.   196.   326    472   
#> 4 drat     32     0   3.60   0.535  2.76   3.08   3.70   3.92   4.93
#> 5 gear     32     0   3.69   0.738  3      3      4      4      5   
#> 6 hp       32     0 147.    68.6   52     96.5  123    180    335   
#> 7 mpg      32     0  20.1    6.03  10.4   15.4   19.2   22.8   33.9 
#> 8 qsec     32     0  17.8    1.79  14.5   16.9   17.7   18.9   22.9 
#> 9 wt       32     0   3.22   0.978  1.51   2.58   3.32   3.61   5.42

# Summaries of a selected variable after grouping. 
dat |> summ_by(mpg,vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 10
#>   vs        n   nNA  Mean    SD   Min   P25   Med   P75   Max
#>   <fct> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 0        18     0  16.6  3.86  10.4  14.8  15.6  19.1  26  
#> 2 1        14     0  24.6  5.38  17.8  21.4  22.8  29.6  33.9
dat |> summ_by(mpg,vs,am)
#> Adding missing grouping variables: `vs`, `am`
#> # A tibble: 4 × 11
#> # Groups:   vs [2]
#>   vs    am        n   nNA  Mean    SD   Min   P25   Med   P75   Max
#>   <fct> <fct> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 0     0        12     0  15.0  2.77  10.4  14.0  15.2  16.6  19.2
#> 2 0     1         6     0  19.8  4.01  15    16.8  20.4  21    26  
#> 3 1     0         7     0  20.7  2.47  17.8  18.6  21.4  22.2  24.4
#> 4 1     1         7     0  28.4  4.76  21.4  25.0  30.4  31.4  33.9

# Summaries of all categorical variables in a data frame. 
dat |> summ_cat()
#> Dropped: mpg cyl disp hp drat wt qsec gear carb
#> $vs
#>     vs  n percent
#>      0 18  0.5625
#>      1 14  0.4375
#>  Total 32  1.0000
#> 
#> $am
#>     am  n percent
#>      0 19 0.59375
#>      1 13 0.40625
#>  Total 32 1.00000
```

Results can be directly viewed in a flextable object.

``` r
# Show data frame in a flextable object. 
dat |> summ_by(mpg,vs) |> ft()
```

It is often helpful to add a label in the output indicating the source
file.

``` r
# A label indicating the current source file with run time can be easily generated. 
lab = label_src(1)
```

``` r
# A source label can be directly added to the flextable output. 
dat |> summ_by(mpg,vs) |> ft(src=1)
```

``` r
# A source label can be easily added to a ggplot object. 
library(ggplot2)
p = ggplot(mtcars, aes(mpg, wt)) + geom_point() 
p |> ggsrc()
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
