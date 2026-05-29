# Guide to table making

``` r


library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(gt)
library(periglue)
```

## Why this guide?

I have made a lot of tables and, if I’m being honest, they are not much
fun. The primary reason I wrote `periglue` was to help abstract away
some of the really tedious aspects of dealing with tables, but there is
also a basic system that `periglue` fits into to make tables far less
painful. I have boiled that system down into three main ideas

- Structuring data for a table

- Making table values

- Making an inline object

If you find yourself working on a manuscript with lots of tables, I
think you will find this framework to be extremely helpful.

## Make the table data

``` r


starwars_smry <- na.omit(starwars) %>% 
  filter(eye_color %in% c('blue', 'brown', 'hazel')) %>% 
  group_by(sex, eye_color) %>% 
  summarize(
    across(
      c(height, mass),
      .fns = list(
        lwr = ~quantile(.x, probs = 0.25),
        est = ~quantile(.x, probs = 0.50),
        upr = ~quantile(.x, probs = 0.75)
      )
    )
  )
#> `summarise()` has regrouped the output.
#> ℹ Summaries were computed grouped by sex and eye_color.
#> ℹ Output is grouped by sex.
#> ℹ Use `summarise(.groups = "drop_last")` to silence this message.
#> ℹ Use `summarise(.by = c(sex, eye_color))` for per-operation grouping
#>   (`?dplyr::dplyr_by`) instead.
```

## Make the table values

