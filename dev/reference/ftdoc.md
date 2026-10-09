# Export flextable as MS Word table

Export flextable as MS Word table

## Usage

``` r
ftdoc(ft, fpath, omit)
```

## Arguments

- ft:

  A flextable object.

- fpath:

  `<chr>` File path to save output and add to label.

- omit:

  `<chr>` Text to omit from the label.

## Value

A string containing the full name of the generated file.

## Examples

``` r
if (FALSE) { # \dontrun{
fpath = "../output.png"
mtcars |> head() |> ft() |> ftdoc(fpath)
} # }
```
