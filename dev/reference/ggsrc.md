# Add source file label to a ggplot object

Add a label with the current source file path and run time to a ggplot
object.

## Usage

``` r
ggsrc(plt, omit = "", span = 1, size = 8, col = "grey55", lab = NULL)
```

## Arguments

- plt:

  A ggplot object.

- omit:

  `<chr>` Text to omit from the label.

- span:

  `<num>` Number of lines: either 1 or 2.

- size:

  `<num>` Text size.

- col:

  `<chr>` Colour of the text.

- lab:

  `<chr>` Custom label to use instead of the default.

## Value

A ggplot object with the added label.

## Examples

``` r
p = mtcars |> ggxy(mpg,hp)
p |> ggsrc()
#> `geom_smooth()` using formula = 'y ~ x'

p |> ggsrc(lab="My label")
#> `geom_smooth()` using formula = 'y ~ x'

p |> ggsrc(lab="My label",omit="My ")
#> `geom_smooth()` using formula = 'y ~ x'
```
