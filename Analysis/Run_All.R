#==============================================================================================#
# Script created by Bryce Richardson and Lindsay Chaney 2017
# Script created in version R 3.3.3 
# This script is used to run all necessary analsyis
#==============================================================================================#


####PACKAGES####
  #install and load the following packages
  packagelist <- c("survival", "ggplot2", "doBy", "lme4", "lmerTest",
                   "merTools", "MuMIn", "lattice", "xlsx", "data.table",
                   "gridExtra", "tidyr", "dplyr", "ggbiplot", "GGally", "devtools")

  new.packages <- packagelist[!(packagelist %in% installed.packages()[,"Package"])]

  if(length(new.packages)>0) {install.packages(new.packages, dependencies = TRUE)}

  #load needed packages
  library(survival) #survival analysis
  library(ggplot2) #plotting graphics
  library(doBy) #used for the summaryBy function
  library(lme4) #used for mixed effect linear models
  library(lmerTest) #used to significance test in for lme
  library(merTools) #analyzing mixed effect regression models
  library(MuMIn) #model selection
  library(lattice) #graphics
  library(xlsx) #read and write excel files
  library(data.table) #data wrangling
  library(gridExtra) #gridarrange and arrangeGrob for ggplots
  library(tidyr) #used for data wrangling
  library(dplyr) #used for data wrangling
  library(devtools) #allows installation of packages from github
  library(GGally) #graphics
    install_github("vqv/ggbiplot") #installs ggbiplot from github
  library(ggbiplot) #biplot using ggplot2

###FLOWERING###
  #source the flower analysis
  source('Analysis/flower_script.R')
  
###GROWTH###
  #source the growth rate analysis
  source('Analysis/growth_script.R')  
  
###SEED YIELD###
  #source the seed yeild analysis
  source('Analysis/seed_script.R')  
  
###SURVIVAL###
  #source the survival analysis
  source('Analysis/surv_script.R')
  
###PCA###
  #source the PCA joint analysis
  source('Analysis/pca_script.R')
  