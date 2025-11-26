# Summarise categorical variables

Summarise all categorical variables. Numeric variables will be dropped.

## Usage

``` r
summ_cat(d, ..., var)
```

## Arguments

- d:

  A data frame.

- ...:

  `<var>` Optional. Columns to summarise.

- var:

  `<var/int>` (name or index) Optional. A variable to extract as a data
  frame.

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
#>    cyl  n percent
#>      4 11 0.34375
#>      6  7 0.21875
#>      8 14 0.43750
#>  Total 32 1.00000
#> 
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
#> 
#> $gear
#>   gear  n percent
#>      3 15 0.46875
#>      4 12 0.37500
#>      5  5 0.15625
#>  Total 32 1.00000
#> 
#> $carb
#>   carb  n percent
#>      1  7 0.21875
#>      2 10 0.31250
#>      3  3 0.09375
#>      4 10 0.31250
#>      6  1 0.03125
#>      8  1 0.03125
#>  Total 32 1.00000
#> 
d |> summ_cat(cyl,vs)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
#> $cyl
#>    cyl  n percent
#>      4 11 0.34375
#>      6  7 0.21875
#>      8 14 0.43750
#>  Total 32 1.00000
#> 
#> $vs
#>     vs  n percent
#>      0 18  0.5625
#>      1 14  0.4375
#>  Total 32  1.0000
#> 
d |> summ_cat(var=cyl)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
#>    cyl  n percent
#>      4 11 0.34375
#>      6  7 0.21875
#>      8 14 0.43750
#>  Total 32 1.00000
d |> summ_cat(var=1)
#> NB: Numeric variables are dropped.
#> Dropped: mpg disp hp drat wt qsec
#>    cyl  n percent
#>      4 11 0.34375
#>      6  7 0.21875
#>      8 14 0.43750
#>  Total 32 1.00000
```
