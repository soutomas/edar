# Table wrapper for two variables

Wrapper function to produce summary tables for two variables.

## Usage

``` r
tab2v(d, x, y)
```

## Arguments

- d:

  `<dfr>` A data frame.

- x, y:

  `<var>` Variables to tabulate.

## Value

A tabyl object.

## Examples

``` r
# example code
mtcars |> tab2v(vs,cyl)
#>     vs          4         6          8       Total
#>      0  5.6%  (1) 16.7% (3) 77.8% (14) 100.0% (18)
#>      1 71.4% (10) 28.6% (4)  0.0%  (0) 100.0% (14)
#>  Total 34.4% (11) 21.9% (7) 43.8% (14) 100.0% (32)
mtcars |> tab2v(vs,am)
#>     vs          0          1       Total
#>      0 66.7% (12) 33.3%  (6) 100.0% (18)
#>      1 50.0%  (7) 50.0%  (7) 100.0% (14)
#>  Total 59.4% (19) 40.6% (13) 100.0% (32)
mtcars |> tab2v(vs,am)
#>     vs          0          1       Total
#>      0 66.7% (12) 33.3%  (6) 100.0% (18)
#>      1 50.0%  (7) 50.0%  (7) 100.0% (14)
#>  Total 59.4% (19) 40.6% (13) 100.0% (32)
mtcars |> tab2v(vs,gear)
#>     vs          3          4         5       Total
#>      0 66.7% (12) 11.1%  (2) 22.2% (4) 100.0% (18)
#>      1 21.4%  (3) 71.4% (10)  7.1% (1) 100.0% (14)
#>  Total 46.9% (15) 37.5% (12) 15.6% (5) 100.0% (32)
```
