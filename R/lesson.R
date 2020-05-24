#' @export
#' @importFrom readr read_tsv

read_lesson <- function(tsv_file, col_names = c("result", "strokes"), ...){

  read_tsv(tsv_file, col_names = col_names, col_types = "cc", ...)
}

#' @export
#' @importFrom readr write_tsv

write_lesson <- function(x, output_dir, ...){

  write_tsv(x, output_dir, append = FALSE, col_names = FALSE, ...)
}
