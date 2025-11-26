# Time-profile plot wrapper

Create plots for time profile data such as PK and PD plots.

## Usage

``` r
ggtpp(
  d,
  x,
  y,
  id,
  ...,
  nsub = TRUE,
  logx = FALSE,
  logy = FALSE,
  alpha_point = 0.2,
  alpha_line = 0.1,
  xlab = NULL,
  ylab = NULL,
  ttl = NULL,
  sttl = NULL,
  cap = NULL
)
```

## Arguments

- d:

  `<dfr>` A data frame.

- x, y:

  `<var>` Variables for x- and y-axis as unquoted names

- id:

  `<var>` Variable for grouping ID such as subject ID as unquoted name.

- ...:

  Arguments to pass to
  [ggplot2::aes](https://ggplot2.tidyverse.org/reference/aes.html) for
  additional mapping.

- nsub:

  `<lgl>` `TRUE` to show number of subjects as per `id` in caption.

- logx, logy:

  `<lgl>` `TRUE` to log x- and y-axis.

- alpha_point:

  `<num>` Alpha value for
  [ggplot2::geom_point](https://ggplot2.tidyverse.org/reference/geom_point.html).

- alpha_line:

  `<num>` Alpha value for
  [ggplot2::geom_line](https://ggplot2.tidyverse.org/reference/geom_path.html).

- xlab, ylab:

  `<chr>` Labels for x- and y-axis.

- ttl, sttl, cap:

  `<chr>` Title. Subtitle. Caption.

## Value

A ggplot object.

## Examples

``` r
Theoph |> ggtpp(x=Time,y=conc,id=Subject)
```
