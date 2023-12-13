#' @importFrom purrr map_dfr
#' @export
read_sheet_dictionary <- function(spreadsheet_id){

  sheet_names <- get_sheet_names(spreadsheet_id)

  map_dfr(sheet_names, read_steno_sheet, spreadsheet_id = spreadsheet_id)
}

#' @importFrom dplyr everything filter_all any_vars
#' @importFrom googlesheets4 read_sheet
#' @export
read_steno_sheet <- function(spreadsheet_id, sheet_name){

  read_sheet(spreadsheet_id, sheet = sheet_name, col_types = "c") %>%
    filter_all(any_vars(!is.na(.))) %>%
    mutate(dictionary_name = sheet_name) %>%
    select(dictionary_name, everything())
}

#' @importFrom googlesheets4 gs4_get
#' @importFrom magrittr extract2
#' @importFrom dplyr pull
#' @export
get_sheet_names <- function(spreadsheet_id){

  gs4_get(spreadsheet_id) %>%
    extract2("sheets") %>%
    pull(name)
}
