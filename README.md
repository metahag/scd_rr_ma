```
Project Root
│
├── analysis
│   └── analysis_plan.qmd - Contains the code to reproduce the meta-analysis.
│    └── data.csv - dataset with all cases from all studies
│
├── extraction
│   ├── extractions.R
│      └── R script that extracts all graphs present in the "extraction" directory into one dataset.
│
└── reading_scd_ma_rr.Rproj
    └── Project file for RStudio.
```

CodeOcean capsule for the Stage 1 code: (https://doi.org/10.24433/CO.4098544.v1)[https://doi.org/10.24433/CO.4098544.v1] takes cca 8 hours to complete the run.

# Files and Folder Descriptions 

**analysis_plan.qmd**

This file contains the code required to reproduce the meta-analysis. It
includes RMarkdown syntax and should be run within an R environment
capable of processing .qmd files. 

**extraction**

This directory is central to the project and includes graph images and
scripts related to graph data extraction. 


**reading_scd_ma_rr.Rproj**

An RStudio project file that sets up the environment for this project.
Opening this file in RStudio will set the working directory to the
project root and load any project-specific settings. Extracting Data
from Graphs


*Running the Project*

To run this project, follow these steps:

1. Open RStudio
2. Create a new project, click on “version control”, click on “git”, paste: https://github.com/metahag/scd_rr_ma.git
3. Go to **analysis** directory and open **analysis_qmd**
4. Install necessary packages and knit the file

*Requirements*

Necessary R packages (listed in the scripts as well): 
brms, tidyverse, bayesplot, tidybayes - for the analysis
juicR, BiocManager, metagear, rvest - for data extraction

The analyses were done in:
R version 4.3.1 (2023-06-16) 
Platform: aarch64-apple-darwin20 (64-bit)
Running under: macOS Sonoma 14.0


