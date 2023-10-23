#' @export
#' @importFrom readr read_tsv
read_lesson <- function(tsv_file, col_names = c("result", "strokes"), ...){

  read_tsv(tsv_file, col_names = col_names, col_types = "cc", ...)
}

#' @export
#' @importFrom readr write_tsv
write_lesson <- function(data, output_dir, ...){

  write_tsv(data, output_dir, append = FALSE, col_names = FALSE, ...)

  message(paste0("Data sucsessfully written to `output_dir`."))

  data
}

#' @export
#' @importFrom dplyr slice
slice_lesson <- function(data, start_index, window_size = 5L){

  window_size <- window_size - 1L
  start_index <- min(max(1L, start_index), nrow(data))
  end_index <- min(start_index + window_size, nrow(data))

  slice(data, seq(start_index, end_index, by = 1L))
}

#' @export
#' @importFrom clipr write_clip
clip_lesson <- function(data, col_names = FALSE, return_new = TRUE ,...){

  write_clip(data, col.names = col_names, return_new = return_new, ...)

  message(paste("Data sucsessfully written to clipboard."))

  data
}




