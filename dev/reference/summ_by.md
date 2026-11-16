# Summarise continuous variables by group

Summarise all continuous variables by group. Non-numeric variables will
be dropped.

## Usage

``` r
summ_by(
  d,
  cols,
  ...,
  pct = c(0.25, 0.75),
  geo = TRUE,
  xname = "",
  view = FALSE
)
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

- geo:

  `<lgl>` TRUE to add geometric mean and standard devaition.

- xname:

  `<chr>` Characters to omit in output column names.

- view:

  `<lgl>` TRUE to print output as flextable.

## Value

A data frame of summarised variables.

## Examples

``` r
d = mtcars |> dplyr::mutate(vs=factor(vs), am=factor(am))
d |> summ_by()
#> NB: Non-numeric variables are dropped.
#> Dropped: vs am
#> Adding missing grouping variables: `name`
#> # A tibble: 9 × 12
#>   name      n   nNA   Mean      SD GeoMean GeoCV   Min    P25 Median    P75
#>   <chr> <int> <int>  <dbl>   <dbl>   <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#> 1 carb     32     0   2.81   1.62     2.40 64.4   1      2      2      4   
#> 2 cyl      32     0   6.19   1.79     5.92 31.7   4      4      6      8   
#> 3 disp     32     0 231.   124.     197.   64.3  71.1  121.   196.   326   
#> 4 drat     32     0   3.60   0.535    3.56 14.9   2.76   3.08   3.70   3.92
#> 5 gear     32     0   3.69   0.738    3.62 19.6   3      3      4      4   
#> 6 hp       32     0 147.    68.6    132.   50.3  52     96.5  123    180   
#> 7 mpg      32     0  20.1    6.03    19.3  30.4  10.4   15.4   19.2   22.8 
#> 8 qsec     32     0  17.8    1.79    17.8   9.98 14.5   16.9   17.7   18.9 
#> 9 wt       32     0   3.22   0.978    3.07 32.6   1.51   2.58   3.32   3.61
#> # ℹ 1 more variable: Max <dbl>
d |> summ_by(geo=TRUE)
#> NB: Non-numeric variables are dropped.
#> Dropped: vs am
#> Adding missing grouping variables: `name`
#> # A tibble: 9 × 12
#>   name      n   nNA   Mean      SD GeoMean GeoCV   Min    P25 Median    P75
#>   <chr> <int> <int>  <dbl>   <dbl>   <dbl> <dbl> <dbl>  <dbl>  <dbl>  <dbl>
#> 1 carb     32     0   2.81   1.62     2.40 64.4   1      2      2      4   
#> 2 cyl      32     0   6.19   1.79     5.92 31.7   4      4      6      8   
#> 3 disp     32     0 231.   124.     197.   64.3  71.1  121.   196.   326   
#> 4 drat     32     0   3.60   0.535    3.56 14.9   2.76   3.08   3.70   3.92
#> 5 gear     32     0   3.69   0.738    3.62 19.6   3      3      4      4   
#> 6 hp       32     0 147.    68.6    132.   50.3  52     96.5  123    180   
#> 7 mpg      32     0  20.1    6.03    19.3  30.4  10.4   15.4   19.2   22.8 
#> 8 qsec     32     0  17.8    1.79    17.8   9.98 14.5   16.9   17.7   18.9 
#> 9 wt       32     0   3.22   0.978    3.07 32.6   1.51   2.58   3.32   3.61
#> # ℹ 1 more variable: Max <dbl>
d |> summ_by(pct=c(0.1,0.9))
#> NB: Non-numeric variables are dropped.
#> Dropped: vs am
#> Adding missing grouping variables: `name`
#> # A tibble: 9 × 12
#>   name      n   nNA   Mean      SD GeoMean GeoCV   Min   P10 Median    P90
#>   <chr> <int> <int>  <dbl>   <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl>  <dbl>
#> 1 carb     32     0   2.81   1.62     2.40 64.4   1     1      2      4   
#> 2 cyl      32     0   6.19   1.79     5.92 31.7   4     4      6      8   
#> 3 disp     32     0 231.   124.     197.   64.3  71.1  80.6  196.   396   
#> 4 drat     32     0   3.60   0.535    3.56 14.9   2.76  3.01   3.70   4.21
#> 5 gear     32     0   3.69   0.738    3.62 19.6   3     3      4      5   
#> 6 hp       32     0 147.    68.6    132.   50.3  52    66    123    244.  
#> 7 mpg      32     0  20.1    6.03    19.3  30.4  10.4  14.3   19.2   30.1 
#> 8 qsec     32     0  17.8    1.79    17.8   9.98 14.5  15.5   17.7   20.0 
#> 9 wt       32     0   3.22   0.978    3.07 32.6   1.51  1.96   3.32   4.05
#> # ℹ 1 more variable: Max <dbl>
d |> summ_by(mpg)
#> NB: Non-numeric variables are dropped.
#> Dropped: 
#> Adding missing grouping variables: `name`
#> # A tibble: 1 × 12
#>   name      n   nNA  Mean    SD GeoMean GeoCV   Min   P25 Median   P75   Max
#>   <chr> <int> <int> <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1 mpg      32     0  20.1  6.03    19.3  30.4  10.4  15.4   19.2  22.8  33.9
d |> summ_by(mpg,vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 12
#>   vs        n   nNA  Mean    SD GeoMean GeoCV   Min   P25 Median   P75   Max
#>   <fct> <int> <int> <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1 0        18     0  16.6  3.86    16.2  23.6  10.4  14.8   15.6  19.1  26  
#> 2 1        14     0  24.6  5.38    24.0  21.7  17.8  21.4   22.8  29.6  33.9
d |> summ_by(mpg,vs,am)
#> Adding missing grouping variables: `vs`, `am`
#> # A tibble: 4 × 13
#> # Groups:   vs [2]
#>   vs    am        n   nNA  Mean    SD GeoMean GeoCV   Min   P25 Median   P75
#>   <fct> <fct> <int> <int> <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl>
#> 1 0     0        12     0  15.0  2.77    14.8  19.8  10.4  14.0   15.2  16.6
#> 2 0     1         6     0  19.8  4.01    19.4  20.6  15    16.8   20.4  21  
#> 3 1     0         7     0  20.7  2.47    20.6  12.0  17.8  18.6   21.4  22.2
#> 4 1     1         7     0  28.4  4.76    28.0  17.8  21.4  25.0   30.4  31.4
#> # ℹ 1 more variable: Max <dbl>
d |> summ_by(c(mpg,disp))
#> NB: Non-numeric variables are dropped.
#> Dropped: 
#> Adding missing grouping variables: `name`
#> # A tibble: 2 × 12
#>   name      n   nNA  Mean     SD GeoMean GeoCV   Min   P25 Median   P75   Max
#>   <chr> <int> <int> <dbl>  <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1 disp     32     0 231.  124.     197.   64.3  71.1 121.   196.  326   472  
#> 2 mpg      32     0  20.1   6.03    19.3  30.4  10.4  15.4   19.2  22.8  33.9
d |> summ_by(c(mpg,disp),vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 23
#>   vs    mpg_n mpg_nNA mpg_Mean mpg_SD mpg_GeoMean mpg_GeoCV mpg_Min mpg_P25
#>   <fct> <int>   <int>    <dbl>  <dbl>       <dbl>     <dbl>   <dbl>   <dbl>
#> 1 0        18       0     16.6   3.86        16.2      23.6    10.4    14.8
#> 2 1        14       0     24.6   5.38        24.0      21.7    17.8    21.4
#> # ℹ 14 more variables: mpg_Median <dbl>, mpg_P75 <dbl>, mpg_Max <dbl>,
#> #   disp_n <int>, disp_nNA <int>, disp_Mean <dbl>, disp_SD <dbl>,
#> #   disp_GeoMean <dbl>, disp_GeoCV <dbl>, disp_Min <dbl>, disp_P25 <dbl>,
#> #   disp_Median <dbl>, disp_P75 <dbl>, disp_Max <dbl>
d |> summ_by(c(mpg,disp),vs,xname="mpg_")
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 23
#>   vs        n   nNA  Mean    SD GeoMean GeoCV   Min   P25 Median   P75   Max
#>   <fct> <int> <int> <dbl> <dbl>   <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl>
#> 1 0        18     0  16.6  3.86    16.2  23.6  10.4  14.8   15.6  19.1  26  
#> 2 1        14     0  24.6  5.38    24.0  21.7  17.8  21.4   22.8  29.6  33.9
#> # ℹ 11 more variables: disp_n <int>, disp_nNA <int>, disp_Mean <dbl>,
#> #   disp_SD <dbl>, disp_GeoMean <dbl>, disp_GeoCV <dbl>, disp_Min <dbl>,
#> #   disp_P25 <dbl>, disp_Median <dbl>, disp_P75 <dbl>, disp_Max <dbl>
# Grouping without column selection is possible but rarely useful in large dataset
d |> summ_by(,vs)
#> Adding missing grouping variables: `vs`
#> # A tibble: 2 × 100
#>   vs    mpg_n mpg_nNA mpg_Mean mpg_SD mpg_GeoMean mpg_GeoCV mpg_Min mpg_P25
#>   <fct> <int>   <int>    <dbl>  <dbl>       <dbl>     <dbl>   <dbl>   <dbl>
#> 1 0        18       0     16.6   3.86        16.2      23.6    10.4    14.8
#> 2 1        14       0     24.6   5.38        24.0      21.7    17.8    21.4
#> # ℹ 91 more variables: mpg_Median <dbl>, mpg_P75 <dbl>, mpg_Max <dbl>,
#> #   cyl_n <int>, cyl_nNA <int>, cyl_Mean <dbl>, cyl_SD <dbl>,
#> #   cyl_GeoMean <dbl>, cyl_GeoCV <dbl>, cyl_Min <dbl>, cyl_P25 <dbl>,
#> #   cyl_Median <dbl>, cyl_P75 <dbl>, cyl_Max <dbl>, disp_n <int>,
#> #   disp_nNA <int>, disp_Mean <dbl>, disp_SD <dbl>, disp_GeoMean <dbl>,
#> #   disp_GeoCV <dbl>, disp_Min <dbl>, disp_P25 <dbl>, disp_Median <dbl>,
#> #   disp_P75 <dbl>, disp_Max <dbl>, hp_n <int>, hp_nNA <int>, hp_Mean <dbl>, …
```
