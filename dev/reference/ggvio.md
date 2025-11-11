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
d = mtcars |> dplyr::mutate(cyl=factor(cyl),gear=factor(gear),vs=factor(vs))
d |> ggvio(mpg)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec am carb
#> Error in ggplot2::geom_violin(trim = FALSE, quantile.linetype = 2, draw_quantiles = c(0.25,     0.5, 0.75)): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggvio(mpg,alpha=0.5)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec am carb
#> Error in ggplot2::geom_violin(trim = FALSE, quantile.linetype = 2, draw_quantiles = c(0.25,     0.5, 0.75)): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggvio(mpg,show=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec am carb
#> Error in ggplot2::geom_violin(trim = FALSE, quantile.linetype = 2, draw_quantiles = c(0.25,     0.5, 0.75)): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggvio(mpg,nsub=FALSE)
#> NB: Numeric variables are dropped.
#> Dropped: disp hp drat wt qsec am carb
#> Error in ggplot2::geom_violin(trim = FALSE, quantile.linetype = 2, draw_quantiles = c(0.25,     0.5, 0.75)): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
d |> ggvio(mpg,c(cyl,vs))
#> NB: Numeric variables are dropped.
#> Dropped: 
#> Error in ggplot2::geom_violin(trim = FALSE, quantile.linetype = 2, draw_quantiles = c(0.25,     0.5, 0.75)): Problem while computing aesthetics.
#> ℹ Error occurred in the 1st layer.
#> Caused by error in `reorder.default()`:
#> ! argument "X" is missing, with no default
```
