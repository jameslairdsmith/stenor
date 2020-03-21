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
