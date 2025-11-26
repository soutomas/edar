# Copy files and rename with date

Copy files to destination and rename with date and a tag as desired.

## Usage

``` r
fc(..., des = "", tag = "", td = TRUE)
```

## Arguments

- ...:

  `<chr>` A vector of file paths of the source files to copy and rename.

- des:

  `<chr>` Destination folder. "." to rename files at the current
  location.

- tag:

  `<chr>` Tag to the filename.

- td:

  `<lgl>` `TRUE` to add today (yymmdd) to the filename.

## Value

A logical vector indicating if the operation succeeded for each of the
files.

## Examples

``` r
if (FALSE) { # \dontrun{
# Copy a file to home directory
tmp = tempdir()
fc("f1.R","f2.R",des=tmp)
} # }
```
