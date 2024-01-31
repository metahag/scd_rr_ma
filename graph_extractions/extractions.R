library(metaDigitise)
library(tidyverse)

## IMPORTANT: name all graphs as follows: author_year-casename.png or author_year-casename.jpg

# import data from a folder containing all graphs
data <- metaDigitise(dir = "graph_extractions") # this needs to point to a folder where there are pictures to be digitised 

#to get raw data use the code below after an image had been digitised
digitized <- metaDigitise(dir = "graph_extractions", summary = FALSE)

# create a dataframe combining all studies from the list
studies_meta <- Reduce(rbind, Map(function(x,name) cbind(x,study_case = name), 
                        digitized$scatterplot, names(digitized$scatterplot)))

# round up x to create session numbers and remove png/jpg sufixes from the study name
studies_meta <- studies_meta %>% mutate(session = round(x, digits = 0),
                                      study_case = str_remove(study_case, "\\.([^\\.]+)$"),
                                      phase = id) %>% 
                                separate(study_case, c("study", "case"), sep = "-")

write_csv(studies_meta, "analysis/studies_meta.csv")
