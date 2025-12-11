# flextable wrapper

Sugar function for default flextable output.

## Usage

``` r
ft(d, fnote = NULL, ttl = NULL, sig = 8, dig = 2, src = 0, omit = "")
```

## Arguments

- d:

  `<dfr>` A data frame.

- fnote:

  `<chr>` Footnote.

- ttl:

  `<chr>` Title.

- sig:

  `<int>` Number of significant digits to compute.

- dig:

  `<int>` Number of decimal places to display.

- src:

  `<int>` Either 1 or 2 to add source label over 1 or 2 lines.

- omit:

  `<chr>` Text to omit from the source label.

## Value

A flextable object.

## Examples

``` r
mtcars |> head() |> ft()


.cl-e49534ce{}.cl-e48e0ca8{font-family:'DejaVu Sans';font-size:11pt;font-weight:normal;font-style:normal;text-decoration:none;color:rgba(0, 0, 0, 1.00);background-color:transparent;}.cl-e490d7b2{margin:0;text-align:left;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);padding-bottom:5pt;padding-top:5pt;padding-left:5pt;padding-right:5pt;line-height: 1;background-color:transparent;}.cl-e490f8b4{width:0.723in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8be{width:0.625in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8c8{width:0.82in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8c9{width:0.633in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 1.5pt solid rgba(102, 102, 102, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8d2{width:0.723in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8d3{width:0.625in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8dc{width:0.82in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8dd{width:0.633in;background-color:transparent;vertical-align: middle;border-bottom: 0 solid rgba(0, 0, 0, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8e6{width:0.723in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8e7{width:0.625in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8f0{width:0.82in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}.cl-e490f8f1{width:0.633in;background-color:transparent;vertical-align: middle;border-bottom: 1.5pt solid rgba(102, 102, 102, 1.00);border-top: 0 solid rgba(0, 0, 0, 1.00);border-left: 0 solid rgba(0, 0, 0, 1.00);border-right: 0 solid rgba(0, 0, 0, 1.00);margin-bottom:0;margin-top:0;margin-left:0;margin-right:0;}


mpg
```

cyl

disp

hp

drat

wt

qsec

vs

am

gear

carb

21.00

6.00

160.00

110.00

3.90

2.62

16.46

0.00

1.00

4.00

4.00

21.00

6.00

160.00

110.00

3.90

2.88

17.02

0.00

1.00

4.00

4.00

22.80

4.00

108.00

93.00

3.85

2.32

18.61

1.00

1.00

4.00

1.00

21.40

6.00

258.00

110.00

3.08

3.21

19.44

1.00

0.00

3.00

1.00

18.70

8.00

360.00

175.00

3.15

3.44

17.02

0.00

0.00

3.00

2.00

18.10

6.00

225.00

105.00

2.76

3.46

20.22

1.00

0.00

3.00

1.00

mtcars \|\> [head](https://rdrr.io/r/utils/head.html)() \|\> ft(src=1)

[TABLE]

mtcars \|\> [head](https://rdrr.io/r/utils/head.html)() \|\>
ft("Footnote")

[TABLE]

mtcars \|\> [head](https://rdrr.io/r/utils/head.html)() \|\>
ft("Footnote",src=1)

[TABLE]

mtcars \|\> [head](https://rdrr.io/r/utils/head.html)() \|\>
ft(sig=2,dig=1)

| mpg  | cyl | disp  | hp    | drat | wt  | qsec | vs  | am  | gear | carb |
|------|-----|-------|-------|------|-----|------|-----|-----|------|------|
| 21.0 | 6.0 | 160.0 | 110.0 | 3.9  | 2.6 | 16.0 | 0.0 | 1.0 | 4.0  | 4.0  |
| 21.0 | 6.0 | 160.0 | 110.0 | 3.9  | 2.9 | 17.0 | 0.0 | 1.0 | 4.0  | 4.0  |
| 23.0 | 4.0 | 110.0 | 93.0  | 3.8  | 2.3 | 19.0 | 1.0 | 1.0 | 4.0  | 1.0  |
| 21.0 | 6.0 | 260.0 | 110.0 | 3.1  | 3.2 | 19.0 | 1.0 | 0.0 | 3.0  | 1.0  |
| 19.0 | 8.0 | 360.0 | 180.0 | 3.2  | 3.4 | 17.0 | 0.0 | 0.0 | 3.0  | 2.0  |
| 18.0 | 6.0 | 220.0 | 100.0 | 2.8  | 3.5 | 20.0 | 1.0 | 0.0 | 3.0  | 1.0  |
