# Violin plot wrapper for categorical covariates

Create violin plots for a chosen variable by all discrete covariates in
a dataset. Numeric variables will be dropped, except the chosen variable
to plot.

## Usage

``` r
ggvio(d, var, cats, alpha = 0.1, show = TRUE, nsub = TRUE, ...)
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
  [ggplot2::geom_violin](https://ggplot2.tidyverse.org/reference/geom_violin.html).

## Value

A ggplot object.

## Examples

``` r
d = mtcars |> mutate(across(c(am,carb,cyl,gear,vs),factor))
d |> ggvio(mpg)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.

d |> ggvio(mpg,alpha=0.5)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.

d |> ggvio(mpg,show=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.

d |> ggvio(mpg,nsub=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.
#> Warning: Groups with fewer than two datapoints have been dropped.
#> ℹ Set `drop = FALSE` to consider such groups for position adjustment purposes.

d |> ggvio(mpg,c(cyl,vs))
#> NB: Numeric variables are dropped.
#> Dropped: 
```
