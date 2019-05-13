library(filesstrings)

question_files <- 
  list.files(
    path = "./solutions/", 
    pattern = "_question.html"
    )

for (i in question_files) {
  filesstrings::file.move(
    paste0("./solutions/", i), 
    "./exercises/",
    overwrite = TRUE
    )
}

