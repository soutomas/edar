# flextable defaults

Sugar function to set flextable defaults. The arguments are passed to
[`flextable::set_flextable_defaults()`](https://davidgohel.github.io/flextable/reference/set_flextable_defaults.html).

## Usage

``` r
ft_def(
  show = FALSE,
  font = "Calibri Light",
  fsize = 10,
  pad = 3,
  na = "",
  nan = "",
  ...
)
```

## Arguments

- show:

  `<lgl>` `TRUE` to show values after the update.

- font:

  `<chr>` Font family - for `font.family`.

- fsize:

  `<int>` Font size (in point) - for `font.size`.

- pad:

  `<int>` Padding space around text - for `padding`.

- na:

  `<chr>` A value to display instead of NA - for `na_str`

- nan:

  `<chr>` A value to display instead of NaN - for `nan_str`

- ...:

  Additional arguments to pass to
  [`flextable::set_flextable_defaults()`](https://davidgohel.github.io/flextable/reference/set_flextable_defaults.html)

## Value

A list containing previous default values.

## See also

[`flextable::set_flextable_defaults()`](https://davidgohel.github.io/flextable/reference/set_flextable_defaults.html).

## Examples

``` r
if (FALSE) { # \dontrun{
ft_def()
} # }
```
