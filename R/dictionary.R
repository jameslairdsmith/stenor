#' @importFrom jsonlite fromJSON
#' @export
read_plover_dict <- function(dir){

  dir %>%
    fromJSON(simplifyVector = F, flatten = F) %>%
    flatten_dfc() %>%
    t() %>%
    as.data.frame(stringsAsFactors = F) %>%
    rownames_to_column("strokes") %>%
    as_tibble() %>%
    rename(result = "V1") %>%
    select(result, strokes)
}

#' @export
read_plover_dir <- function(dir){

  dir %>%
    dir_ls() %>%
    tibble(dir = .) %>%
    mutate(file_name = str_extract(dir, "[^/]*$"),
           file_name = str_remove(file_name, ".json"),
           file = map(dir, read_plover_dict)) %>%
    unnest(cols = c(file)) %>%
    select(-dir)
}

#' @importFrom jsonlite toJSON
#' @export
write_plover_dict <- function(df, output_dir = NULL){

  ## must have two columns, 'stroke' and 'translation'

  out <-
    df %>%
    select(stroke, translation) %>%
    mutate_at(vars(stroke, translation), as.character) %>%
    mutate(rowlist = map2(stroke, translation, make_named_list)) %>%
    pull(rowlist) %>%
    flatten() %>%
    toJSON(pretty = T,
           auto_unbox = F) %>%
    str_replace_all("\\[", "") %>%
    str_replace_all("\\]", "")

  if(!is.null(output_dir)){
    write(out, output_dir)
    message("Output written to ", output_dir)
  }
  out
}

#' @importFrom tidyr nest
#' @importFrom purrr walk2
#' @export
write_plover_dir <- function(sheet_dict, output_dir){

  ## Must have a column called "dictionary name"

  sheet_dict %>%
    nest(sheet_data = -one_of("dictionary_name")) %>%
    mutate(dict_json = map(sheet_data, write_plover_dict),
           result_output_dir = paste0(output_dir, dictionary_name, ".json"),
           written_result = walk2(dict_json, result_output_dir, write))
}

make_named_list <- function(col_for_names, col_for_values){

  out <- list(col_for_values)
  names(out) <- col_for_names
  out
}
