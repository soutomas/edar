# kable wrapper

Sugar function for default kable output.

## Usage

``` r
kb(d, fnote = NULL, cap = NULL, sig = 8, dig = 2, src = 0, omit = "")
```

## Arguments

- d:

  `<dfr>` A data frame.

- fnote:

  `<chr>` Footnote.

- cap:

  `<chr>` Caption.

- sig:

  `<int>` Number of significant digits to compute.

- dig:

  `<int>` Number of decimal places to display.

- src:

  `<int>` Either 1 or 2 to add source label over 1 or 2 lines.

- omit:

  `<chr>` Text to omit from the source label.

## Value

A kable object.

## Examples

``` r
mtcars |> head() |> kb()
#> <table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">   </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.62 </td>
#>    <td style="text-align:right;"> 16.46 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.88 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 108 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.85 </td>
#>    <td style="text-align:right;"> 2.32 </td>
#>    <td style="text-align:right;"> 18.61 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 258 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.21 </td>
#>    <td style="text-align:right;"> 19.44 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 18.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.44 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18.1 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 225 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.46 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> </table>
mtcars |> head() |> kb(src=1)
#> <table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;'>
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">   </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.62 </td>
#>    <td style="text-align:right;"> 16.46 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.88 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 108 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.85 </td>
#>    <td style="text-align:right;"> 2.32 </td>
#>    <td style="text-align:right;"> 18.61 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 258 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.21 </td>
#>    <td style="text-align:right;"> 19.44 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 18.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.44 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18.1 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 225 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.46 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> <tfoot><tr><td style="padding: 0; " colspan="100%">
#> <sup></sup> Source:<br>Run: 2025-11-10 07:18:00 UTC</td></tr></tfoot>
#> </table>
mtcars |> head() |> kb("Footnote")
#> <table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;'>
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">   </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.62 </td>
#>    <td style="text-align:right;"> 16.46 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.88 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 108 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.85 </td>
#>    <td style="text-align:right;"> 2.32 </td>
#>    <td style="text-align:right;"> 18.61 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 258 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.21 </td>
#>    <td style="text-align:right;"> 19.44 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 18.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.44 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18.1 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 225 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.46 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> <tfoot><tr><td style="padding: 0; " colspan="100%">
#> <sup></sup> Footnote<br>
#> </td></tr></tfoot>
#> </table>
mtcars |> head() |> kb("Footnote",src=1)
#> <table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;border-bottom: 0;'>
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">   </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.62 </td>
#>    <td style="text-align:right;"> 16.46 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21.0 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.90 </td>
#>    <td style="text-align:right;"> 2.88 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 22.8 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 108 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.85 </td>
#>    <td style="text-align:right;"> 2.32 </td>
#>    <td style="text-align:right;"> 18.61 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21.4 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 258 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.08 </td>
#>    <td style="text-align:right;"> 3.21 </td>
#>    <td style="text-align:right;"> 19.44 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 18.7 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 175 </td>
#>    <td style="text-align:right;"> 3.15 </td>
#>    <td style="text-align:right;"> 3.44 </td>
#>    <td style="text-align:right;"> 17.02 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18.1 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 225 </td>
#>    <td style="text-align:right;"> 105 </td>
#>    <td style="text-align:right;"> 2.76 </td>
#>    <td style="text-align:right;"> 3.46 </td>
#>    <td style="text-align:right;"> 20.22 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> <tfoot><tr><td style="padding: 0; " colspan="100%">
#> <sup></sup> Footnote<br>Source:<br>Run: 2025-11-10 07:18:00 UTC</td></tr></tfoot>
#> </table>
mtcars |> head() |> kb(sig=2,dig=1)
#> <table class=" lightable-classic" style='font-family: "Arial Narrow", "Source Sans Pro", sans-serif; width: auto !important; margin-left: auto; margin-right: auto;'>
#>  <thead>
#>   <tr>
#>    <th style="text-align:left;">   </th>
#>    <th style="text-align:right;"> mpg </th>
#>    <th style="text-align:right;"> cyl </th>
#>    <th style="text-align:right;"> disp </th>
#>    <th style="text-align:right;"> hp </th>
#>    <th style="text-align:right;"> drat </th>
#>    <th style="text-align:right;"> wt </th>
#>    <th style="text-align:right;"> qsec </th>
#>    <th style="text-align:right;"> vs </th>
#>    <th style="text-align:right;"> am </th>
#>    <th style="text-align:right;"> gear </th>
#>    <th style="text-align:right;"> carb </th>
#>   </tr>
#>  </thead>
#> <tbody>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 </td>
#>    <td style="text-align:right;"> 21 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.9 </td>
#>    <td style="text-align:right;"> 2.6 </td>
#>    <td style="text-align:right;"> 16 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Mazda RX4 Wag </td>
#>    <td style="text-align:right;"> 21 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 160 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.9 </td>
#>    <td style="text-align:right;"> 2.9 </td>
#>    <td style="text-align:right;"> 17 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 4 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Datsun 710 </td>
#>    <td style="text-align:right;"> 23 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 93 </td>
#>    <td style="text-align:right;"> 3.8 </td>
#>    <td style="text-align:right;"> 2.3 </td>
#>    <td style="text-align:right;"> 19 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 4 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet 4 Drive </td>
#>    <td style="text-align:right;"> 21 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 260 </td>
#>    <td style="text-align:right;"> 110 </td>
#>    <td style="text-align:right;"> 3.1 </td>
#>    <td style="text-align:right;"> 3.2 </td>
#>    <td style="text-align:right;"> 19 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Hornet Sportabout </td>
#>    <td style="text-align:right;"> 19 </td>
#>    <td style="text-align:right;"> 8 </td>
#>    <td style="text-align:right;"> 360 </td>
#>    <td style="text-align:right;"> 180 </td>
#>    <td style="text-align:right;"> 3.2 </td>
#>    <td style="text-align:right;"> 3.4 </td>
#>    <td style="text-align:right;"> 17 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 2 </td>
#>   </tr>
#>   <tr>
#>    <td style="text-align:left;"> Valiant </td>
#>    <td style="text-align:right;"> 18 </td>
#>    <td style="text-align:right;"> 6 </td>
#>    <td style="text-align:right;"> 220 </td>
#>    <td style="text-align:right;"> 100 </td>
#>    <td style="text-align:right;"> 2.8 </td>
#>    <td style="text-align:right;"> 3.5 </td>
#>    <td style="text-align:right;"> 20 </td>
#>    <td style="text-align:right;"> 1 </td>
#>    <td style="text-align:right;"> 0 </td>
#>    <td style="text-align:right;"> 3 </td>
#>    <td style="text-align:right;"> 1 </td>
#>   </tr>
#> </tbody>
#> </table>
```
