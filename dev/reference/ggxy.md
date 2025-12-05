# XY scatter plot wrapper

Create basic XY scatter plot for quick data exploration. Default to show
Pearson correlation coefficient with p-value using
[ggpubr::stat_cor](https://rpkgs.datanovia.com/ggpubr/reference/stat_cor.html).
For more complex plots, it is recommended to use
[ggplot2::ggplot2](https://ggplot2.tidyverse.org/reference/ggplot2-package.html)
directly.

## Usage

``` r
ggxy(
  d,
  x,
  y,
  ...,
  lm = TRUE,
  se = TRUE,
  cor = TRUE,
  pv = 0.001,
  nsub = TRUE,
  legend = TRUE,
  asp = 1
)
```

## Arguments

- d:

  `<dfr>` A data frame.

- x, y:

  `<var>` Variables for x- and y-axis as unquoted names.

- ...:

  Arguments to pass to
  [ggplot2::aes](https://ggplot2.tidyverse.org/reference/aes.html) for
  additional mapping.

- lm:

  `<lgl>` `TRUE` to add regression line from linear model.

- se:

  `<lgl>` `TRUE` to show standard error with the regression line.

- cor:

  `<lgl>` `TRUE` to show Pearson correlation coefficient with p-value.

- pv:

  `<dbl>` Precision of p-value, e.g., 0.001 to show 3 decimal places,
  `NULL` for no rounding.

- nsub:

  `<lgl>` Show number of observations.

- legend:

  `<lgl>` `TRUE` to show legend.

- asp:

  `<num>` For `aspect.ratio` in
  [ggplot2::theme](https://ggplot2.tidyverse.org/reference/theme.html).

## Value

A ggplot object.

## See also

[ggpubr::stat_cor](https://rpkgs.datanovia.com/ggpubr/reference/stat_cor.html)

## Examples

``` r
mtcars |> ggxy(wt,hp)
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,col=factor(gear))
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,col=factor(gear),legend=FALSE)
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,col=factor(gear),pch=factor(am))
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,nsub=FALSE)
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,pv=NULL)
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,lm=FALSE)

mtcars |> ggxy(wt,hp,se=FALSE)
#> `geom_smooth()` using formula = 'y ~ x'

mtcars |> ggxy(wt,hp,cor=FALSE)
#> `geom_smooth()` using formula = 'y ~ x'
```
