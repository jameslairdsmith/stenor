#' @export

clip_practice <- function(end_index,
                          window_size = 5L,
                          dir = here("temp", "practice.tsv")){

  dir %>%
    read_lesson() %>%
    slice_lesson(end_index = end_index, window_size = window_size) %>%
    clip_lesson()
}

#' @importFrom here here
#' @export
here::here
