


#' Expressive rounding for table values
#'
#' @inheritParams peri_value
#'
#' @param ... strings to round and format. Multiple inputs are concatenated
#'   together. Named arguments are __not__ supported.
#'
#' @param .sep Separator used to separate elements
#'
#' @param .envir environment to evaluate each expression in.
#'
#' @return a character vector of length equal to the vectors supplied in `...`
#'
#' @export
#'
#' @family table helpers
#'
#' @examples
#'
#' x <- runif(10)
#' y <- runif(10)
#'
#' peri_glue("{x} / {y} = {x/y}")
#'
#' peri_glue("{x}", "({100 * y}%)", .sep = ' ')
#'
#' df = data.frame(x = 1:10, y=1:10)
#'
#' peri_glue("{x} / {y} = {as.integer(x/y)}", .envir = df)
#' peri_glue("{x} / {y} = {as.integer(x/y)}")
#'
#' with(df, peri_glue("{x} / {y} = {as.integer(x/y)}"))
#'
#' mtcars$car <- rownames(mtcars)
#' # use the default rounding specification
#' peri_glue(
#'   "the {car} gets ~{mpg} miles/gallon and weighs ~{wt} thousand lbs",
#'   .envir = mtcars[1:3, ]
#' )
#'
#' # use your own rounding specification
#' rspec <- round_spec()
#' rspec <- round_using_decimal(rspec, digits = 1)
#'
#' peri_glue(
#'   "the {car} gets ~{mpg} miles/gallon and weighs ~{wt} thousand lbs",
#'   rspec = rspec,
#'   .envir = mtcars[1:3, ]
#' )

peri_glue <- function(
  ...,
  rspec = NULL,
  .sep = '',
  .envir = parent.frame()
){

  .dots <- substitute(alist(...))
  check_dots_are_characters(.dots)

  string <- Reduce(base::c, eval(.dots))
  string <- paste(string, collapse = .sep)

  # objects inside of {}
  pattern <- "(?<=\\{).+?(?=\\})"
  objects <- stringi::stri_extract_all_regex(string, pattern)
  objects <- objects[[1]]
  objects <- unique(objects)

  # find the most immediate rounding specification.
  .rspec <- if(!is.null(rspec)) rspec else round_spec()

  check_input(arg_name  = 'rspec',
              arg_value = .rspec,
              expected  = list(class = 'rounding_specification'))

  if(is.data.frame(.envir)) .envir <- list2env(.envir)

  # Create a child environment so that ..f is not injected into the
  # caller's environment. Variables in .envir are still found via the
  # parent chain.
  .eval_env <- new.env(parent = .envir)

  .eval_env$..f <- function(x){

    if (is.numeric(x)){
      trimws(peri_value(x, rspec = .rspec))
    } else {
      x
    }

  }

  # _p_attern
  p <- paste0("{", objects, "}")

  # _r_eplacement
  r <- paste0("{..f(", objects, ")}")

  for( i in seq_along(objects) ) string <- gsub(string,
                                                pattern = p[i],
                                                replacement = r[i],
                                                fixed = TRUE)

  # make output a character to avoid potential
  # issues with attributes of glue objects.
  as.character(glue::glue(string, .envir = .eval_env))


}
