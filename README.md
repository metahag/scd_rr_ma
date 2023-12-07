```
Project Root
│
├── analysis
│   └── analysis_plan.qmd - Contains the code to reproduce the meta-analysis.
│    └── studies_meta.csv - dataset with all cases from all studies
│
├── graph_extractions
│   ├── extractions.R
│      └── R script that extracts all graphs into one dataset.
│
└── reading_scd_ma_rr.Rproj
    └── Project file for RStudio.
```

# Graph data extraction instructions
Pre-requisites
Ensure all graphs are named following the format: 
"author_year-case_number.png" or "author_year-case_number.jpg".

Steps

Import Graph Data: Place all the graph images you want to digitize in a folder named "graph_extractions".

Once you run the first line, interactive package will appear in the console. Just follow the instructions until you finish the plot. Find detailed instructions here: https://cran.r-project.org/web/packages/metaDigitise/vignettes/metaDigitise.html

# Files and Folder Descriptions 

**analysis_plan.qmd**

This file contains the code required to reproduce the meta-analysis. It
includes RMarkdown syntax and should be run within an R environment
capable of processing .qmd files. 

**graph_extractions**

This directory is central to the project and includes graph images and
scripts related to graph data extraction. 


**pilot_rr_reading_scd.Rproj**

An RStudio project file that sets up the environment for this project.
Opening this file in RStudio will set the working directory to the
project root and load any project-specific settings. Extracting Data
from Graphs


*Running the Project*

To run this project, follow these steps:

- Open pilot_rr_reading_scd.Rproj in RStudio to set up the project environment.
- Use analysis_plan.qmd to perform the meta-analysis on the combined dataset.
It is not necessary to run other scripts to run the analysis.


*Requirements*

Necessary R packages (listed in the scripts as well): brms, tidyverse, metaDigitise.

The analyses were done in:
R version 4.3.1 (2023-06-16) 
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Sonoma 14.0


