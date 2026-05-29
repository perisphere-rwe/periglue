# Expressive rounding for table values

Expressive rounding for table values

## Usage

``` r
peri_glue(..., rspec = NULL, .sep = "", .envir = parent.frame())
```

## Arguments

- ...:

  strings to round and format. Multiple inputs are concatenated
  together. Named arguments are **not** supported.

- rspec:

  a `rounding_specification` object. If no `rspec` is given, a default
  setting will round values to decimal places based on the magnitude of
  the values.

- .sep:

  Separator used to separate elements

- .envir:

  environment to evaluate each expression in.

## Value

a character vector of length equal to the vectors supplied in `...`

## See also

Other table helpers:
[`peri_ester()`](https://perisphere-rwe.github.io/periglue/reference/peri_ester.md),
[`peri_n_pct()`](https://perisphere-rwe.github.io/periglue/reference/peri_n_pct.md),
[`peri_pvalue()`](https://perisphere-rwe.github.io/periglue/reference/peri_pvalue.md),
[`peri_value()`](https://perisphere-rwe.github.io/periglue/reference/peri_value.md)

## Examples

``` r

x <- runif(10)
y <- runif(10)

peri_glue("{x} / {y} = {x/y}")
#>  [1] "0.1 / 0.9 = 0.1"  "0.8 / 0.2 = 4.8"  "0.6 / 0.0 = 17.5" "0.2 / 0.3 = 0.5" 
#>  [5] "0.0 / 0.4 = 0.0"  "0.5 / 0.2 = 2.4"  "0.5 / 0.4 = 1.2"  "0.3 / 0.1 = 4.6" 
#>  [9] "0.7 / 0.4 = 1.9"  "0.8 / 1.0 = 0.8" 

peri_glue("{x}", "({100 * y}%)", .sep = ' ')
#>  [1] "0.1 (87.5%)" "0.8 (17.5%)" "0.6 (3.4%)"  "0.2 (32.0%)" "0.0 (40.2%)"
#>  [6] "0.5 (19.6%)" "0.5 (40.4%)" "0.3 (6.4%)"  "0.7 (38.9%)" "0.8 (97.6%)"

df = data.frame(x = 1:10, y=1:10)

peri_glue("{x} / {y} = {as.integer(x/y)}", .envir = df)
#>  [1] "1 / 1 = 1"   "2 / 2 = 1"   "3 / 3 = 1"   "4 / 4 = 1"   "5 / 5 = 1"  
#>  [6] "6 / 6 = 1"   "7 / 7 = 1"   "8 / 8 = 1"   "9 / 9 = 1"   "10 / 10 = 1"
peri_glue("{x} / {y} = {as.integer(x/y)}")
#>  [1] "0.1 / 0.9 = 0"  "0.8 / 0.2 = 4"  "0.6 / 0.0 = 17" "0.2 / 0.3 = 0" 
#>  [5] "0.0 / 0.4 = 0"  "0.5 / 0.2 = 2"  "0.5 / 0.4 = 1"  "0.3 / 0.1 = 4" 
#>  [9] "0.7 / 0.4 = 1"  "0.8 / 1.0 = 0" 

with(df, peri_glue("{x} / {y} = {as.integer(x/y)}"))
#>  [1] "1 / 1 = 1"   "2 / 2 = 1"   "3 / 3 = 1"   "4 / 4 = 1"   "5 / 5 = 1"  
#>  [6] "6 / 6 = 1"   "7 / 7 = 1"   "8 / 8 = 1"   "9 / 9 = 1"   "10 / 10 = 1"

mtcars$car <- rownames(mtcars)
# use the default rounding specification
peri_glue(
  "the {car} gets ~{mpg} miles/gallon and weighs ~{wt} thousand lbs",
  .envir = mtcars[1:3, ]
)
#> [1] "the Mazda RX4 gets ~21.0 miles/gallon and weighs ~2.6 thousand lbs"    
#> [2] "the Mazda RX4 Wag gets ~21.0 miles/gallon and weighs ~2.9 thousand lbs"
#> [3] "the Datsun 710 gets ~22.8 miles/gallon and weighs ~2.3 thousand lbs"   

# use your own rounding specification
rspec <- round_spec()
rspec <- round_using_decimal(rspec, digits = 1)

peri_glue(
  "the {car} gets ~{mpg} miles/gallon and weighs ~{wt} thousand lbs",
  rspec = rspec,
  .envir = mtcars[1:3, ]
)
#> [1] "the Mazda RX4 gets ~21.0 miles/gallon and weighs ~2.6 thousand lbs"    
#> [2] "the Mazda RX4 Wag gets ~21.0 miles/gallon and weighs ~2.9 thousand lbs"
#> [3] "the Datsun 710 gets ~22.8 miles/gallon and weighs ~2.3 thousand lbs"   
```
