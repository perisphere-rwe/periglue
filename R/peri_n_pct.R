
#' Format a count and percentage pair
#'
#' `peri_n_pct()` formats a count (`n`) and a proportion (`pct`) together as a
#'   character string in the form `"n (xx.x%)"`. This is the most common cell
#'   format in demographic and summary tables.
#'
#' @param n a numeric vector of counts (non-negative integers).
#' @param pct a numeric vector of proportions, i.e., values in \[0, 1\].
#'   These are multiplied by 100 before display.
#' @param rspec a `rounding_specification` object (see [round_spec]) used to
#'   format the percentage. Counts are always shown as whole numbers. If
#'   `NULL`, the current default rounding specification is used.
#' @param form a character string controlling how `n` and `pct` are combined.
#'   Use `{n}` and `{pct}` as placeholders. Defaults to `"{n} ({pct}%)"`.
#'
#' @return a character vector the same length as `n` and `pct`.
#'
#' @export
#'
#' @family table helpers
#'
#' @examples
#'
#' peri_n_pct(n = 123, pct = 0.452)
#'
#' # vectorised
#' peri_n_pct(n = c(123, 456, 0), pct = c(0.123, 0.456, 0))
#'
#' # NA proportions are replaced with miss_replace from the rounding spec
#' peri_n_pct(n = c(10, 0), pct = c(0.5, NaN))
#'
#' # large counts respect the big_mark setting
#' rspec <- round_spec() |> format_big(mark = ",")
#' peri_n_pct(n = 12345, pct = 0.678, rspec = rspec)
#'
#' # custom form
#' peri_n_pct(n = 123, pct = 0.452, form = "{n} [{pct}%]")
#'
peri_n_pct <- function(n,
                        pct,
                        rspec = NULL,
                        form  = "{n} ({pct}%)") {

  check_call(
    match.call(),
    expected = list(
      'n'    = list(type = 'numeric'),
      'pct'  = list(type = 'numeric', lwr = 0, upr = 1),
      'form' = list(type = 'character', length = 1)
    )
  )

  if (length(n) != length(pct)) stop(
    "The lengths of `n` and `pct` do not match.",
    call. = FALSE
  )

  .rspec <- if (!is.null(rspec)) rspec else round_spec()

  check_input(
    arg_name  = 'rspec',
    arg_value = .rspec,
    expected  = list(class = 'rounding_specification')
  )

  # Counts are always shown as whole numbers; all other formatting
  # settings (big_mark, miss_replace, etc.) are inherited from .rspec.
  n_rspec <- round_using_decimal(.rspec, digits = 0)
  .n   <- peri_value(n,         rspec = n_rspec)
  .pct <- peri_value(pct * 100, rspec = .rspec)

  .envir <- list(n = .n, pct = .pct)

  out <- as.character(
    do.call(glue::glue_data, args = list(form, .x = .envir))
  )

  # When pct is NA, peri_value returns miss_replace (e.g. "--"). If the form
  # contains a literal "%" after {pct}, that produces e.g. "--%". Strip it.
  miss <- .rspec$miss_replace
  if (nchar(miss) > 0)
    out <- gsub(paste0(miss, "%"), miss, out, fixed = TRUE)

  out

}
