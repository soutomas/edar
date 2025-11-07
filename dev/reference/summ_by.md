# Summarise continuous variables by group

Summarise all continuous variables by group. Non-numeric variables will
be dropped.

## Usage

``` r
summ_by(d, cols, ..., pct = c(0.25, 0.75), xname = "")
```

## Arguments

- d:

  `<dfr>` A data frame.

- cols:

  `<var>` Optional. Columns to summarise as unquoted names.

- ...:

  `<var>` Optional. Columns to group by as unquoted names.

- pct:

  `<num>` A vector of two indicating the percentiles to compute.

- xname:

  `<chr>` Characters to omit in output column names.

## Value

A data frame of summarised variables.

## Examples

``` r
d <- mtcars |> dplyr::mutate(vs=factor(vs), am=factor(am))
d |> summ_by()
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
d |> summ_by(pct=c(0.1,0.9))
#> Dropped: vs am
#> Adding missing grouping variables: `name`
#> # A tibble: 9 × 10
#>   name      n   nNA   Mean      SD   Min   P10    Med    P90    Max
#>   <chr> <int> <int>  <dbl>   <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#> 1 carb     32     0   2.81   1.62   1     1      2      4      8   
#> 2 cyl      32     0   6.19   1.79   4     4      6      8      8   
#> 3 disp     32     0 231.   124.    71.1  80.6  196.   396    472   
#> 4 drat     32     0   3.60   0.535  2.76  3.01   3.70   4.21   4.93
#> 5 gear     32     0   3.69   0.738  3     3      4      5      5   
#> 6 hp       32     0 147.    68.6   52    66    123    244.   335   
#> 7 mpg      32     0  20.1    6.03  10.4  14.3   19.2   30.1   33.9 
#> 8 qsec     32     0  17.8    1.79  14.5  15.5   17.7   20.0   22.9 
#> 9 wt       32     0   3.22   0.978  1.51  1.96   3.32   4.05   5.42
d |> summ_by(mpg)
#> Dropped: 
#> Adding missing grouping variables: `name`
#> # A tibble: 1 × 10
#>   name      n   nNA  Mean    SD   Min   P25   Med   P75   Max
#>   <chr> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 mpg      32     0  20.1  6.03  10.4  15.4  19.2  22.8  33.9
d |> summ_by(mpg,vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 10
#>   vs        n   nNA  Mean    SD   Min   P25   Med   P75   Max
#>   <fct> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 0        18     0  16.6  3.86  10.4  14.8  15.6  19.1  26  
#> 2 1        14     0  24.6  5.38  17.8  21.4  22.8  29.6  33.9
d |> summ_by(mpg,vs,am)
#> Adding missing grouping variables: `vs`, `am`
#> # A tibble: 4 × 11
#> # Groups:   vs [2]
#>   vs    am        n   nNA  Mean    SD   Min   P25   Med   P75   Max
#>   <fct> <fct> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 0     0        12     0  15.0  2.77  10.4  14.0  15.2  16.6  19.2
#> 2 0     1         6     0  19.8  4.01  15    16.8  20.4  21    26  
#> 3 1     0         7     0  20.7  2.47  17.8  18.6  21.4  22.2  24.4
#> 4 1     1         7     0  28.4  4.76  21.4  25.0  30.4  31.4  33.9
d |> summ_by(c(mpg,disp))
#> Dropped: 
#> Adding missing grouping variables: `name`
#> # A tibble: 2 × 10
#>   name      n   nNA  Mean     SD   Min   P25   Med   P75   Max
#>   <chr> <int> <int> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1 disp     32     0 231.  124.    71.1 121.  196.  326   472  
#> 2 mpg      32     0  20.1   6.03  10.4  15.4  19.2  22.8  33.9
d |> summ_by(c(mpg,disp),vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 19
#>   vs    mpg_n mpg_nNA mpg_Mean mpg_SD mpg_Min mpg_P25 mpg_Med mpg_P75 mpg_Max
#>   <fct> <int>   <int>    <dbl>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 0        18       0     16.6   3.86    10.4    14.8    15.6    19.1    26  
#> 2 1        14       0     24.6   5.38    17.8    21.4    22.8    29.6    33.9
#> # ℹ 9 more variables: disp_n <int>, disp_nNA <int>, disp_Mean <dbl>,
#> #   disp_SD <dbl>, disp_Min <dbl>, disp_P25 <dbl>, disp_Med <dbl>,
#> #   disp_P75 <dbl>, disp_Max <dbl>
d |> summ_by(c(mpg,disp),vs,xname="mpg_")
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 19
#>   vs        n   nNA  Mean    SD   Min   P25   Med   P75   Max disp_n disp_nNA
#>   <fct> <int> <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>  <int>    <int>
#> 1 0        18     0  16.6  3.86  10.4  14.8  15.6  19.1  26       18        0
#> 2 1        14     0  24.6  5.38  17.8  21.4  22.8  29.6  33.9     14        0
#> # ℹ 7 more variables: disp_Mean <dbl>, disp_SD <dbl>, disp_Min <dbl>,
#> #   disp_P25 <dbl>, disp_Med <dbl>, disp_P75 <dbl>, disp_Max <dbl>
# Grouping without column selection is possible but rarely useful in large dataset
d |> summ_by(,vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 82
#>   vs    mpg_n mpg_nNA mpg_Mean mpg_SD mpg_Min mpg_P25 mpg_Med mpg_P75 mpg_Max
#>   <fct> <int>   <int>    <dbl>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
#> 1 0        18       0     16.6   3.86    10.4    14.8    15.6    19.1    26  
#> 2 1        14       0     24.6   5.38    17.8    21.4    22.8    29.6    33.9
#> # ℹ 72 more variables: cyl_n <int>, cyl_nNA <int>, cyl_Mean <dbl>,
#> #   cyl_SD <dbl>, cyl_Min <dbl>, cyl_P25 <dbl>, cyl_Med <dbl>, cyl_P75 <dbl>,
#> #   cyl_Max <dbl>, disp_n <int>, disp_nNA <int>, disp_Mean <dbl>,
#> #   disp_SD <dbl>, disp_Min <dbl>, disp_P25 <dbl>, disp_Med <dbl>,
#> #   disp_P75 <dbl>, disp_Max <dbl>, hp_n <int>, hp_nNA <int>, hp_Mean <dbl>,
#> #   hp_SD <dbl>, hp_Min <dbl>, hp_P25 <dbl>, hp_Med <dbl>, hp_P75 <dbl>,
#> #   hp_Max <dbl>, drat_n <int>, drat_nNA <int>, drat_Mean <dbl>, …
```
