# ---- Code for extracting data--------------
# To be used on images with single case intervention data
# 26/04/2024 by Marta Topor



#-------------BRFORE THE FIRST EXTRACTION --------------------------------
#Install the packages needed to use the graphic user interface for extraction of data

# remove comments to install the necessary package
#install.packages("BiocManager"); 
#BiocManager::install("EBImage")
library(metagear)

#devtools::install_github("mjlajeunesse/juicr")



#------------START EXTRACTION HERE-------------------------------

library(juicr)

setwd("extraction/")

GUI_juicr(
  groupNames = c("Baseline", "Intervention", "Maintenance"),
)



#-------------------------AFTER EXTRACTION-----------------------------
#Run the script below to extract your data in the format that is ready for analyses

# Prepare the data
#install.packages("rvest")
library(rvest)
library(tidyverse)

#list all extracted files
result_files <- list.files(pattern ="csv")
html_files <- list.files(pattern = "html")

mydata <- data.frame(matrix(ncol = 15, nrow = 0))
colnames(mydata) <- c("ID", "x", "y", "x_min", "x_max", "y_min", "y_max", "file_name", "case", "study", "success_count", "success_rate", "fail_rate", "measure", "measure_type")


#This will complite the data from all images into one dataframe ready for analyses
for (i in 1:length(result_files)){
  extracted_data <- read.csv(result_files[i])
  html_data <- read_html(html_files[i]) %>% 
    html_nodes('td')%>%
    html_text()
  
  temp_data <- data.frame(matrix(ncol = 15, nrow = length(extracted_data$group)))
  colnames(temp_data) <- c("ID", "x", "y", "x_min", "x_max", "y_min", "y_max", "file_name", "case", "study", "success_count", "success_rate", "fail_rate", "measure", "measure_type")
  
  temp_data$ID <- extracted_data$group
  temp_data$ID[temp_data$ID == "auto"] <- "Baseline" # we decided to leave the baseline as automatic calculation 
  temp_data$x <- extracted_data$x.calibrated
  temp_data$y <- extracted_data$y.calibrated
  temp_data$success_count <- round(temp_data$y) #success count is calculated by rounding up the data extracted from the y axis
  temp_data$file_name <- result_files[i]
  temp_data$case <- str_split_i(result_files[i], "_", 2) #taken from the image name position 2
  temp_data$study <- str_split_i(result_files[i], "_", 1) #taken from the image name position 1
  temp_data$measure <- str_split_i(result_files[i], "_", 3) #taken from the image name position 3
  
  
  #Extract further data from the html file
  html_row <- grep("age", html_data)
  html_scraped <- gsub("\\D", "", stringr::str_split_1(html_data[html_row], "\r\n"))
  html_scraped <- as.numeric(html_scraped)
  
  x_min <- html_scraped[1]
  x_max <- html_scraped[2]
  y_min <- html_scraped[3]
  y_max <- html_scraped[4]
  measure_type <- gsub("measure name = ", "", measure_type[5])

  temp_data$measure_type <- measure_type
  temp_data$x_min <- x_min
  temp_data$x_max <- x_max
  temp_data$y_min <- y_min
  temp_data$y_max <- y_max
  
  temp_data$success_rate <- temp_data$success_count/y_max
  temp_data$fail_rate <- 1 - temp_data$success_rate
  
  
  mydata <- as.data.frame(rbind(mydata, temp_data))
 
  rm(temp_data)


  }



write.csv(mydata, "./analysis/data.csv", row.names = FALSE)
