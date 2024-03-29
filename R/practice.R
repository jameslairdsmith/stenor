#' @export
clip_practice <- function(start_index,
                          window_size = 5L,
                          dir = here("temp", "practice.tsv")){

  dir %>%
    read_lesson() %>%
    slice_lesson(start_index = start_index,
                 window_size = window_size) %>%
    clip_lesson()
}

#' @importFrom here here
#' @export
here::here
