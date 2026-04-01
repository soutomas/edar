# Save ggplot with output path

Save ggplot with output path

## Usage

``` r
ggout(plt, fpath, lab = "", omit = "", ...)
```

## Arguments

- plt:

  A ggplot object.

- fpath:

  `<chr>` File path to save output and add to label.

- lab:

  `<chr>` Custom label to use instead of `fpath`.

- omit:

  `<chr>` Text to omit from the label.

- ...:

  Other arguments to pass to
  [`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html).

## Value

The file path of the output.

## See also

[`ggplot2::ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html)

## Examples

``` r
if (FALSE) { # \dontrun{
fpath = "../output.png"
iris |> gghist() |> ggout(fpath)
} # }
```
