# Geometric standard deviation

Compute geometric standard deviation

## Usage

``` r
geoSD(x, ...)
```

## Arguments

- x:

  `<num>` A vector of values.

- ...:

  Other augments to pass to [`sd()`](https://rdrr.io/r/stats/sd.html).

## Value

Geometric standard deviation

## Examples

``` r
geoSD(rlnorm(10))
#> [1] 3.241319
```
