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

#'  @importFrom dplyr slice
#'  @export

slice_lesson <- function(data, end_index, window_size = 5L){

  window_size <- window_size - 1L
  end_index <- min(end_index, nrow(data))
  start_index <- max(end_index - window_size, 1L)

  slice(data, seq(start_index, end_index, by = 1L))
}
