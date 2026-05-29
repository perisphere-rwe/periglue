# Convert table data to inline list

Convert table data to inline list

## Usage

``` r
as_inline(data, tbl_variables, tbl_values)
```

## Arguments

- data:

  a data frame.

- tbl_variables:

  column names that will be used to form groups in the table

- tbl_values:

  column names that contains table values.

## Value

a list of `tbl_values` values for each permutation of `tbl_variables`

## Note

variables in `tbl_variables` that have missing values will be have their
missing values converted into an explicit category named
variable_missing, where 'variable' is the name of the variable.

## Examples

``` r

example_data <- data.frame(
  sex = c("female", "male"),
  height = c("158 (154 - 161)", "178 (175 - 188)")
)

as_inline(example_data, tbl_variables = 'sex', tbl_values = 'height')
#> $female
#> [1] "158 (154 - 161)"
#> 
#> $male
#> [1] "178 (175 - 188)"
#> 

car_data <- mtcars
car_data$car_name <- rownames(mtcars)
as_inline(car_data, tbl_variables = 'car_name', tbl_values = 'mpg')
#> $`AMC Javelin`
#> [1] 15.2
#> 
#> $`Cadillac Fleetwood`
#> [1] 10.4
#> 
#> $`Camaro Z28`
#> [1] 13.3
#> 
#> $`Chrysler Imperial`
#> [1] 14.7
#> 
#> $`Datsun 710`
#> [1] 22.8
#> 
#> $`Dodge Challenger`
#> [1] 15.5
#> 
#> $`Duster 360`
#> [1] 14.3
#> 
#> $`Ferrari Dino`
#> [1] 19.7
#> 
#> $`Fiat 128`
#> [1] 32.4
#> 
#> $`Fiat X1-9`
#> [1] 27.3
#> 
#> $`Ford Pantera L`
#> [1] 15.8
#> 
#> $`Honda Civic`
#> [1] 30.4
#> 
#> $`Hornet 4 Drive`
#> [1] 21.4
#> 
#> $`Hornet Sportabout`
#> [1] 18.7
#> 
#> $`Lincoln Continental`
#> [1] 10.4
#> 
#> $`Lotus Europa`
#> [1] 30.4
#> 
#> $`Maserati Bora`
#> [1] 15
#> 
#> $`Mazda RX4`
#> [1] 21
#> 
#> $`Mazda RX4 Wag`
#> [1] 21
#> 
#> $`Merc 230`
#> [1] 22.8
#> 
#> $`Merc 240D`
#> [1] 24.4
#> 
#> $`Merc 280`
#> [1] 19.2
#> 
#> $`Merc 280C`
#> [1] 17.8
#> 
#> $`Merc 450SE`
#> [1] 16.4
#> 
#> $`Merc 450SL`
#> [1] 17.3
#> 
#> $`Merc 450SLC`
#> [1] 15.2
#> 
#> $`Pontiac Firebird`
#> [1] 19.2
#> 
#> $`Porsche 914-2`
#> [1] 26
#> 
#> $`Toyota Corolla`
#> [1] 33.9
#> 
#> $`Toyota Corona`
#> [1] 21.5
#> 
#> $Valiant
#> [1] 18.1
#> 
#> $`Volvo 142E`
#> [1] 21.4
#> 
```
