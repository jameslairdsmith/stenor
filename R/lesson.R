read_lesson <- function(tsv_file,
                        col_names = c("result", "strokes"),
                        ...){

  read_tsv(tsv_file,
           col_names = col_names,
           col_types = "cc",
           ...)
}


write_lesson <- function(x, output_dir, ...){

  write_tsv(x,
            output_dir,
            append = F,
            col_names = F,
            ...)
}
