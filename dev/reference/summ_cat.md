# Summarise categorical variables

Summarise all categorical variables. Numeric variables will be dropped.

## Usage

``` r
summ_cat(d, ..., var, show = TRUE)
```

## Arguments

- d:

  A data frame.

- ...:

  `<var>` Optional. Columns to summarise.

- var:

  `<var/int>` (name or index) Optional. A variable to extract as a data
  frame.

- show:

  `<lgl>` TRUE to show output as flextable.

## Value

A list containing summaries for all categorical variables or a data
frame showing the summary of a selected variable.

## Examples

``` r
d = mtcars |> dplyr::mutate(dplyr::across(c(cyl,vs,am,gear,carb),factor))
d |> summ_cat()
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
#> $cyl
#> 
#> $vs
#> 
#> $am
#> 
#> $gear
#> 
#> $carb
#> 
d |> summ_cat(cyl,vs)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
#> $cyl
#> 
#> $vs
#> 
d |> summ_cat(var=cyl)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
d |> summ_cat(var=1)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
```
