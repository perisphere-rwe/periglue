# Package-level internal state. Used by set_default_rounding_spec() to store
# a session-wide default rounding specification without touching user options.
.periglue_internal <- new.env(parent = emptyenv())

safe_nsmall <- function(x){

  # why do we need this?
  # prevents hard stops when using format

  x <- max(x, 0)
  x <- min(x, 20)
  x
}

find_smallest_10 <- function(x, y = 1e-10){

  if(x < 1e-10) stop(
    'the number you are attempting to round is too small',
    call. = FALSE
  )

  if(x == Inf) return(Inf)

  if (x < y) { return(y/10) } else { find_smallest_10(x, y*10) }

}

duplicate_last <- function(x) c(x, x[length(x)])

is_empty <- function (x) length(x) == 0