Tabulated data should provide both a point estimate and a measure of
uncertainty that goes along with the estimate, e.g. a 95% confidence
interval.
[`peri_glue()`](https://perisphere-rwe.github.io/periglue/reference/peri_glue.md)
is a nice function for putting together a point estimate and confidence
interval. I use a magnitude based rounding specification to keep
presentations consistent between height and mass.

``` r


rspec <- round_spec() %>% 
  round_half_even() %>% 
  round_using_magnitude(breaks = c(1, 10, 100, Inf),
                        digits = c(2, 1,  1, 0))

names(rspec) <- paste('periglue', names(rspec), sep = '.')

options(rspec)

starwars_tbl <- starwars_smry %>% 
  transmute(
    sex, 
    eye_color, 
    tbv_height = peri_glue("{height_est} ({height_lwr} - {height_upr})"),
    tbv_mass = peri_glue("{mass_est} ({mass_lwr} - {mass_upr})")
  )
```

## Make the table

Keeping your data in a tidy table format makes it fairly straightforward
to make a publication ready `gt` table. Most of the code is spent on
re-naming things and labeling, which is how it should be.

``` r


starwars_tbl %>% 
  mutate(
    sex = recode(sex, 
                 'female' = 'Female characters', 
                 'male'   = 'Male characters'),
    eye_color = recode(eye_color, 
                       blue  = 'Blue',
                       brown = 'Brown',
                       hazel = 'Hazel')
  ) %>% 
  gt(groupname_col = 'sex',  rowname_col = 'eye_color') %>% 
  cols_label(tbv_height = 'Height, cm', tbv_mass = 'Mass, kg') %>% 
  cols_align('center') %>% 
  tab_stubhead(label = 'Eye color') %>% 
  tab_spanner(label = 'Median (25th, 75th percentile)',
              columns = starts_with('tbv')) %>% 
  tab_source_note(md('For more on these data, see `?dplyr::starwars`'))
```

[TABLE]

## Make an inline object

It isn’t always enough to make the table. Sometimes (okay, probably
always), you need to interpret it too. If you are writing a report in
Markdown, it may feel natural to use inline code to write out your
interpretation, but it may also become tedious and discouraging for a
few reasons:

1.  You may need to copy and paste a lot of code to get the numbers you
    want

2.  You may find it hard to maintain this code if you work with
    co-authors who suggest you report *different* numbers than the ones
    you wrote out in your draft.

### Access table data directly

Let’s take the approach where we access the table data directly first to
highlight how this approach can get tedious. First I need to get the
table values I am interested in, which is the heights of males and
females

``` r


starwars_inline_female_brown_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'brown') %>% 
  pull(tbv_height)

starwars_inline_female_blue_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'blue') %>% 
  pull(tbv_height)

starwars_inline_female_hazel_height <- starwars_tbl %>% 
  filter(sex == 'female', eye_color == 'hazel') %>% 
  pull(tbv_height)
```

Now I have all I need to write my sentence:

“Female characters in Starwars with hazel eye color were, on average,
taller than their counterparts with blue or brown eyes. The median
(25^(th), 75^(th) percentile) heights of these groups were 178 (178 -
178) for hazel, 166 (166 - 168) for blue, and 168 (159 - 176) for brown
eyed female characters.”

The great thing about writing results inline is that it drastically
reduces the chance of a copy/paste error, which can get your paper
rejected before it even goes out to reviewers. However, this approach
also has limitations:

1.  It still relies pretty heavily on copying and pasting your code, and
    you could make a mistake there (I often do).

2.  When you send this draft to your colleagues, one of them might
    suggest it would be more interesting to compare heights of male
    versus female characters with the same eye color, which means you
    will have to go back and create new inline objects.

3.  Naming the inline objects will get *extremely* tedious in
    complicated tables. For the relatively simple table above, you can
    see we have to use quite a lot of text to name things clearly.

### convert table data into a hierarchical list.

Keeping your table data in a nested list will solve almost all of the
limitations above (nothing will solve colleagues who like to change your
paper, sorry).

1.  A list can store all of your table data programmatically, so you
    never to copy/paste code.

2.  Hierarchical lists support names for each nested list, so your
    inline object will actually name itself!

`periglue` provides a function to make your inline object. Assuming you
have put your data into a tidy table format, this is all you need.

``` r


starwars_inline <- starwars_tbl %>% 
  as_inline(tbl_variables = c("sex", "eye_color"),
            tbl_values = c("tbv_height", "tbv_mass"))

print(starwars_inline)
#> $female
#> $female$blue
#> $female$blue$tbv_height
#> [1] "166 (166 - 168)"
#> 
#> $female$blue$tbv_mass
#> [1] "56.2 (53.1 - 65.6)"
#> 
#> 
#> $female$brown
#> $female$brown$tbv_height
#> [1] "168 (159 - 176)"
#> 
#> $female$brown$tbv_mass
#> [1] "47.0 (46.0 - 48.0)"
#> 
#> 
#> $female$hazel
#> $female$hazel$tbv_height
#> [1] "178 (178 - 178)"
#> 
#> $female$hazel$tbv_mass
#> [1] "55.0 (55.0 - 55.0)"
#> 
#> 
#> 
#> $male
#> $male$blue
#> $male$blue$tbv_height
#> [1] "178 (175 - 188)"
#> 
#> $male$blue$tbv_mass
#> [1] "84.0 (79.0 - 112)"
#> 
#> 
#> $male$brown
#> $male$brown$tbv_height
#> [1] "183 (179 - 184)"
#> 
#> $male$brown$tbv_mass
#> [1] "79.5 (78.8 - 81.0)"
#> 
#> 
#> $male$hazel
#> $male$hazel$tbv_height
#> [1] "170 (170 - 170)"
#> 
#> $male$hazel$tbv_mass
#> [1] "77.0 (77.0 - 77.0)"
```

Some nice things about this:

1.  We have *all* the table data in one place, so updating our text will
    *only* require updating the text and won’t require any changes to
    the code.

2.  The names of the list are generated using categories of table
    variables, so the inline object is clear and easy to navigate
    (especially if you are using tab-completion of names in Rstudio!)

3.  Lists can easily be concatenated, so you could take two or more
    tables and make them into one inline object. (see below)

## Concatenate inline objects

If you have twenty tables, you may prefer to keep their data in one
(instead of twenty) inline objects. For the sake of keeping this brief,
let’s just duplicate the first inline object and then show how
concatenation would work:

``` r

other_inline <- starwars_inline
```

Now the concatenation:

``` r


inline = list(starwars = starwars_inline,
              other = other_inline)

# now you can access all your table data in one place. Happy writing!
inline$starwars$female$blue$tbv_height
#> [1] "166 (166 - 168)"
inline$other$male$blue$tbv_height
#> [1] "178 (175 - 188)"
```
