#' @importFrom googlesheets4 gs4_get
#' @importFrom magrittr extract2
#' @importFrom dplyr %>% pull
#' @export

get_sheet_names <- function(sheet_id){

  gs4_get(spreadsheet_id) %>%
    extract2("sheets") %>%
    pull(name)
}
