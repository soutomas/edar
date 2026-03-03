# Summarise continuous variables by group

Summarise all continuous variables by group. Non-numeric variables will
be dropped.

## Usage

``` r
summ_by(d, cols, ..., pct = c(0.25, 0.75), xname = "", show = TRUE)
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

- show:

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
d |> summ_by(pct=c(0.1,0.9))
#> NB: Non-numeric variables are dropped.
#> Dropped: vs am
#> Adding missing grouping variables: `name`
d |> summ_by(mpg)
#> NB: Non-numeric variables are dropped.
#> Dropped: 
#> Adding missing grouping variables: `name`
d |> summ_by(mpg,vs)
#> Adding missing grouping variables: `vs`
d |> summ_by(mpg,vs,am)
#> Adding missing grouping variables: `vs`, `am`
d |> summ_by(c(mpg,disp))
#> NB: Non-numeric variables are dropped.
#> Dropped: 
#> Adding missing grouping variables: `name`
d |> summ_by(c(mpg,disp),vs)
#> Adding missing grouping variables: `vs`
d |> summ_by(c(mpg,disp),vs,xname="mpg_")
#> Adding missing grouping variables: `vs`
# Grouping without column selection is possible but rarely useful in large dataset
d |> summ_by(,vs)
#> Adding missing grouping variables: `vs`
```
