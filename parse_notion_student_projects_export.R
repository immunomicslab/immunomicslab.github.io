library("tidyverse")
d <- read_csv(file = "data/Student Projects e5dd27857c6e422fba7747b2d7f12a3d.csv")
d |>
  mutate(proj_start = str_split(`Project Period`, "→") |> map(1)) |>
  unnest(proj_start) |>
  mutate(proj_start = mdy(proj_start)) |>
  mutate(proj_end = str_split(`Project Period`, "→") |> map(2)) |>
  unnest(proj_end) |>
  mutate(proj_end = mdy(proj_end)) |>
  arrange(desc(proj_start)) |>
  mutate(line = str_c("- [", `Student Name`, "](), ", Type, " student: ", '"', Title, '"', " (", `Project Period`, ")",
                      if_else(!is.na(Company), str_c(" in collaboration with ", Company), ""))) |> 
  pull(line) |> 
  cat(sep = "\n")

