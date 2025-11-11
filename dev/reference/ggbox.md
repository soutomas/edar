# Box plot wrapper for categorical covariates

Create box plots for a chosen variable by all discrete covariates in a
dataset. Numeric variables will be dropped, except the chosen variable
to plot.

## Usage

``` r
ggbox(d, var, cats, alpha = 0.1, show = TRUE, nsub = TRUE, ...)
```

## Arguments

- d:

  `<dfr>` A data frame.

- var:

  `<var>` A variable to plot as unquoted name.

- cats:

  `<var>` Optional. Categorical variables to plot as a vector of
  unquoted names.

- alpha:

  `<num>` Alpha value for
  [ggplot2::geom_jitter](https://ggplot2.tidyverse.org/reference/geom_jitter.html).

- show:

  `<lgl>` `TRUE` to show data using
  [ggplot2::geom_jitter](https://ggplot2.tidyverse.org/reference/geom_jitter.html).

- nsub:

  `<lgl>` Show number of observations.

- ...:

  Additional arguments for
  [ggplot2::geom_boxplot](https://ggplot2.tidyverse.org/reference/geom_boxplot.html).

## Value

A ggplot object.

## Examples

``` r
d = mtcars |> dplyr::mutate(across(c(am,carb,cyl,gear,vs),factor))
d |> ggbox(mpg)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Error in ggplot2::geom_boxplot(...): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggbox(mpg,alpha=0.5)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Error in ggplot2::geom_boxplot(...): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggbox(mpg,show=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Error in ggplot2::geom_boxplot(...): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggbox(mpg,nsub=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Error in ggplot2::geom_boxplot(...): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggbox(mpg,c(cyl,vs))
#> NB: Numeric variables are dropped.
#> Dropped: 
#> Error in ggplot2::geom_boxplot(...): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
```
