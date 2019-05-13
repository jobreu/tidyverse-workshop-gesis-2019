library(filesstrings)

question_files <- 
  list.files(
    path = "./solutions/", 
    pattern = "_question.html"
    )

for (i in question_files) {
  paste0("./solutions/", i) %>%
    filesstrings::file.move(
      ., 
      "./exercises/",
      overwrite = TRUE
    )
}

