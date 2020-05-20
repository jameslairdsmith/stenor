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

make_named_list <- function(col_for_names, col_for_values){

  out <- list(col_for_values)
  names(out) <- col_for_names
  out
}
