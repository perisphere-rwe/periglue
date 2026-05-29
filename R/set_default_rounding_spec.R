
#' Set the default rounding specification used by periglue functions
#'
#' Stores a `rounding_specification` object as the session-wide default used
#' by [peri_glue()] and [peri_value()] when no `rspec` argument is supplied.
#' This is an alternative to setting individual `periglue.*` options by hand.
#' Pass `NULL` to clear the stored default and revert to factory settings.
#'
#' @param rspec a `rounding_specification` object created with [round_spec()],
#'   or `NULL` to clear the current default.
#'
#' @return invisibly returns the previous default rounding specification, or
#'   `NULL` if none was set. This makes it easy to save and restore:
#'   `old <- set_default_rounding_spec(new_spec)`.
#'
#' @export
#'
#' @examples
#'
#' # Set a custom default
#' rspec <- round_spec() |> round_using_decimal(digits = 3)
#' set_default_rounding_spec(rspec)
#'
#' # peri_* functions now use this spec without needing rspec = ...
#' peri_value(pi)
#'
#' # Clear the default to revert to factory settings
#' set_default_rounding_spec(NULL)
#'
#' peri_value(pi)
#'
set_default_rounding_spec <- function(rspec) {

  if (!is.null(rspec)) {
    check_input(
      arg_name  = 'rspec',
      arg_value = rspec,
      expected  = list(class = 'rounding_specification')
    )
  }

  old <- .periglue_internal$rspec
  .periglue_internal$rspec <- rspec
  invisible(old)

}
