library(tidyverse)

files <- list.files("analysis/piloted_graph_extractions", pattsern = "*.csv")

# Function to read each file and add the filename as a column
read_csv_with_filename <- function(filename) {
  df <- read.csv(paste0("analysis/piloted_graph_extractions/",filename))
  df$filename <- filename
  return(df)
}

list_of_dfs <- lapply(files, read_csv_with_filename)

combined_df <- bind_rows(list_of_dfs) %>% 
  mutate(x_round = round(x, digits = 0),
         y_round = round(y, digits = 0))

filtered_df <- combined_df %>%
  filter(apply(., 1, function(row) any(str_detect(tolower(row), "baseline|intervention"))))


reliability_df <- filtered_df %>% select(id, x, y, filename, case, study) %>% 
  mutate(id = case_when(id == "interventions" ~ "intervention",
                        id == "intervention sessions" ~ "intervention",
                        TRUE ~ id))

write_csv(reliability_df, "analysis/reliability_df.csv")


# plot graphs for each extraction
study_1 <- reliability_df %>%
  filter(study == "Browder_2012") %>%
  ggplot(aes(x = x, y = y, color = filename)) + 
  geom_point(aes(color = filename)) +
  geom_line(aes(color = filename)) +
  facet_wrap(~ case) + 
  theme_minimal()

ggsave("study_1.jpeg", study_1, path = "analysis/reliability_plots")

study_2 <- reliability_df %>%
  filter(study == "Calik_2010") %>%
  ggplot(aes(x = x, y = y, color = filename)) + 
  geom_point(aes(color = filename)) +
  geom_line(aes(color = filename)) +
  theme_minimal()

ggsave("study_2.jpeg", study_2, path = "analysis/reliability_plots")

study_3 <- reliability_df %>%
  filter(study == "Champan_2019") %>%
  ggplot(aes(x = x, y = y, color = filename)) + 
  geom_point(aes(color = filename)) +
  geom_line(aes(color = filename)) +
  theme_minimal()

ggsave("study_3.jpeg", study_3, path = "analysis/reliability_plots")

