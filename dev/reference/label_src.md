# Generate source file label

Generate a label with the current source file path and run time,
assuming that the source file is in the current working directory. In
interactive sessions, the function is designed to work in a script file
in RStudio and uses `rstudioapi` to get the file path. It will return
empty if run in the console directly.

## Usage

``` r
label_src(span = 2, omit = "", tz = TRUE, fname = FALSE)
```

## Arguments

- span:

  `<int>` Number of lines: either 1 or 2.

- omit:

  `<chr>` Text to omit from the label.

- tz:

  `<lgl>` `FALSE` to exclude time stamp.

- fname:

  `<lgl>` `TRUE` to return the file name only.

## Value

A label showing the source file path with a time stamp.

## Examples

``` r
label_src()
#> [1] "Source:/home/runner/work/edar/edar/docs/dev/reference/\n\nRun: 2025-11-13 12:25:21 UTC"
label_src(tz=FALSE)
#> [1] "Source:/home/runner/work/edar/edar/docs/dev/reference/\n"
label_src(fname=TRUE)
#> character(0)
```
