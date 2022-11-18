options(digits=3, scipen=20, repos="https://mirrors.nics.utk.edu/cran/")
ver <- "1.8"

# Install R packages
packages = c("askpass", "assertthat", "backports", "base64enc", "BH", "blob", "broom",
             "callr", "cellranger", "cli", "clipr", "colorspace", "cpp11", "crayon",
             "curl", "DBI", "dbplyr", "digest", "dplyr", "ellipsis", "evaluate",
             "fansi", "farver", "forcats", "fs", "generics", "ggplot2", "glue",
             "gtable", "haven", "highr", "hms", "htmltools", "httr", "isoband",
             "jsonlite", "knitr", "labeling", "lifecycle", "lubridate", "magrittr",
             "markdown", "mime", "modelr", "munsell", "openssl", "pillar",
             "pkgconfig", "prettyunits", "processx", "progress", "ps", "purrr",
             "R6", "RColorBrewer", "Rcpp", "readr", "readxl", "rematch", "reprex",
             "rlang", "rmarkdown", "rstudioapi", "rvest", "scales", "selectr",
             "stringi", "stringr", "sys", "tibble", "tidyr", "tidyselect",
             "tidyverse", "tinytex", "utf8", "vctrs", "viridisLite", "withr", 
             "writexl", "xfun", "xml2", "yaml")
if (internet_access == TRUE) {
  package.check <- lapply(
    packages,
    FUN = function(x) {
      if(!require(x, character.only=TRUE)) {
        install.packages(x, lib=new_lib, dependencies=FALSE)
      }
    }
  )
}

require(tidyverse)
require(dplyr)
require(writexl)
require(readxl)

## Read in flat file
mesh <- read.csv(file="./flat_file.csv", na.strings=c("NA", "<NA>", "", " ", "NULL"))
names(mesh) <- toupper(names(mesh))
## Lists of variables
date.var <- c("DATETIMEBIRTH", 
              "DATETIMEDEATH", 
              "DATETIMESURGERY", 
              "INPAT_FOLLOW",
              "OUTPAT_FOLLOW",
              "DATETIMEREOPERATION", 
              "DATETIMEREMOVAL",    
              "DATETIMEPAIN", 
              "PREDATETIMEVOIDING", 
              "PERIDATETIMEVOIDING", 
              "POSTDATETIMEVOIDING", 
              "DATETIMEEROSION",    
              "DATETIMEFISTULA", 
              "DATETIMEINFECTION", 
              "DATETIMEPERFORATION") 
factor.var <- c("LAP_SLING",
                "RACE_WHITE", 
                "RACE_BLACK",
                "RACE_ASIAN",
                "RACE_NATIVE_HAWAIIAN_PACIFIC_ISLANDER",
                "RACE_AMERICAN_INDIAN_ALASKA_NATIVE",
                "RACE_UNKNOWN",
                "HISPANIC",
                "HISTORYMENOPAUSE",
                "INDICATION_REOPERATION", 
                "PREHISTORYCHRONICPAIN",
                "PERIHISTORYCHRONICPAIN",
                "POSTHISTORYCHRONICPAIN",
                "PREABSURG",
                "PERIABSURG",
                "POSTABSURG", 
                "URODYNAMICTESTING",
                "HISTORYSMOKING",
                "PRESURGERYDM",
                "PRESURGERYHTN",
                "PRESURGERYCAD",        
                "PRESURGERYPVD",
                "PRESURGERYHLD",
                "SUI_IND", #Incl/Excl
                "FEMALE", #Incl/Excl
                "VISITYEARPRIORSURGERY", #Incl/Excl
                "VISITYEARPOSTSURGERY", #Incl/Excl
                "PRIORPROLAPSE", #Incl/Excl
                "PRIORSUI", #Incl/Excl             
                "PRIORDIVERICULUM", #Incl/Excl
                "CONCOMITANTSURG", 
                "ATC_FIRST_GENERATION_CEPHALOSPORINS", 
                "ATC_ANILIDES",
                "ATC_NATURAL_AND_SEMISYNTHETIC_ESTROGENS_PLAIN",
                "ATC_PROTON_PUMP_INHIBITORS",
                "ATC_DRUGS_FOR_URINARY_FREQUENCY_AND_INCONTINENCE",
                "ATC_ELECTROLYTE_SOLUTIONS",
                "ATC_HMG_COA_REDUCTASE_INHIBITORS",
                "ATC_NATURAL_OPIUM_ALKALOIDS",
                "ATC_SEROTONIN_5HT3_ANTAGONISTS",
                "ATC_SELECTIVE_SEROTONIN_REUPTAKE_INHIBITORS",
                "ATC_OTHER_ANTIEPILEPTICS",
                "ATC_ACE_INHIBITORS_PLAIN",
                "ATC_OTHER_ANTIDEPRESSANTS",
                "ATC_THIAZIDES_PLAIN",
                "ATC_OTHER_UROLOGICALS",
                "ATC_FLUOROQUINOLONES",
                "ATC_BETA_BLOCKING_AGENTS_SELECTIVE",
                "ATC_BENZODIAZEPINE_DERIVATIVES",
                "ATC_NITROFURAN_DERIVATIVES",
                "ATC_OPIUM_ALKALOIDS_AND_DERIVATIVES",
                "ATC_THYROID_HORMONES",
                "ATC_AMIDES",
                "ATC_GLUCOCORTICOIDS",
                "ATC_PROPIONIC_ACID_DERIVATIVES",
                "ATC_ANGIOTENSIN_II_ANTAGONISTS_PLAIN",
                "ATC_DIHYDROPYRIDINE_DERIVATIVES",
                "ATC_PHENOTHIAZINE_DERIVATIVES",
                "ATC_PHENYLPIPERIDINE_DERIVATIVES",
                "ATC_H2_RECEPTOR_ANTAGONISTS",
                "ATC_ACETIC_ACID_DERIVATIVES_AND_RELATED_SUBSTANCES",
                "ATC_CORTICOSTEROIDS_PLAIN",
                "ATC_OTHER_ANTIHISTAMINES_FOR_SYSTEMIC_USE",
                "ATC_VITAMIN_D_AND_ANALOGUES",
                "ATC_PIPERAZINE_DERIVATIVES",
                "ATC_SULFONAMIDES_PLAIN",
                "ATC_NON_SELECTIVE_MONOAMINE_REUPTAKE_INHIBITORS",
                "ATC_OTHER_CENTRALLY_ACTING_AGENTS",
                "ATC_BIGUANIDES",
                "ATC_ANESTHETICS_FOR_TOPICAL_USE",
                "ATC_ANESTHETICS_LOCAL",
                "ATC_SOFTENERS_EMOLLIENTS",
                "ATC_OTHER_PLAIN_VITAMIN_PREPARATIONS",
                "ATC_OTHER_GENERAL_ANESTHETICS",
                "ATC_BENZODIAZEPINE_RELATED_DRUGS",
                "ATC_OTHER_QUATERNARY_AMMONIUM_COMPOUNDS",
                "ATC_TRIMETHOPRIM_AND_DERIVATIVES",
                "ATC_OPIOID_ANESTHETICS",
                "ATC_PENICILLINS_WITH_EXTENDED_SPECTRUM",            
                "ATC_INTERMEDIATE_ACTING_SULFONAMIDES",
                "HGB_UA_MIN", "HGB_UA_MEAN", "HGB_UA_MEDIAN", "HGB_UA_MAX", 
                "NITRITE_UA_MIN", "NITRITE_UA_MEAN", "NITRITE_UA_MEDIAN", "NITRITE_UA_MAX",
                "DEATH30d", "DEATH90d", "DEATH1Y", "DEATH2Y", "DEATH5Y", "DEATHevent",
                "REOPERATION30d", "REOPERATION90d", "REOPERATION1Y", "REOPERATION2Y", "REOPERATION5Y", "REOPERATIONevent",
                "REMOVAL30d", "REMOVAL90d", "REMOVAL1Y", "REMOVAL2Y", "REMOVAL5Y", "REMOVALevent",
                "PAIN30d","PAIN90d", "PAIN1Y", "PAIN2Y", "PAIN5Y", "PAINevent",
                "POSTVOIDING30d", "POSTVOIDING90d", "POSTVOIDING1Y", "POSTVOIDING2Y", "POSTVOIDING5Y", "POSTVOIDINGevent",                                     
                "EROSION30d", "EROSION90d", "EROSION1Y", "EROSION2Y", "EROSION5Y", "EROSIONevent",
                "FISTULA30d", "FISTULA90d", "FISTULA1Y", "FISTULA2Y", "FISTULA5Y", "FISTULAevent",                         
                "INFECTION7d", "INFECTION14d", "INFECTION30d", "INFECTIONevent",
                "PERFORATION30d", "PERFORATION90d", "PERFORATION1Y", "PERFORATION2Y", "PERFORATION5Y", "PERFORATIONevent",
                "FOLLOWUP30d", "FOLLOWUP90d", "FOLLOWUP1Y", "FOLLOWUP2Y", "FOLLOWUP5Y", "FOLLOWUPevent",
                "REGEX_ADJ_SLING", "REGEX_RETROPUBIC", "REGEX_SNGL_INC", "REGEX_TRANSOB", "REGEX_UNKNOWN",
                "REGEX_MESH", "REGEX_NO_MESH", "REGEX_INDETERMINATE_MESH")
numeric.var <- c("BMI",
                 "ALT_BSP_MIN", "ALT_BSP_MEAN", "ALT_BSP_MEDIAN", "ALT_BSP_MAX",
                 "AST_BSP_MIN", "AST_BSP_MEAN", "AST_BSP_MEDIAN", "AST_BSP_MAX",                                       
                 "ALBUMIN_BSP_MG_MIN", "ALBUMIN_BSP_MG_MEAN", "ALBUMIN_BSP_MG_MEDIAN", "ALBUMIN_BSP_MG_MAX",
                 "BUN_BSP_MG_MIN", "BUN_BSP_MG_MEAN", "BUN_BSP_MG_MEDIAN", "BUN_BSP_MG_MAX",                                    
                 "BILI_TOTAL_BSP_MG_MIN", "BILI_TOTAL_BSP_MG_MEAN", "BILI_TOTAL_BSP_MG_MEDIAN", "BILI_TOTAL_BSP_MG_MAX",
                 "CO2_BSP_MMOL_MIN", "CO2_BSP_MMOL_MEAN", "CO2_BSP_MMOL_MEDIAN", "CO2_BSP_MMOL_MAX",
                 "CA_BSP_MG_MIN", "CA_BSP_MG_MEAN", "CA_BSP_MG_MEDIAN", "CA_BSP_MG_MAX",
                 "CHOL_BSP_MG_MIN", "CHOL_BSP_MG_MEAN", "CHOL_BSP_MG_MEDIAN", "CHOL_BSP_MG_MAX",                                   
                 "CL_BSP_MMOL_MIN", "CL_BSP_MMOL_MEAN", "CL_BSP_MMOL_MEDIAN", "CL_BSP_MMOL_MAX",
                 "CREAT_BSP_MG_MIN", "CREAT_BSP_MG_MEAN", "CREAT_BSP_MG_MEDIAN", "CREAT_BSP_MG_MAX",                                  
                 "FERRITIN_BSP_MG_MIN", "FERRITIN_BSP_MG_MEAN", "FERRITIN_BSP_MG_MEDIAN", "FERRITIN_BSP_MG_MAX",
                 "GLUCOSE_BSP_MG_MIN", "GLUCOSE_BSP_MG_MEAN", "GLUCOSE_BSP_MG_MEDIAN", "GLUCOSE_BSP_MG_MAX",                                
                 "HDL_BSP_MG_MIN", "HDL_BSP_MG_MEAN", "HDL_BSP_MG_MEDIAN", "HDL_BSP_MG_MAX",
                 "HGBA1C_BSP_MIN", "HGBA1C_BSP_MEAN", "HGBA1C_BSP_MEDIAN", "HGBA1C_BSP_MAX",                                    
                 "HGB_BSP_GM_MIN", "HGB_BSP_GM_MEAN", "HGB_BSP_GM_MEDIAN", "HGB_BSP_GM_MAX",
                 "INR_BSP_MIN", "INR_BSP_MEAN", "INR_BSP_MEDIAN", "INR_BSP_MAX",
                 "I_CALCIUM_BSP_MG_MIN", "I_CALCIUM_BSP_MG_MEAN", "I_CALCIUM_BSP_MG_MEDIAN", "I_CALCIUM_BSP_MG_MAX",                              
                 "IRON_BSP_MG_MIN", "IRON_BSP_MG_MEAN", "IRON_BSP_MG_MEDIAN", "IRON_BSP_MG_MAX",
                 "K_BSP_MMOL_MIN", "K_BSP_MMOL_MEAN", "K_BSP_MMOL_MEDIAN", "K_BSP_MMOL_MAX",
                 "KETONES_UA_MIN", "KETONES_UA_MEAN", "KETONES_UA_MEDIAN", "KETONES_UA_MAX",
                 "LDL_BSP_MG_MIN", "LDL_BSP_MG_MEAN", "LDL_BSP_MG_MEDIAN", "LDL_BSP_MG_MAX",                                    
                 "MCHC_BSP_GM_MIN", "MCHC_BSP_GM_MEAN", "MCHC_BSP_GM_MEDIAN", "MCHC_BSP_GM_MAX",
                 "MCV_BSP_FL_MIN", "MCV_BSP_FL_MEAN", "MCV_BSP_FL_MEDIAN", "MCV_BSP_FL_MAX",                                    
                 "MAGNESIUM_BSP_MG_MIN", "MAGNESIUM_BSP_MG_MEAN", "MAGNESIUM_BSP_MG_MEDIAN", "MAGNESIUM_BSP_MG_MAX",
                 "NA_BSP_MMOL_MIN", "NA_BSP_MMOL_MEAN", "NA_BSP_MMOL_MEDIAN", "NA_BSP_MMOL_MAX",                                   
                 "PTT_BSP_MIN", "PTT_BSP_MEAN", "PTT_BSP_MEDIAN", "PTT_BSP_MAX",                                       
                 "PHOSPHATE_BSP_MG_MIN", "PHOSPHATE_BSP_MG_MEAN", "PHOSPHATE_BSP_MG_MEDIAN", "PHOSPHATE_BSP_MG_MAX",
                 "PLT_BSP_CNT_MIN", "PLT_BSP_CNT_MEAN", "PLT_BSP_CNT_MEDIAN", "PLT_BSP_CNT_MAX",                                   
                 "PROTEIN_UA_MIN", "PROTEIN_UA_MEAN", "PROTEIN_UA_MEDIAN", "PROTEIN_UA_MAX",
                 "RBC_UA_CNT_MIN", "RBC_UA_CNT_MEAN", "RBC_UA_CNT_MEDIAN", "RBC_UA_CNT_MAX",                                    
                 "SP_GRAVITY_UA_MIN", "SP_GRAVITY_UA_MEAN", "SP_GRAVITY_UA_MEDIAN", "SP_GRAVITY_UA_MAX",
                 "T4_BSP_UG_MIN", "T4_BSP_UG_MEAN", "T4_BSP_UG_MEDIAN", "T4_BSP_UG_MAX",                                     
                 "TIBC_BSP_MG_MIN", "TIBC_BSP_MG_MEAN", "TIBC_BSP_MG_MEDIAN", "TIBC_BSP_MG_MAX",
                 "TSH_BSP_MIU_MIN", "TSH_BSP_MIU_MEAN", "TSH_BSP_MIU_MEDIAN", "TSH_BSP_MIU_MAX",                                   
                 "TRANSFERRIN_BSP_MG_MIN", "TRANSFERRIN_BSP_MG_MEAN", "TRANSFERRIN_BSP_MG_MEDIAN", "TRANSFERRIN_BSP_MG_MAX",
                 "TRIG_BSP_MG_MIN", "TRIG_BSP_MG_MEAN", "TRIG_BSP_MG_MEDIAN", "TRIG_BSP_MG_MAX",                                   
                 "TROP_I_BSP_MG_MIN", "TROP_I_BSP_MG_MEAN", "TROP_I_BSP_MG_MEDIAN", "TROP_I_BSP_MG_MAX",
                 "TROP_T_BSP_MG_MIN", "TROP_T_BSP_MG_MEAN", "TROP_T_BSP_MG_MEDIAN", "TROP_T_BSP_MG_MAX",                                 
                 "WBC_BSP_CNT_MIN", "WBC_BSP_CNT_MEAN", "WBC_BSP_CNT_MEDIAN", "WBC_BSP_CNT_MAX",
                 "AGE_PROCEDURE",
                 "DAYS_SURGERY_DEATH",
                 "DAYS_SURGERY_REOPERATION",
                 "DAYS_SURGERY_REMOVAL",
                 "DAYS_SURGERY_PAIN",
                 "DAYS_SURGERY_PREVOIDING",
                 "DAYS_SURGERY_PERIVOIDING",
                 "DAYS_SURGERY_POSTVOIDING",
                 "DAYS_SURGERY_EROSION",
                 "DAYS_SURGERY_FISTULA",
                 "DAYS_SURGERY_INFECTION",
                 "DAYS_SURGERY_PERFORATION",
                 "DAYS_SURGERY_MOST_RECENT_INPAT_VISIT",
                 "DAYS_SURGERY_MOST_RECENT_OUTPAT_VISIT",
                 "DAYS_FOLLOWUP")

## Rename fields
colnames(mesh)[1] <- "PATID"
# Merge with regex to apply incl/excl to regex_approach and regex_mesh counts
regex <- data.frame(read_excel("./regex_output.xlsx"))
regex$PATID <- as.integer(regex$PERSON_ID)
mesh <- merge(mesh, subset(regex, select=c("PATID", "REGEX_Mesh_YN", "REGEX_Approach")),
              all.x=TRUE, by="PATID")
## Format dates
mesh <- mesh %>%
          mutate_at(vars(all_of(date.var)), as.Date, format=choose_date_format)
## Recode fields
mesh$RACE_WHITE <- ifelse(mesh$RACE == 'White', 1, 0)
mesh$RACE_BLACK <- ifelse(mesh$RACE == 'Black' | mesh$RACE == "Black or African American", 1, 0)
mesh$RACE_ASIAN <- ifelse(mesh$RACE == 'Asian', 1, 0)
mesh$RACE_AMERICAN_INDIAN_ALASKA_NATIVE <- ifelse(mesh$RACE == 'American Indian or Alaska Native', 1, 0)
mesh$RACE_NATIVE_HAWAIIAN_PACIFIC_ISLANDER <- ifelse(mesh$RACE == 'Native Hawaiian or Other Pacific Islander', 1, 0)
mesh$RACE_UNKNOWN <- ifelse(mesh$RACE == 'No matching concept', 1, 0)
# If DATETIMEBIRTH is missing, combine year, month, day variables if available
mesh$DATETIMEBIRTH[is.na(mesh$DATETIMEBIRTH) & !is.na(mesh$YEAR_OF_BIRTH) &
                  !is.na(mesh$MONTH_OF_BIRTH) & !is.na(mesh$DAY_OF_BIRTH)] <- 
  as.Date(sprintf("%s-%02s-%02s", mesh$YEAR_OF_BIRTH, mesh$MONTH_OF_BIRTH, mesh$DAY_OF_BIRTH),
          format="%Y-%m-%d")

## Generate fields
mesh$SYNTHETIC_MESH <- 1
mesh$NO_MESH <- 0
mesh$INDETERMINATE_MESH <- 0
mesh$AGE_PROCEDURE <- as.numeric(difftime(mesh$DATETIMESURGERY, mesh$DATETIMEBIRTH, units="days"))/365.25
mesh$DAYS_SURGERY_DEATH <- as.numeric(difftime(mesh$DATETIMEDEATH, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_MOST_RECENT_INPAT_VISIT <- as.numeric(difftime(mesh$INPAT_FOLLOW, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_MOST_RECENT_OUTPAT_VISIT <- as.numeric(difftime(mesh$OUTPAT_FOLLOW, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_REOPERATION <- as.numeric(difftime(mesh$DATETIMEREOPERATION, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_REMOVAL <- as.numeric(difftime(mesh$DATETIMEREMOVAL, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_PAIN <- as.numeric(difftime(mesh$DATETIMEPAIN, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_PREVOIDING <- as.numeric(difftime(mesh$PREDATETIMEVOIDING, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_PERIVOIDING <- as.numeric(difftime(mesh$PERIDATETIMEVOIDING, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_POSTVOIDING <- as.numeric(difftime(mesh$POSTDATETIMEVOIDING, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_EROSION <- as.numeric(difftime(mesh$DATETIMEEROSION, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_FISTULA <- as.numeric(difftime(mesh$DATETIMEFISTULA, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_INFECTION <- as.numeric(difftime(mesh$DATETIMEINFECTION, mesh$DATETIMESURGERY, units="days"))
mesh$DAYS_SURGERY_INFECTION[mesh$DAYS_SURGERY_INFECTION > 30] <- NA
mesh$DAYS_SURGERY_PERFORATION <- as.numeric(difftime(mesh$DATETIMEPERFORATION, mesh$DATETIMESURGERY, units="days"))
# DAYS_FOLLOWUP - use number of days to earliest event or latest follow-up date
mesh$DAYS_FOLLOWUP <- ifelse(!is.na(mesh$DATETIMEDEATH) | !is.na(mesh$DATETIMEREOPERATION) |
                            !is.na(mesh$DATETIMEREMOVAL) | !is.na(mesh$DATETIMEPAIN) |
                            !is.na(mesh$POSTDATETIMEVOIDING) | !is.na(mesh$DATETIMEEROSION) |
                            !is.na(mesh$DATETIMEFISTULA) | !is.na(mesh$DATETIMEINFECTION) |
                            !is.na(mesh$DATETIMEPERFORATION), 
                              pmin(mesh$DAYS_SURGERY_DEATH, mesh$DAYS_SURGERY_REOPERATION,
                                   mesh$DAYS_SURGERY_REMOVAL, mesh$DAYS_SURGERY_PAIN,
                                   mesh$DAYS_SURGERY_POSTVOIDING, mesh$DAYS_SURGERY_EROSION,
                                   mesh$DAYS_SURGERY_FISTULA, mesh$DAYS_SURGERY_INFECTION,
                                   mesh$DAYS_SURGERY_PERFORATION, na.rm=TRUE),
                            ifelse(!is.na(mesh$INPAT_FOLLOW) | !is.na(mesh$OUTPAT_FOLLOW),
                                   pmax(mesh$DAYS_SURGERY_MOST_RECENT_INPAT_VISIT, mesh$DAYS_SURGERY_MOST_RECENT_OUTPAT_VISIT, na.rm=TRUE),
                                   NA))
# Report counts of outcomes at 30d, 90d, 1y, 2y, and 5 years
mesh$DEATH30d <- ifelse(!(is.na(mesh$DATETIMEDEATH)) & mesh$DAYS_SURGERY_DEATH <= 30, 1, 0)
mesh$DEATH90d <- ifelse(!(is.na(mesh$DATETIMEDEATH)) & mesh$DAYS_SURGERY_DEATH <= 90, 1, 0)
mesh$DEATH1Y <- ifelse(!(is.na(mesh$DATETIMEDEATH)) & mesh$DAYS_SURGERY_DEATH <= 365, 1, 0)
mesh$DEATH2Y <- ifelse(!(is.na(mesh$DATETIMEDEATH)) & mesh$DAYS_SURGERY_DEATH <= 730, 1, 0)
mesh$DEATH5Y <- ifelse(!(is.na(mesh$DATETIMEDEATH)) & mesh$DAYS_SURGERY_DEATH <= 1825, 1, 0)
mesh$DEATHevent <- ifelse(!(is.na(mesh$DATETIMEDEATH)), 1, 0)
mesh$REOPERATION30d <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)) & mesh$DAYS_SURGERY_REOPERATION <= 30, 1, 0)
mesh$REOPERATION90d <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)) & mesh$DAYS_SURGERY_REOPERATION <= 90, 1, 0)
mesh$REOPERATION1Y <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)) & mesh$DAYS_SURGERY_REOPERATION <= 365, 1, 0)
mesh$REOPERATION2Y <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)) & mesh$DAYS_SURGERY_REOPERATION <= 730, 1, 0)
mesh$REOPERATION5Y <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)) & mesh$DAYS_SURGERY_REOPERATION <= 1825, 1, 0)
mesh$REOPERATIONevent <- ifelse(!(is.na(mesh$DATETIMEREOPERATION)), 1, 0)
mesh$REMOVAL30d <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)) & mesh$DAYS_SURGERY_REMOVAL <= 30, 1, 0)
mesh$REMOVAL90d <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)) & mesh$DAYS_SURGERY_REMOVAL <= 90, 1, 0)
mesh$REMOVAL1Y <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)) & mesh$DAYS_SURGERY_REMOVAL <= 365, 1, 0)
mesh$REMOVAL2Y <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)) & mesh$DAYS_SURGERY_REMOVAL <= 730, 1, 0)
mesh$REMOVAL5Y <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)) & mesh$DAYS_SURGERY_REMOVAL <= 1825, 1, 0)
mesh$REMOVALevent <- ifelse(!(is.na(mesh$DATETIMEREMOVAL)), 1, 0)
mesh$PAIN30d <- ifelse(!(is.na(mesh$DATETIMEPAIN)) & mesh$DAYS_SURGERY_PAIN <= 30, 1, 0)
mesh$PAIN90d <- ifelse(!(is.na(mesh$DATETIMEPAIN)) & mesh$DAYS_SURGERY_PAIN <= 90, 1, 0)
mesh$PAIN1Y <- ifelse(!(is.na(mesh$DATETIMEPAIN)) & mesh$DAYS_SURGERY_PAIN <= 365, 1, 0)
mesh$PAIN2Y <- ifelse(!(is.na(mesh$DATETIMEPAIN)) & mesh$DAYS_SURGERY_PAIN <= 730, 1, 0)
mesh$PAIN5Y <- ifelse(!(is.na(mesh$DATETIMEPAIN)) & mesh$DAYS_SURGERY_PAIN <= 1825, 1, 0)
mesh$PAINevent <- ifelse(!(is.na(mesh$DATETIMEPAIN)), 1, 0)
mesh$POSTVOIDING30d <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)) & mesh$DAYS_SURGERY_POSTVOIDING <= 30, 1, 0)
mesh$POSTVOIDING90d <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)) & mesh$DAYS_SURGERY_POSTVOIDING <= 90, 1, 0)
mesh$POSTVOIDING1Y <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)) & mesh$DAYS_SURGERY_POSTVOIDING <= 365, 1, 0)
mesh$POSTVOIDING2Y <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)) & mesh$DAYS_SURGERY_POSTVOIDING <= 730, 1, 0)
mesh$POSTVOIDING5Y <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)) & mesh$DAYS_SURGERY_POSTVOIDING <= 1825, 1, 0)
mesh$POSTVOIDINGevent <- ifelse(!(is.na(mesh$POSTDATETIMEVOIDING)), 1, 0)
mesh$PREVOIDINGevent <- ifelse(!(is.na(mesh$PREDATETIMEVOIDING)), 1, 0)
mesh$EROSION30d <- ifelse(!(is.na(mesh$DATETIMEEROSION)) & mesh$DAYS_SURGERY_EROSION <= 30, 1, 0)
mesh$EROSION90d <- ifelse(!(is.na(mesh$DATETIMEEROSION)) & mesh$DAYS_SURGERY_EROSION <= 90, 1, 0)
mesh$EROSION1Y <- ifelse(!(is.na(mesh$DATETIMEEROSION)) & mesh$DAYS_SURGERY_EROSION <= 365, 1, 0)
mesh$EROSION2Y <- ifelse(!(is.na(mesh$DATETIMEEROSION)) & mesh$DAYS_SURGERY_EROSION <= 730, 1, 0)
mesh$EROSION5Y <- ifelse(!(is.na(mesh$DATETIMEEROSION)) & mesh$DAYS_SURGERY_EROSION <= 1825, 1, 0)
mesh$EROSIONevent <- ifelse(!(is.na(mesh$DATETIMEEROSION)), 1, 0)
mesh$FISTULA30d <- ifelse(!(is.na(mesh$DATETIMEFISTULA)) & mesh$DAYS_SURGERY_FISTULA <= 30, 1, 0)
mesh$FISTULA90d <- ifelse(!(is.na(mesh$DATETIMEFISTULA)) & mesh$DAYS_SURGERY_FISTULA <= 90, 1, 0)
mesh$FISTULA1Y <- ifelse(!(is.na(mesh$DATETIMEFISTULA)) & mesh$DAYS_SURGERY_FISTULA <= 365, 1, 0)
mesh$FISTULA2Y <- ifelse(!(is.na(mesh$DATETIMEFISTULA)) & mesh$DAYS_SURGERY_FISTULA <= 730, 1, 0)
mesh$FISTULA5Y <- ifelse(!(is.na(mesh$DATETIMEFISTULA)) & mesh$DAYS_SURGERY_FISTULA <= 1825, 1, 0)
mesh$FISTULAevent <- ifelse(!(is.na(mesh$DATETIMEFISTULA)), 1, 0)
mesh$INFECTION7d <- ifelse(!(is.na(mesh$DATETIMEINFECTION)) & mesh$DAYS_SURGERY_INFECTION <= 7, 1, 0)
mesh$INFECTION14d <- ifelse(!(is.na(mesh$DATETIMEINFECTION)) & mesh$DAYS_SURGERY_INFECTION <= 14, 1, 0)
mesh$INFECTION30d <- ifelse(!(is.na(mesh$DATETIMEINFECTION)) & mesh$DAYS_SURGERY_INFECTION <= 30, 1, 0)
mesh$INFECTIONevent <- ifelse(!(is.na(mesh$DATETIMEINFECTION)), 1, 0)
mesh$PERFORATION30d <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)) & mesh$DAYS_SURGERY_PERFORATION <= 30, 1, 0)
mesh$PERFORATION90d <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)) & mesh$DAYS_SURGERY_PERFORATION <= 90, 1, 0)
mesh$PERFORATION1Y <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)) & mesh$DAYS_SURGERY_PERFORATION <= 365, 1, 0)
mesh$PERFORATION2Y <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)) & mesh$DAYS_SURGERY_PERFORATION <= 730, 1, 0)
mesh$PERFORATION5Y <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)) & mesh$DAYS_SURGERY_PERFORATION <= 1825, 1, 0)
mesh$PERFORATIONevent <- ifelse(!(is.na(mesh$DATETIMEPERFORATION)), 1, 0)
mesh$FOLLOWUP30d <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)) & mesh$DAYS_FOLLOWUP >= 30, 1, 0) #At least 30d
mesh$FOLLOWUP90d <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)) & mesh$DAYS_FOLLOWUP >= 90, 1, 0) #At least 90d
mesh$FOLLOWUP1Y <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)) & mesh$DAYS_FOLLOWUP >= 365, 1, 0) #At least 1y
mesh$FOLLOWUP2Y <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)) & mesh$DAYS_FOLLOWUP >= 730, 1, 0) #At least 2y
mesh$FOLLOWUP5Y <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)) & mesh$DAYS_FOLLOWUP >= 1825, 1, 0) #At least 5y
mesh$FOLLOWUPevent <- ifelse(!(is.na(mesh$DAYS_FOLLOWUP)), 1, 0)
# Generate binary fields
mesh$REGEX_ADJ_SLING <- ifelse(!(is.na(mesh$REGEX_Approach)) & mesh$REGEX_Approach == "Adj_sling", 1, 0)
mesh$REGEX_UNKNOWN <- ifelse(!(is.na(mesh$REGEX_Approach)) & (mesh$REGEX_Approach == "Burch" |
                                                              mesh$REGEX_Approach == "Indeterminate"), 1, 0)
mesh$REGEX_RETROPUBIC <- ifelse(!(is.na(mesh$REGEX_Approach)) & mesh$REGEX_Approach == "Retropubic", 1, 0)
mesh$REGEX_SNGL_INC <- ifelse(!(is.na(mesh$REGEX_Approach)) & mesh$REGEX_Approach == "Sngl_Inc", 1, 0)
mesh$REGEX_TRANSOB <- ifelse(!(is.na(mesh$REGEX_Approach)) & (mesh$REGEX_Approach == "Transob_In_Out" |
                             mesh$REGEX_Approach == "Transob_Out_In" | mesh$REGEX_Approach == "Transob_Unk"), 1, 0)
mesh$REGEX_ADJ_SNGL_INC <- ifelse(!(is.na(mesh$REGEX_Approach)) & (mesh$REGEX_Approach == "Adj_sling" |
                                  mesh$REGEX_Approach == "Sngl_Inc"), 1, 0)
mesh$REGEX_MESH <- ifelse(!(is.na(mesh$REGEX_Mesh_YN)) & mesh$REGEX_Mesh_YN == "Yes", 1, 0)
mesh$REGEX_NO_MESH <- ifelse(!(is.na(mesh$REGEX_Mesh_YN)) & mesh$REGEX_Mesh_YN == "No", 1, 0)
mesh$REGEX_INDETERMINATE_MESH <- ifelse(!(is.na(mesh$REGEX_Mesh_YN)) & mesh$REGEX_Mesh_YN == "Indeterminate", 1, 0)
# Assess discordance
calcDiscord <- function(bin1, bin2){
  ifelse((!is.na(bin1) & !is.na(bin2) & bin1 != bin2) |
           (!is.na(bin1) & is.na(bin2)) |
           (is.na(bin1) & !is.na(bin2)), 1, 
         ifelse((!is.na(bin1) & !is.na(bin2) & bin1 == bin2) |
                  (is.na(bin1) & is.na(bin2)), 0, NA))
}
# Assess TP, TN, FP, FN
calcTN <- function(other, gold){
  ifelse(!is.na(gold) & !is.na(other) & gold == 1 & other == 1, 1,
         ifelse(!is.na(gold) & !is.na(other) & gold == 0 & other == 1, 2,
                ifelse(!is.na(gold) & !is.na(other) & gold == 1 & other == 0, 3,
                       ifelse(!is.na(gold) & !is.na(other) & gold == 0 & other == 0, 4, NA))))
}
# Assess data availability
bin4cat <- function(bin1, bin2){
  ifelse(!is.na(bin1) & !is.na(bin2), 1, #Both present
         ifelse(!is.na(bin1) & is.na(bin2), 2, #Structured only
                ifelse(is.na(bin1) & !is.na(bin2), 3, #Chart (or Regex) only
                       ifelse(is.na(bin1) & is.na(bin2), 4, NA)))) #Both NA
}
# Compare Structured vs Regex (Gold Standard)
mesh$MESH_DISCORDANT_RS <- calcDiscord(mesh$SYNTHETIC_MESH, mesh$REGEX_MESH)
mesh$NO_MESH_DISCORDANT_RS <- calcDiscord(mesh$NO_MESH, mesh$REGEX_NO_MESH) 
mesh$INDETERMINATE_MESH_DISCORDANT_RS <- calcDiscord(mesh$INDETERMINATE_MESH, mesh$REGEX_INDETERMINATE_MESH) 
mesh$MESH_TN_RS <- calcTN(mesh$SYNTHETIC_MESH, mesh$REGEX_MESH)
mesh$NO_MESH_TN_RS <- calcTN(mesh$NO_MESH, mesh$REGEX_NO_MESH) 
mesh$INDETERMINATE_MESH_TN_RS <- calcTN(mesh$INDETERMINATE_MESH, mesh$REGEX_INDETERMINATE_MESH) 
mesh$MESH_CAT4_RS <- bin4cat(mesh$SYNTHETIC_MESH, mesh$REGEX_MESH)
mesh$NO_MESH_CAT4_RS <- bin4cat(mesh$NO_MESH, mesh$REGEX_NO_MESH) 
mesh$INDETERMINATE_MESH_CAT4_RS <- bin4cat(mesh$INDETERMINATE_MESH, mesh$REGEX_INDETERMINATE_MESH) 

# Apply Inclusion/Exclusion Criteria
t1 <- length(mesh$PATID)
d1 <- NA
mesh <- mesh[!is.na(mesh$FEMALE) & mesh$FEMALE == 1,] 
t2 <- length(mesh$PATID)
d2 <- t1 - t2
mesh <- mesh[!is.na(mesh$AGE_PROCEDURE) & mesh$AGE_PROCEDURE >= 18,] 
t3 <- length(mesh$PATID)
d3 <- t2 - t3
mesh <- mesh[!is.na(mesh$SUI_IND) & mesh$SUI_IND == 1,] 
t4 <- length(mesh$PATID)
d4 <- t3 - t4
mesh <- mesh[!is.na(mesh$VISITYEARPRIORSURGERY) & mesh$VISITYEARPRIORSURGERY == 1,]
t5 <- length(mesh$PATID)
d5 <- t4 - t5
mesh <- mesh[!is.na(mesh$PRIORSUI) & mesh$PRIORSUI == 0,] 
t6 <- length(mesh$PATID)
d6 <- t5 - t6
# Include patients with sling or lap sling, not non-sling
mesh <- mesh[!is.na(mesh$LAP_SLING) & mesh$LAP_SLING == 1 & !is.na(mesh$NON_SLING) & mesh$NON_SLING == 1 |
             !is.na(mesh$LAP_SLING) & mesh$LAP_SLING == 1 & !is.na(mesh$NON_SLING) & mesh$NON_SLING == 0 |
             !is.na(mesh$LAP_SLING) & mesh$LAP_SLING == 0 & !is.na(mesh$NON_SLING) & mesh$NON_SLING == 0,]
t7 <- length(mesh$PATID)
d7 <- t6 - t7
mesh <- mesh[!is.na(mesh$PRIORDIVERICULUM) & mesh$PRIORDIVERICULUM == 0,] 
t8 <- length(mesh$PATID)
d8 <- t7 - t8
# EHR data 2010-2020
mesh <- mesh[!is.na(mesh$DATETIMESURGERY) & mesh$DATETIMESURGERY >= as.Date('2010-01-01'),] 
t9 <- length(mesh$PATID)
d9 <- t8 - t9
# Select first surgery per patient
mesh <- mesh[order(mesh$PATID, mesh$DATETIMESURGERY),]
mesh <- mesh %>%
          group_by(PATID) %>%
          slice_min(DATETIMESURGERY, n=1, with_ties=FALSE)
mesh <- data.frame(mesh)
t10 <- length(mesh$PATID)
d10 <- t9 - t10
# Exclude prior prolapse
mesh_no_prior_prolapse <- mesh[!is.na(mesh$PRIORPROLAPSE) & mesh$PRIORPROLAPSE == 0,] 
t11 <- length(mesh_no_prior_prolapse$PATID)

# Set random seed and shuffle rows in dataframe
## Mesh
set.seed(893)
rows <- sample(nrow(mesh))
mesh <- mesh[rows,]
## Mesh without prior prolapse
rows2 <- sample(nrow(mesh_no_prior_prolapse))
mesh_no_prior_prolapse <- mesh_no_prior_prolapse[rows2,]
# Add REDCAP_ID (unique to site) to enter in REDCap database for chart review
## Mesh
index <- seq.int(nrow(mesh))
add <- data.frame(index)
add$SITE_ID <- ifelse(site == "Lahey", "01123",
                     ifelse(site == "Yale", "02123",
                        ifelse(site == "Cornell", "03123",
                           ifelse(site == "Mayo", "04123",
                              ifelse(site == "VUMC", "05123", "99999")))))
add$REDCAP_ID <- paste(add$SITE_ID, add$index, sep="")
## Mesh without prior prolapse
index2 <- seq.int(nrow(mesh_no_prior_prolapse))
add2 <- data.frame(index2)
add2$SITE_ID <- ifelse(site == "Lahey", "01123",
                      ifelse(site == "Yale", "02123",
                             ifelse(site == "Cornell", "03123",
                                    ifelse(site == "Mayo", "04123",
                                           ifelse(site == "VUMC", "05123", "99999")))))
add2$REDCAP_ID <- paste(add2$SITE_ID, add2$index, sep="")
# Add indicator for deeper dive (all missing values)
## Mesh
add$DEEPER_DIVE_YN <- ""
add <- subset(add, select=c("REDCAP_ID", "DEEPER_DIVE_YN"))
mesh <- cbind(add, mesh)
write_xlsx(mesh, paste("NEST_SLING_Cohort_V", ver, ".xlsx", sep="")) 
## Mesh without prior prolapse
add2$DEEPER_DIVE_YN <- ""
add2 <- subset(add2, select=c("REDCAP_ID", "DEEPER_DIVE_YN"))
mesh_no_prior_prolapse <- cbind(add2, mesh_no_prior_prolapse)
write_xlsx(mesh_no_prior_prolapse, paste("NEST_SLING_Cohort_No_Prior_Prolapse_V", ver, ".xlsx", sep=""))

# Convert REDCAP_ID string to integer
mesh_no_prior_prolapse$REDCAP_ID <- as.integer(mesh_no_prior_prolapse$REDCAP_ID)

# Restrict to REGEX_Mesh_YN = "Yes"
## Mesh
mesh_rest <- mesh[!is.na(mesh$REGEX_Mesh_YN) & mesh$REGEX_Mesh_YN == "Yes",]
t12 <- length(mesh_rest$PATID)
d11 <- t10 - t12
d12 <- t12 - t11
## No prior prolapse
mesh_npp_rest <- mesh_no_prior_prolapse[!is.na(mesh_no_prior_prolapse$REGEX_Mesh_YN) & mesh_no_prior_prolapse$REGEX_Mesh_YN == "Yes",]
t13 <- length(mesh_npp_rest$PATID)
d13 <- t11 - t13
# Save flowchart: report n excluded for each criteria
d <- data.frame(c(d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13))
d$site <- site
colnames(d) <- c("n_dropped", "site")
row.names(d) <- c("Exclude males", "Exclude age <18", "Exclude not SUI", "Exclude no visit prior year",
                  "Exclude prior SUI", "Exclude non-sling", "Exclude prior divericulum", "Exclude surgeries before 1-1-2010",
                  "Exclude multiple/subsequent surgeries", "Exclude NLP mesh No or Indeterminate from any prolapse",
                  "Exclude prior prolapse", "Exclude NLP mesh No or Indeterminate from no prior prolapse")
# Censor values [1-10]
d$n_dropped[d$n_dropped > 0 & d$n_dropped < 11] <- "[1-10]"
write.csv(d, paste("./", site, "_Flowchart.csv", sep="", collapse=NULL), row.names=TRUE)

# Subgroup by Approach
as_rest <- mesh_rest[mesh_rest$REGEX_ADJ_SLING == 1,]
as_npp_rest <- mesh_npp_rest[mesh_npp_rest$REGEX_ADJ_SLING == 1,]
ret_rest <- mesh_rest[mesh_rest$REGEX_RETROPUBIC == 1,]
ret_npp_rest <- mesh_npp_rest[mesh_npp_rest$REGEX_RETROPUBIC == 1,]
si_rest <- mesh_rest[mesh_rest$REGEX_SNGL_INC == 1,]
si_npp_rest <- mesh_npp_rest[mesh_npp_rest$REGEX_SNGL_INC == 1,]
tra_rest <- mesh_rest[mesh_rest$REGEX_TRANSOB == 1,]
tra_npp_rest <- mesh_npp_rest[mesh_npp_rest$REGEX_TRANSOB == 1,]
un_rest <- mesh_rest[mesh_rest$REGEX_UNKNOWN == 1,]
un_npp_rest <- mesh_npp_rest[mesh_npp_rest$REGEX_UNKNOWN == 1,]

### Chart Review Comparison ###
chart <- read.csv(file="./chart_abstract.csv", na.strings=c("NA", "<NA>", "", " ", "NULL"))
if(site == "VUMC"){
  #Merge REDCAP_IDs generated for original cohort
  mesh_merge <- data.frame(read_excel("./NEST_SLING_Cohort_No_Prior_Prolapse_V1.7_20210323.xlsx"))
  mesh_merge <- mesh_merge[,c(1,3)]
  mesh_merge$REDCAP_ID <- as.integer(mesh_merge$REDCAP_ID)
  mesh_merge$PATID <- as.integer(mesh_merge$PATID)
  # Note: used 'NEST_SLING_Cohort_No_Prior_Prolapse.xlsx' = mesh_no_prior_prolapse dataframe to generate chart review dataset
  mesh_no_prior_prolapse <- dplyr::left_join(subset(mesh_no_prior_prolapse, select=-c(REDCAP_ID)), mesh_merge, all.x=TRUE, by="PATID")
}
p <- as.integer(mesh_no_prior_prolapse$REDCAP_ID) #List of REDCAP_ID's in final structured data
## Only use records from specified site
chart$site <- ifelse(site == "Cornell", 1,
                     ifelse(site == "Lahey", 2,
                            ifelse(site == "Mayo", 3,
                                   ifelse(site == "VUMC", 4, 
                                          ifelse(site == "Yale", 5, NA)))))
chart <- chart[chart$please_select_your_site == chart$site,]
# If anything missing in newest record, carry forward from original
chart <- chart[order(chart$participant_id_de_identifi, chart$participant_id),]
chart <- chart %>%
  group_by(participant_id_de_identifi) %>%
  fill(names(chart)) %>%
  fill(names(chart), .direction='up') 
## Remove duplicate IDs from chart review by keeping most recent
chart <- chart %>%
  group_by(participant_id_de_identifi) %>%
  slice_max(participant_id, n=1, with_ties=FALSE)
chart <- data.frame(chart)
## Drop patients included in chart review but not final structured data
chart <- chart[chart$participant_id_de_identifi %in% p,]
## Rename fields at other sites
names(chart)[names(chart)=="interventions_implants_1"] <- "interventions_implants___1"
names(chart)[names(chart)=="interventions_implants_2"] <- "interventions_implants___2"
names(chart)[names(chart)=="interventions_implants_3"] <- "interventions_implants___3"
names(chart)[names(chart)=="interventions_implants_4"] <- "interventions_implants___4"
names(chart)[names(chart)=="interventions_implants_5"] <- "interventions_implants___5"
## Recode fields
chart$REDCAP_ID <- as.integer(chart$participant_id_de_identifi)
chart$FULL_CHART <- ifelse(!is.na(chart$menopausal_status), 1, 0)
chart$HISTORYMENOPAUSE_CHART <- ifelse(!is.na(chart$menopausal_status) & chart$menopausal_status == 4, 0,
                                       ifelse(!is.na(chart$menopausal_status) & chart$menopausal_status == 5, 1, NA))
chart$HISTORYSMOKING_CHART <- ifelse(!is.na(chart$smoking_status) & chart$smoking_status == 9, 0,
                                     ifelse(!is.na(chart$smoking_status) & (chart$smoking_status == 7 |
                                                                              chart$smoking_status == 8), 1, NA))
chart$PREHISTORYCHRONICPAIN_CHART <- ifelse((!is.na(chart$dyspareunia) & chart$dyspareunia == 1), 1,
                                            ifelse((!is.na(chart$dyspareunia) & chart$dyspareunia == 2), 0, NA))
chart$BMI_CHART <- chart$bmi
chart$PRIORPROLAPSE_CHART <- ifelse(!is.na(chart$prior_prolapse) & chart$prior_prolapse == 2, 0,
                                    ifelse(!is.na(chart$prior_prolapse) & chart$prior_prolapse == 1, 1, NA))
chart$PRIORSUI_CHART <- ifelse(!is.na(chart$prior_sui) & chart$prior_sui == 2, 0,
                               ifelse(!is.na(chart$prior_sui) & chart$prior_sui == 1, 1, NA))
chart$PREABSURG_CHART <- ifelse((!is.na(chart$prior_hysterectomy) & chart$prior_hysterectomy == 1) |
                                  (!is.na(chart$prior_oophorectomy) & chart$prior_oophorectomy == 1) |
                                  (!is.na(chart$hx_of_bariatric_surgery) & chart$hx_of_bariatric_surgery == 1) |
                                  (!is.na(chart$prior_prolapse) & chart$prior_prolapse == 1) |
                                  (!is.na(chart$prior_sui) & chart$prior_sui == 1), 1, 
                                ifelse((!is.na(chart$prior_hysterectomy) & chart$prior_hysterectomy == 2) &
                                         (!is.na(chart$prior_oophorectomy) & chart$prior_oophorectomy == 2) &
                                         (!is.na(chart$hx_of_bariatric_surgery) & chart$hx_of_bariatric_surgery == 2) &
                                         (!is.na(chart$prior_prolapse) & chart$prior_prolapse == 2) &
                                         (!is.na(chart$prior_sui) & chart$prior_sui == 2), 0, NA))
chart$PREVOIDING_CHART <- ifelse((!is.na(chart$retention) & chart$retention == 1) | (!is.na(chart$urge) & chart$urge == 1) | 
                                   (!is.na(chart$stress) & chart$stress == 1) | (!is.na(chart$mixed) & chart$mixed == 1) | 
                                   (!is.na(chart$dribble) & chart$dribble == 1) | (!is.na(chart$severe) & chart$severe == 1) | 
                                   (!is.na(chart$cystocele) & chart$cystocele == 1) | (!is.na(chart$urethrocele) & chart$urethrocele == 1) | 
                                   (!is.na(chart$uterine_prolapse) & chart$uterine_prolapse == 1) | 
                                   (!is.na(chart$uterovaginal) & chart$uterovaginal == 1) | 
                                   (!is.na(chart$hysterectomy) & chart$hysterectomy == 1) | 
                                   (!is.na(chart$enterocele) & chart$enterocele == 1) | 
                                   (!is.na(chart$vault_prolapse_enterocele) & chart$vault_prolapse_enterocele == 1) | 
                                   (!is.na(chart$rectocele) & chart$rectocele == 1) | (!is.na(chart$pelvic) & chart$pelvic == 1), 1,
                                 ifelse((!is.na(chart$retention) & chart$retention == 2) & (!is.na(chart$urge) & chart$urge == 2) & 
                                          (!is.na(chart$stress) & chart$stress == 2) & (!is.na(chart$mixed) & chart$mixed == 2) & 
                                          (!is.na(chart$dribble) & chart$dribble == 2) & (!is.na(chart$severe) & chart$severe == 2) & 
                                          (!is.na(chart$cystocele) & chart$cystocele == 2) & (!is.na(chart$urethrocele) & chart$urethrocele == 2) & 
                                          (!is.na(chart$uterine_prolapse) & chart$uterine_prolapse == 2) & 
                                          (!is.na(chart$uterovaginal) & chart$uterovaginal == 2) & 
                                          (!is.na(chart$hysterectomy) & chart$hysterectomy == 2) & 
                                          (!is.na(chart$enterocele) & chart$enterocele == 2) & 
                                          (!is.na(chart$vault_prolapse_enterocele) & chart$vault_prolapse_enterocele == 2) & 
                                          (!is.na(chart$rectocele) & chart$rectocele == 2) & (!is.na(chart$pelvic) & chart$pelvic == 2), 0, NA))
chart$SUI_IND_CHART <- ifelse((!is.na(chart$stress) & chart$stress == 1) | (!is.na(chart$urge) & chart$urge == 1) | 
                                (!is.na(chart$mixed) & chart$mixed == 1) | (!is.na(chart$occult) & chart$occult == 1) |
                                (!is.na(chart$severe) & chart$severe == 1) | (!is.na(chart$urgency) & chart$urgency == 1) |
                                (!is.na(chart$retention) & chart$retention == 1) | (!is.na(chart$obstruction) & chart$obstruction == 1) |
                                (!is.na(chart$dribble) & chart$dribble == 1) | (!is.na(chart$dyspareunia) & chart$dyspareunia == 1), 1,
                              ifelse((!is.na(chart$stress) & chart$stress == 2) & (!is.na(chart$urge) & chart$urge == 2) & 
                                       (!is.na(chart$mixed) & chart$mixed == 2) & (!is.na(chart$occult) & chart$occult == 2) &
                                       (!is.na(chart$severe) & chart$severe == 2) & (!is.na(chart$urgency) & chart$urgency == 2) &
                                       (!is.na(chart$retention) & chart$retention == 2) & (!is.na(chart$obstruction) & chart$obstruction == 2) &
                                       (!is.na(chart$dribble) & chart$dribble == 2) & (!is.na(chart$dyspareunia) & chart$dyspareunia == 2), 0, NA))
chart$URODYNAMICTESTING_CHART <- ifelse(!is.na(chart$cough_stress_test) & (chart$cough_stress_test == 1 | chart$cough_stress_test == 2), 1,
                                        ifelse(!is.na(chart$cough_stress_test) & chart$cough_stress_test == 3, 0, NA))
# Keyword search "concomitant" surgery
chart$CONCOMITANTSURG_CHART <- ifelse(grepl("Concomitant", chart$notes_or_questions), 1,
                                      ifelse(grepl("concomitant", chart$notes_or_questions), 1, 0))
# Outcomes
chart$DEATH_CHART <- ifelse(!is.na(chart$deceased) & chart$deceased == 1, 1, 0)
chart$DAYS_SURGERY_DEATH_CHART <- chart$if_yes_date_and_time_of_de
chart$FISTULA_CHART <- ifelse((!is.na(chart$fistula) & chart$fistula == 1) |
                                (!is.na(chart$urethral_fistula) & chart$urethral_fistula == 1), 1, 
                              ifelse((!is.na(chart$fistula) & chart$fistula == 2) &
                                       (!is.na(chart$urethral_fistula) & chart$urethral_fistula == 2), 0, NA))
chart$REOPERATION_CHART <- ifelse((!is.na(chart$synthetic_mesh_removal) & chart$synthetic_mesh_removal == 1) | 
                                    (!is.na(chart$fascia_removal) & chart$fascia_removal == 1) |
                                    (!is.na(chart$loosening_of_sling) & chart$loosening_of_sling == 1) |
                                    (!is.na(chart$removal_of_2cm_includes_cu) & chart$removal_of_2cm_includes_cu == 1) |
                                    (!is.na(chart$complete_removal_of_sling) & chart$complete_removal_of_sling == 1) |
                                    (!is.na(chart$hemorrhage_or_bleeding_fro) & chart$hemorrhage_or_bleeding_fro == 1) |
                                    (!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 1) |
                                    (!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 1) |
                                    (!is.na(chart$groin_pain) & chart$groin_pain == 1) |
                                    (!is.na(chart$dyspareunia_discharge_or_b) & chart$dyspareunia_discharge_or_b == 1) |
                                    (!is.na(chart$partner_dyspareunia) & chart$partner_dyspareunia == 1) |
                                    (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 1) |
                                    (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 1) |
                                    (!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 1) |
                                    (!is.na(chart$bowel_injury) & chart$bowel_injury == 1) |
                                    (!is.na(chart$bladder_urethral_injury) & chart$bladder_urethral_injury == 1) |
                                    (!is.na(chart$urethral_injury) & chart$urethral_injury == 1) |
                                    (!is.na(chart$organ_perforation_from_mes) & chart$organ_perforation_from_mes == 1) |
                                    (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 1) |
                                    (!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 1) |
                                    (!is.na(chart$retropubic_hematoma) & chart$retropubic_hematoma == 1) |
                                    (!is.na(chart$autologous_tissue_sling) & chart$autologous_tissue_sling == 1) |
                                    (!is.na(chart$cadaveric_fascial_sling) & chart$cadaveric_fascial_sling == 1) |
                                    (!is.na(chart$burch_colposuspension_tran) & chart$burch_colposuspension_tran == 1) |
                                    (!is.na(chart$bulking_agents) & chart$bulking_agents == 1) |
                                    (!is.na(chart$collagen_implant_into_the) & chart$collagen_implant_into_the == 1) |
                                    (!is.na(chart$urethral_suspension) & chart$urethral_suspension == 1) |
                                    (!is.na(chart$anterior_vesicourethropexy) & chart$anterior_vesicourethropexy == 1) |
                                    (!is.na(chart$vaginal_prolapse_repair) & chart$vaginal_prolapse_repair == 1) |
                                    (!is.na(chart$sling_combined_with_prolap) & chart$sling_combined_with_prolap == 1) |
                                    (!is.na(chart$abdominal_prolapse_repair) & chart$abdominal_prolapse_repair == 1) |
                                    (!is.na(chart$robotic_prolapse_repair) & chart$robotic_prolapse_repair == 1) |
                                    (!is.na(chart$salcrocolpopexy) & chart$salcrocolpopexy == 1) |
                                    (!is.na(chart$enterocele_vault_repair) & chart$enterocele_vault_repair == 1) |
                                    (!is.na(chart$sacrospinous_ligament_fixa) & chart$sacrospinous_ligament_fixa == 1) |
                                    (!is.na(chart$urethropexy_marshall_march) & chart$urethropexy_marshall_march == 1) |
                                    (!is.na(chart$kelly_plication_of_urethro) & chart$kelly_plication_of_urethro == 1) |
                                    (!is.na(chart$cystocele_rectocele_repair) & chart$cystocele_rectocele_repair == 1) |
                                    (!is.na(chart$anterior_colporrhaphy_repa) & chart$anterior_colporrhaphy_repa == 1) |
                                    (!is.na(chart$paravaginal_defect_repair) & chart$paravaginal_defect_repair == 1) |
                                    (!is.na(chart$bladder_neck_suspension_gi) & chart$bladder_neck_suspension_gi == 1) |
                                    (!is.na(chart$trans_vaginal_retro_pubic) & chart$trans_vaginal_retro_pubic == 1) |
                                    (!is.na(chart$trans_vaginal_trans_obtura) & chart$trans_vaginal_trans_obtura == 1) |
                                    (!is.na(chart$trans_vaginal_single_incis) & chart$trans_vaginal_single_incis == 1) |
                                    (!is.na(chart$trans_vaginal_adjustable_s) & chart$trans_vaginal_adjustable_s == 1) |
                                    (!is.na(chart$laparoscopic) & chart$laparoscopic == 1) |
                                    (!is.na(chart$open) & chart$open == 1), 1,
                                  ifelse((!is.na(chart$synthetic_mesh_removal) & chart$synthetic_mesh_removal == 2) & 
                                           (!is.na(chart$fascia_removal) & chart$fascia_removal == 2) &
                                           (!is.na(chart$loosening_of_sling) & chart$loosening_of_sling == 2) &
                                           (!is.na(chart$removal_of_2cm_includes_cu) & chart$removal_of_2cm_includes_cu == 2) &
                                           (!is.na(chart$complete_removal_of_sling) & chart$complete_removal_of_sling == 2) &
                                           (!is.na(chart$hemorrhage_or_bleeding_fro) & chart$hemorrhage_or_bleeding_fro == 2) &
                                           (!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 2) &
                                           (!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 2) &
                                           (!is.na(chart$groin_pain) & chart$groin_pain == 2) &
                                           (!is.na(chart$dyspareunia_discharge_or_b) & chart$dyspareunia_discharge_or_b == 2) &
                                           (!is.na(chart$partner_dyspareunia) & chart$partner_dyspareunia == 2) &
                                           (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 2) &
                                           (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 2) &
                                           (!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 2) &
                                           (!is.na(chart$bowel_injury) & chart$bowel_injury == 2) &
                                           (!is.na(chart$bladder_urethral_injury) & chart$bladder_urethral_injury == 2) &
                                           (!is.na(chart$urethral_injury) & chart$urethral_injury == 2) &
                                           (!is.na(chart$organ_perforation_from_mes) & chart$organ_perforation_from_mes == 2) &
                                           (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 2) &
                                           (!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 2) &
                                           (!is.na(chart$retropubic_hematoma) & chart$retropubic_hematoma == 2) &
                                           (!is.na(chart$autologous_tissue_sling) & chart$autologous_tissue_sling == 2) &
                                           (!is.na(chart$cadaveric_fascial_sling) & chart$cadaveric_fascial_sling == 2) &
                                           (!is.na(chart$burch_colposuspension_tran) & chart$burch_colposuspension_tran == 2) &
                                           (!is.na(chart$bulking_agents) & chart$bulking_agents == 2) &
                                           (!is.na(chart$collagen_implant_into_the) & chart$collagen_implant_into_the == 2) &
                                           (!is.na(chart$urethral_suspension) & chart$urethral_suspension == 2) &
                                           (!is.na(chart$anterior_vesicourethropexy) & chart$anterior_vesicourethropexy == 2) &
                                           (!is.na(chart$vaginal_prolapse_repair) & chart$vaginal_prolapse_repair == 2) &
                                           (!is.na(chart$sling_combined_with_prolap) & chart$sling_combined_with_prolap == 2) &
                                           (!is.na(chart$abdominal_prolapse_repair) & chart$abdominal_prolapse_repair == 2) &
                                           (!is.na(chart$robotic_prolapse_repair) & chart$robotic_prolapse_repair == 2) &
                                           (!is.na(chart$salcrocolpopexy) & chart$salcrocolpopexy == 2) &
                                           (!is.na(chart$enterocele_vault_repair) & chart$enterocele_vault_repair == 2) &
                                           (!is.na(chart$sacrospinous_ligament_fixa) & chart$sacrospinous_ligament_fixa == 2) &
                                           (!is.na(chart$urethropexy_marshall_march) & chart$urethropexy_marshall_march == 2) &
                                           (!is.na(chart$kelly_plication_of_urethro) & chart$kelly_plication_of_urethro == 2) &
                                           (!is.na(chart$cystocele_rectocele_repair) & chart$cystocele_rectocele_repair == 2) &
                                           (!is.na(chart$anterior_colporrhaphy_repa) & chart$anterior_colporrhaphy_repa == 2) &
                                           (!is.na(chart$paravaginal_defect_repair) & chart$paravaginal_defect_repair == 2) &
                                           (!is.na(chart$bladder_neck_suspension_gi) & chart$bladder_neck_suspension_gi == 2) &
                                           (!is.na(chart$trans_vaginal_retro_pubic) & chart$trans_vaginal_retro_pubic == 2) &
                                           (!is.na(chart$trans_vaginal_trans_obtura) & chart$trans_vaginal_trans_obtura == 2) &
                                           (!is.na(chart$trans_vaginal_single_incis) & chart$trans_vaginal_single_incis == 2) &
                                           (!is.na(chart$trans_vaginal_adjustable_s) & chart$trans_vaginal_adjustable_s == 2) &
                                           (!is.na(chart$laparoscopic) & chart$laparoscopic == 2) &
                                           (!is.na(chart$open) & chart$open == 2), 0, NA))
chart$REMOVAL_CHART <- ifelse((!is.na(chart$synthetic_mesh_removal) & chart$synthetic_mesh_removal == 1) | 
                                (!is.na(chart$fascia_removal) & chart$fascia_removal == 1) | 
                                (!is.na(chart$loosening_of_sling) & chart$loosening_of_sling == 1) | 
                                (!is.na(chart$removal_of_2cm_includes_cu) & chart$removal_of_2cm_includes_cu == 1) | 
                                (!is.na(chart$complete_removal_of_sling) & chart$complete_removal_of_sling == 1), 1, 
                              ifelse((!is.na(chart$synthetic_mesh_removal) & chart$synthetic_mesh_removal == 2) & 
                                       (!is.na(chart$fascia_removal) & chart$fascia_removal == 2) & 
                                       (!is.na(chart$loosening_of_sling) & chart$loosening_of_sling == 2) & 
                                       (!is.na(chart$removal_of_2cm_includes_cu) & chart$removal_of_2cm_includes_cu == 2) & 
                                       (!is.na(chart$complete_removal_of_sling) & chart$complete_removal_of_sling == 2), 0, NA))
chart$PAIN_CHART <- ifelse((!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 1) |
                             (!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 1) |
                             (!is.na(chart$groin_pain) & chart$groin_pain == 1) |
                             (!is.na(chart$dyspareunia_discharge_or_b) & chart$dyspareunia_discharge_or_b == 1), 1, 
                           ifelse((!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 2) &
                                    (!is.na(chart$groin_pain) & chart$groin_pain == 2) &
                                    (!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 2) &
                                    (!is.na(chart$dyspareunia_discharge_or_b) & chart$dyspareunia_discharge_or_b == 2), 0, NA))
chart$POSTVOIDING_CHART <- ifelse((!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 1) |
                                    (!is.na(chart$irritative_bladder_symptom) & chart$irritative_bladder_symptom == 1), 1,
                                  ifelse((!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 2) &
                                           (!is.na(chart$irritative_bladder_symptom) & chart$irritative_bladder_symptom == 2), 0, NA))
chart$INFECTION_CHART <- ifelse((!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 1) |
                                  (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 1) |
                                  (!is.na(chart$irritative_bladder_symptom) & chart$irritative_bladder_symptom == 1), 1,
                                ifelse((!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 2) &
                                         (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 2) &
                                         (!is.na(chart$irritative_bladder_symptom) & chart$irritative_bladder_symptom == 2), 0, NA))
chart$PERFORATION_CHART <- ifelse((!is.na(chart$mesh_erosion_exposure) & chart$mesh_erosion_exposure == 1) |
                                    (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 1) |
                                    (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 1) |
                                    (!is.na(chart$mesh_exposure_without_surg) & chart$mesh_exposure_without_surg == 1), 1, 
                                  ifelse((!is.na(chart$mesh_erosion_exposure) & chart$mesh_erosion_exposure == 2) &
                                           (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 2) &
                                           (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 2) &
                                           (!is.na(chart$mesh_exposure_without_surg) & chart$mesh_exposure_without_surg == 2), 0, NA))
chart$EROSION_CHART <- ifelse((!is.na(chart$mesh_erosion_exposure) & chart$mesh_erosion_exposure == 1) |
                                (!is.na(chart$mesh_erosion_without_re_op) & chart$mesh_erosion_without_re_op == 1) |
                                (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 1) |
                                (!is.na(chart$hemorrhage_or_bleeding_fro) & chart$hemorrhage_or_bleeding_fro == 1) |
                                (!is.na(chart$need_for_blood_transfusion) & chart$need_for_blood_transfusion == 1) |
                                (!is.na(chart$organ_perforation_from_mes) & chart$organ_perforation_from_mes == 1) |
                                (!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 1) |
                                (!is.na(chart$bowel_injury) & chart$bowel_injury == 1) |
                                (!is.na(chart$bladder_urethral_injury) & chart$bladder_urethral_injury == 1) |
                                (!is.na(chart$urethral_fistula) & chart$urethral_fistula == 1) |
                                (!is.na(chart$retropubic_hematoma) & chart$retropubic_hematoma == 1) |
                                (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 1) |
                                (!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 1) |
                                (!is.na(chart$urethral_injury) & chart$urethral_injury == 1) |
                                (!is.na(chart$vascular_injury) & chart$vascular_injury == 1) |
                                (!is.na(chart$mesh_exposure_without_surg) & chart$mesh_exposure_without_surg == 1) |
                                (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 1) |
                                (!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 1), 1, 
                              ifelse((!is.na(chart$mesh_erosion_exposure) & chart$mesh_erosion_exposure == 2) &
                                       (!is.na(chart$mesh_erosion_without_re_op) & chart$mesh_erosion_without_re_op == 3) &
                                       (!is.na(chart$mesh_exposure) & chart$mesh_exposure == 2) &
                                       (!is.na(chart$hemorrhage_or_bleeding_fro) & chart$hemorrhage_or_bleeding_fro == 2) &
                                       (!is.na(chart$need_for_blood_transfusion) & chart$need_for_blood_transfusion == 2) &
                                       (!is.na(chart$organ_perforation_from_mes) & chart$organ_perforation_from_mes == 2) &
                                       (!is.na(chart$pain_or_nerve_injury_after) & chart$pain_or_nerve_injury_after == 2) &
                                       (!is.na(chart$bowel_injury) & chart$bowel_injury == 2) &
                                       (!is.na(chart$bladder_urethral_injury) & chart$bladder_urethral_injury == 2) &
                                       (!is.na(chart$urethral_fistula) & chart$urethral_fistula == 2) &
                                       (!is.na(chart$retropubic_hematoma) & chart$retropubic_hematoma == 2) &
                                       (!is.na(chart$prior_surgical_site_infect) & chart$prior_surgical_site_infect == 2) &
                                       (!is.na(chart$surgical_site_infection) & chart$surgical_site_infection == 2) &
                                       (!is.na(chart$urethral_injury) & chart$urethral_injury == 2) &
                                       (!is.na(chart$vascular_injury) & chart$vascular_injury == 2) &
                                       (!is.na(chart$mesh_exposure_without_surg) & chart$mesh_exposure_without_surg == 2) &
                                       (!is.na(chart$mesh_erosion_to_bladder_or) & chart$mesh_erosion_to_bladder_or == 2) &
                                       (!is.na(chart$incomplete_bladder_emptyin) & chart$incomplete_bladder_emptyin == 2), 0, NA))
chart$POSTHISTORYCHRONICPAIN_CHART <- ifelse((!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 1) | 
                                               (!is.na(chart$partner_dyspareunia) & chart$partner_dyspareunia == 1), 1,
                                             ifelse((!is.na(chart$chronic_pelvic_or_groin_pa) & chart$chronic_pelvic_or_groin_pa == 2) &
                                                      (!is.na(chart$partner_dyspareunia) & chart$partner_dyspareunia == 2), 0, NA))                                         

# Create dummy variables
chart$CHART_RETROPUBIC <- ifelse(!is.na(chart$primary_op_note) & chart$primary_op_note == 1, 1, 0)
chart$CHART_TRANSOB <- ifelse(!is.na(chart$primary_op_note) & (chart$primary_op_note == 2 |
                              chart$primary_op_note == 9 | chart$primary_op_note == 10), 1, 0)
chart$CHART_ADJ_SNGL_INC <- ifelse(!is.na(chart$primary_op_note) & chart$primary_op_note == 3, 1, 0)
chart$CHART_APP_OTHER <- ifelse(!is.na(chart$primary_op_note) & chart$primary_op_note == 5, 1, 0)
chart$CHART_MESH <- ifelse(!is.na(chart$synthetic_mesh_implantatio) & chart$synthetic_mesh_implantatio == 1, 1, 0)
chart$CHART_NO_MESH <- ifelse(!is.na(chart$synthetic_mesh_implantatio) & chart$synthetic_mesh_implantatio == 2, 1, 0)
chart$CHART_INDETERMINATE_MESH <- ifelse(!is.na(chart$synthetic_mesh_implantatio) & chart$synthetic_mesh_implantatio == 3, 1, 0)
chart$INT_IMPLANT_BULKING_AGENTS <- ifelse(!is.na(chart$interventions_implants___1) & chart$interventions_implants___1 == 1, 1, 0)
chart$INT_IMPLANT_PUBO_VAGINAL_AUTO <- ifelse(!is.na(chart$interventions_implants___2) & chart$interventions_implants___2 == 1, 1, 0)
chart$INT_IMPLANT_CAD_ALLOGRAFT <- ifelse(!is.na(chart$interventions_implants___3) & chart$interventions_implants___3 == 1, 1, 0)
chart$INT_IMPLANT_PORCINE <- ifelse(!is.na(chart$interventions_implants___4) & chart$interventions_implants___4 == 1, 1, 0)
chart$INT_IMPLANT_BURCH <- ifelse(!is.na(chart$interventions_implants___5) & chart$interventions_implants___5 == 1, 1, 0)
chart$HISTORYMENOPAUSE_PRE <- ifelse(!is.na(chart$menopausal_status) & chart$menopausal_status == 4, 1, 0)
chart$HISTORYMENOPAUSE_POST <- ifelse(!is.na(chart$menopausal_status) & chart$menopausal_status == 5, 1, 0)
chart$HISTORYMENOPAUSE_UNKNOWN <- ifelse(!is.na(chart$menopausal_status) & chart$menopausal_status == 6, 1, 0)
chart$SMOKING_STATUS_CURRENT <-ifelse(!is.na(chart$smoking_status) & chart$smoking_status == 7, 1, 0)
chart$SMOKING_STATUS_FORMER <-ifelse(!is.na(chart$smoking_status) & chart$smoking_status == 8, 1, 0)
chart$SMOKING_STATUS_NEVER <-ifelse(!is.na(chart$smoking_status) & chart$smoking_status == 9, 1, 0)
chart$COUGH_STRESS_POSITIVE <- ifelse(!is.na(chart$cough_stress_test) & chart$cough_stress_test == 1, 1, 0)
chart$COUGH_STRESS_NEGATIVE <- ifelse(!is.na(chart$cough_stress_test) & chart$cough_stress_test == 2, 1, 0)
chart$COUGH_STRESS_NOT_DONE <- ifelse(!is.na(chart$cough_stress_test) & chart$cough_stress_test == 3, 1, 0)

# Rename fields for days/years from surgery
chart$years_prior_hysterectomy <- chart$number_of_years_ago_if_kno
chart$years_prior_oophorectomy <- chart$number_of_years_ago_if_kno_2
chart$years_prior_prolapse <- chart$number_of_years_ago_if_kno_3
chart$years_prior_sui <- chart$number_of_years_ago_if_kno_4
chart$days_synthetic_mesh_removal <- chart$if_yes_what_date_and_time_2
chart$days_fascia_removal <- chart$if_yes_what_date_and_time_3
chart$days_autologous_tissue_sling <- chart$if_yes_what_date_and_time_4
chart$days_cadaveric_fascial_sling <- chart$if_yes_what_date_and_time_5
chart$days_burch_colposuspension_tran <- chart$if_yes_what_date_and_time_6
chart$days_bulking_agents <- chart$if_yes_what_date_and_time_7
chart$days_collagen_implant <- chart$if_yes_what_date_and_time_8
chart$days_urethral_suspension <- chart$if_yes_what_date_and_time_9
chart$days_anterior_vesicourethropexy <- chart$if_yes_what_date_and_time_10
chart$days_vaginal_prolapse_repair <- chart$if_yes_what_date_and_time_12
chart$days_sling_combined_prolapse_repair <- chart$if_yes_how_many_days_from
chart$days_abdominal_prolapse_repair <- chart$if_yes_how_many_days_from2
chart$days_robotic_prolapse_repair <- chart$if_yes_how_many_days_from3
chart$days_urethropexy <- chart$if_yes_what_date_and_time_11
chart$days_kelly_plication <- chart$if_yes_what_date_and_time_13
chart$days_cystocele_rectocele_repair <- chart$if_yes_what_date_and_time_14
chart$days_anterior_colporrhaphy <- chart$if_yes_what_date_and_time_15
chart$days_paravaginal_defect_repair <- chart$if_yes_what_date_and_time_16
chart$days_bladder_neck_suspension <- chart$if_yes_what_date_and_time_17
chart$days_mesh_erosion_without_reop <- chart$if_yes_date_and_time_3
chart$days_urinary_incontinence_without_reop <- chart$if_yes_date_and_time_4

# Lists of variables - full chart review
chart.num.dd <- c("bmi", "years_prior_hysterectomy", "years_prior_oophorectomy", "years_prior_prolapse",
                  "years_prior_sui", "days_synthetic_mesh_removal", "days_fascia_removal", 
                  "days_autologous_tissue_sling", "days_cadaveric_fascial_sling", "days_burch_colposuspension_tran",
                  "days_bulking_agents", "days_collagen_implant", "days_urethral_suspension", 
                  "days_anterior_vesicourethropexy", "days_vaginal_prolapse_repair", 
                  "days_sling_combined_prolapse_repair", "days_abdominal_prolapse_repair", "days_robotic_prolapse_repair",
                  "days_urethropexy", "days_kelly_plication", "days_cystocele_rectocele_repair", 
                  "days_anterior_colporrhaphy", "days_paravaginal_defect_repair", "days_bladder_neck_suspension",
                  "days_mesh_erosion_without_reop", "days_urinary_incontinence_without_reop", 
                  "DAYS_SURGERY_DEATH_CHART")
chart.factor.all <- c("CHART_RETROPUBIC", "CHART_TRANSOB", "CHART_ADJ_SNGL_INC",
                      "CHART_APP_OTHER", "CHART_MESH", "CHART_NO_MESH", "CHART_INDETERMINATE_MESH",
                      "INT_IMPLANT_BULKING_AGENTS", "INT_IMPLANT_PUBO_VAGINAL_AUTO", "INT_IMPLANT_CAD_ALLOGRAFT",
                      "INT_IMPLANT_PORCINE", "INT_IMPLANT_BURCH")
chart.factor <- c("HISTORYMENOPAUSE_PRE", "HISTORYMENOPAUSE_POST", "HISTORYMENOPAUSE_UNKNOWN", 
                  "SMOKING_STATUS_CURRENT", "SMOKING_STATUS_FORMER", "SMOKING_STATUS_NEVER",
                  "hx_of_bariatric_surgery", "prior_hysterectomy", "prior_oophorectomy", "prior_prolapse",
                  "prior_sui", "stress", "urge", "mixed", "occult", "severe", "urgency", "retention",
                  "obstruction", "dribble", "dyspareunia", "pelvic", "enterocele", "hysterectomy",
                  "uterovaginal", "cystocele", "rectocele", "urethrocele", "uterine_prolapse", 
                  "vault_prolapse_enterocele", "COUGH_STRESS_POSITIVE", "COUGH_STRESS_NEGATIVE", 
                  "COUGH_STRESS_NOT_DONE", "hemorrhage_or_bleeding_fro", "need_for_blood_transfusion",
                  "mesh_erosion_exposure", "organ_perforation_from_mes", "pain_or_nerve_injury_after",
                  "bowel_injury", "bladder_urethral_injury", "urethral_fistula", "retropubic_hematoma", 
                  "prior_surgical_site_infect", "surgical_site_infection", "urethral_injury",
                  "vascular_injury", "synthetic_mesh_removal", "fascia_removal", 
                  "autologous_tissue_sling", "cadaveric_fascial_sling", "burch_colposuspension_tran",
                  "bulking_agents", "collagen_implant_into_the", "urethral_suspension", 
                  "anterior_vesicourethropexy", "vaginal_prolapse_repair", "sling_combined_with_prolap",
                  "abdominal_prolapse_repair", "robotic_prolapse_repair", "salcrocolpopexy", 
                  "enterocele_vault_repair", "sacrospinous_ligament_fixa", "urethropexy_marshall_march",
                  "kelly_plication_of_urethro", "cystocele_rectocele_repair", "anterior_colporrhaphy_repa",
                  "paravaginal_defect_repair", "bladder_neck_suspension_gi", "trans_vaginal_retro_pubic",
                  "trans_vaginal_trans_obtura", "trans_vaginal_single_incis", "trans_vaginal_adjustable_s",
                  "laparoscopic", "open", "mesh_erosion_without_re_op", "urinary_incontinence_witho", 
                  "deceased", "irritative_bladder_symptom", "dyspareunia_discharge_or_b", 
                  "chronic_pelvic_or_groin_pa", "misplaced_or_migrated_bulk", "mesh_exposure", 
                  "mesh_erosion_to_bladder_or", "groin_pain", "partner_dyspareunia", "fistula",
                  "incomplete_bladder_emptyin", "vaginal_band", "mesh_exposure_without_surg", 
                  "urinary_incontinence_wo", "loosening_of_sling", "removal_of_2cm_includes_cu",
                  "complete_removal_of_sling", "CONCOMITANTSURG_CHART")
chart.factor.dd <- c(chart.factor.all, chart.factor)

# Additional Chart Review Datasets
short_struct <- merge(chart, mesh_no_prior_prolapse, all.x=TRUE, by="REDCAP_ID")
# Compare Structured vs chart review (Gold Standard)
short_struct$MESH_DISCORDANT_SCR <- calcDiscord(short_struct$SYNTHETIC_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_DISCORDANT_SCR <- calcDiscord(short_struct$NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_DISCORDANT_SCR <- calcDiscord(short_struct$INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
short_struct$MESH_TN_SCR <- calcTN(short_struct$SYNTHETIC_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_TN_SCR <- calcTN(short_struct$NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_TN_SCR <- calcTN(short_struct$INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
short_struct$MESH_CAT4_SCR <- bin4cat(short_struct$SYNTHETIC_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_CAT4_SCR <- bin4cat(short_struct$NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_CAT4_SCR <- bin4cat(short_struct$INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
# Compare Regex vs chart review (Gold Standard)
short_struct$MESH_DISCORDANT_RCR <- calcDiscord(short_struct$REGEX_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_DISCORDANT_RCR <- calcDiscord(short_struct$REGEX_NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_DISCORDANT_RCR <- calcDiscord(short_struct$REGEX_INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
short_struct$ADJ_SNGL_INC_DISCORDANT <- calcDiscord(short_struct$REGEX_ADJ_SNGL_INC, short_struct$CHART_ADJ_SNGL_INC)
short_struct$RETROPUBIC_DISCORDANT <- calcDiscord(short_struct$REGEX_RETROPUBIC, short_struct$CHART_RETROPUBIC)
short_struct$TRANSOB_DISCORDANT <- calcDiscord(short_struct$REGEX_TRANSOB, short_struct$CHART_TRANSOB)
short_struct$APP_UNKNOWN_DISCORDANT <- calcDiscord(short_struct$REGEX_UNKNOWN, short_struct$CHART_APP_OTHER)
short_struct$MESH_TN_RCR <- calcTN(short_struct$REGEX_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_TN_RCR <- calcTN(short_struct$REGEX_NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_TN_RCR <- calcTN(short_struct$REGEX_INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
short_struct$ADJ_SNGL_INC_TN <- calcTN(short_struct$REGEX_ADJ_SNGL_INC, short_struct$CHART_ADJ_SNGL_INC)
short_struct$RETROPUBIC_TN <- calcTN(short_struct$REGEX_RETROPUBIC, short_struct$CHART_RETROPUBIC)
short_struct$TRANSOB_TN <- calcTN(short_struct$REGEX_TRANSOB, short_struct$CHART_TRANSOB)
short_struct$APP_UNKNOWN_TN <- calcTN(short_struct$REGEX_UNKNOWN, short_struct$CHART_APP_OTHER)
short_struct$MESH_CAT4_RCR <- bin4cat(short_struct$REGEX_MESH, short_struct$CHART_MESH)
short_struct$NO_MESH_CAT4_RCR <- bin4cat(short_struct$REGEX_NO_MESH, short_struct$CHART_NO_MESH) 
short_struct$INDETERMINATE_MESH_CAT4_RCR <- bin4cat(short_struct$REGEX_INDETERMINATE_MESH, short_struct$CHART_INDETERMINATE_MESH) 
short_struct$ADJ_SNGL_INC_CAT4 <- bin4cat(short_struct$REGEX_ADJ_SNGL_INC, short_struct$CHART_ADJ_SNGL_INC)
short_struct$RETROPUBIC_CAT4 <- bin4cat(short_struct$REGEX_RETROPUBIC, short_struct$CHART_RETROPUBIC)
short_struct$TRANSOB_CAT4 <- bin4cat(short_struct$REGEX_TRANSOB, short_struct$CHART_TRANSOB)
short_struct$APP_UNKNOWN_CAT4 <- bin4cat(short_struct$REGEX_UNKNOWN, short_struct$CHART_APP_OTHER)

# Additional Chart Review Datasets
short_struct_rest <- short_struct[!is.na(short_struct$REGEX_Mesh_YN) & short_struct$REGEX_Mesh_YN == "Yes",]
full_rest <- short_struct[!is.na(short_struct$FULL_CHART) & short_struct$FULL_CHART == 1 & 
                            !is.na(short_struct$REGEX_Mesh_YN) & short_struct$REGEX_Mesh_YN == "Yes",]
# Continuous
full_rest$BMI_COMPARE <- abs(full_rest$BMI - full_rest$BMI_CHART)
full_rest$DAYS_SURGERY_DEATH_COMPARE <- abs(full_rest$DAYS_SURGERY_DEATH - full_rest$DAYS_SURGERY_DEATH_CHART)
# Compare structured vs. full chart review
full_rest$HISTORYMENOPAUSE_DISCORDANT <- calcDiscord(full_rest$HISTORYMENOPAUSE, full_rest$HISTORYMENOPAUSE_CHART) 
full_rest$HISTORYSMOKING_DISCORDANT <- calcDiscord(full_rest$HISTORYSMOKING, full_rest$HISTORYSMOKING_CHART)
full_rest$PRIORPROLAPSE_DISCORDANT <- calcDiscord(full_rest$PRIORPROLAPSE, full_rest$PRIORPROLAPSE_CHART)
full_rest$PRIORSUI_DISCORDANT <- calcDiscord(full_rest$PRIORSUI, full_rest$PRIORSUI_CHART)
full_rest$PREABSURG_DISCORDANT <- calcDiscord(full_rest$PREABSURG, full_rest$PREABSURG_CHART)
full_rest$FISTULA_DISCORDANT <- calcDiscord(full_rest$FISTULAevent, full_rest$FISTULA_CHART)
full_rest$PREVOIDING_DISCORDANT <- calcDiscord(full_rest$PREVOIDINGevent, full_rest$PREVOIDING_CHART)
full_rest$SUI_IND_DISCORDANT <- calcDiscord(full_rest$SUI_IND, full_rest$SUI_IND_CHART)
full_rest$REOPERATION_DISCORDANT <- calcDiscord(full_rest$REOPERATIONevent, full_rest$REOPERATION_CHART)
full_rest$DEATH_DISCORDANT <- calcDiscord(full_rest$DEATHevent, full_rest$DEATH_CHART)
full_rest$REMOVAL_DISCORDANT <- calcDiscord(full_rest$REMOVALevent, full_rest$REMOVAL_CHART)
full_rest$CONCOMITANTSURG_DISCORDANT <- calcDiscord(full_rest$CONCOMITANTSURG, full_rest$CONCOMITANTSURG_CHART)
full_rest$PAIN_DISCORDANT <- calcDiscord(full_rest$PAINevent, full_rest$PAIN_CHART)
full_rest$PREHISTORYCHRONICPAIN_DISCORDANT <- calcDiscord(full_rest$PREHISTORYCHRONICPAIN, full_rest$PREHISTORYCHRONICPAIN_CHART)
full_rest$POSTVOIDING_DISCORDANT <- calcDiscord(full_rest$POSTVOIDINGevent, full_rest$POSTVOIDING_CHART)
full_rest$INFECTION_DISCORDANT <- calcDiscord(full_rest$INFECTIONevent, full_rest$INFECTION_CHART)
full_rest$PERFORATION_DISCORDANT <- calcDiscord(full_rest$PERFORATIONevent, full_rest$PERFORATION_CHART)
full_rest$EROSION_DISCORDANT <- calcDiscord(full_rest$EROSIONevent, full_rest$EROSION_CHART)
full_rest$URODYNAMICTESTING_DISCORDANT <- calcDiscord(full_rest$URODYNAMICTESTING, full_rest$URODYNAMICTESTING_CHART)
full_rest$POSTHISTORYCHRONICPAIN_DISCORDANT <- calcDiscord(full_rest$POSTHISTORYCHRONICPAIN, full_rest$POSTHISTORYCHRONICPAIN_CHART)

full_rest$HISTORYMENOPAUSE_TN <- calcTN(full_rest$HISTORYMENOPAUSE, full_rest$HISTORYMENOPAUSE_CHART) 
full_rest$HISTORYSMOKING_TN <- calcTN(full_rest$HISTORYSMOKING, full_rest$HISTORYSMOKING_CHART)
full_rest$PRIORPROLAPSE_TN <- calcTN(full_rest$PRIORPROLAPSE, full_rest$PRIORPROLAPSE_CHART)
full_rest$PRIORSUI_TN <- calcTN(full_rest$PRIORSUI, full_rest$PRIORSUI_CHART)
full_rest$PREABSURG_TN <- calcTN(full_rest$PREABSURG, full_rest$PREABSURG_CHART)
full_rest$FISTULA_TN <- calcTN(full_rest$FISTULAevent, full_rest$FISTULA_CHART)
full_rest$PREVOIDING_TN <- calcTN(full_rest$PREVOIDINGevent, full_rest$PREVOIDING_CHART)
full_rest$SUI_IND_TN <- calcTN(full_rest$SUI_IND, full_rest$SUI_IND_CHART)
full_rest$REOPERATION_TN <- calcTN(full_rest$REOPERATIONevent, full_rest$REOPERATION_CHART)
full_rest$DEATH_TN <- calcTN(full_rest$DEATHevent, full_rest$DEATH_CHART)
full_rest$REMOVAL_TN <- calcTN(full_rest$REMOVALevent, full_rest$REMOVAL_CHART)
full_rest$CONCOMITANTSURG_TN <- calcTN(full_rest$CONCOMITANTSURG, full_rest$CONCOMITANTSURG_CHART)
full_rest$PAIN_TN <- calcTN(full_rest$PAINevent, full_rest$PAIN_CHART)
full_rest$PREHISTORYCHRONICPAIN_TN <- calcTN(full_rest$PREHISTORYCHRONICPAIN, full_rest$PREHISTORYCHRONICPAIN_CHART)
full_rest$POSTVOIDING_TN <- calcTN(full_rest$POSTVOIDINGevent, full_rest$POSTVOIDING_CHART)
full_rest$INFECTION_TN <- calcTN(full_rest$INFECTIONevent, full_rest$INFECTION_CHART)
full_rest$PERFORATION_TN <- calcTN(full_rest$PERFORATIONevent, full_rest$PERFORATION_CHART)
full_rest$EROSION_TN <- calcTN(full_rest$EROSIONevent, full_rest$EROSION_CHART)
full_rest$URODYNAMICTESTING_TN <- calcTN(full_rest$URODYNAMICTESTING, full_rest$URODYNAMICTESTING_CHART)
full_rest$POSTHISTORYCHRONICPAIN_TN <- calcTN(full_rest$POSTHISTORYCHRONICPAIN, full_rest$POSTHISTORYCHRONICPAIN_CHART)

full_rest$HISTORYMENOPAUSE_CAT4 <- bin4cat(full_rest$HISTORYMENOPAUSE, full_rest$HISTORYMENOPAUSE_CHART) 
full_rest$HISTORYSMOKING_CAT4 <- bin4cat(full_rest$HISTORYSMOKING, full_rest$HISTORYSMOKING_CHART)
full_rest$PRIORPROLAPSE_CAT4 <- bin4cat(full_rest$PRIORPROLAPSE, full_rest$PRIORPROLAPSE_CHART)
full_rest$PRIORSUI_CAT4 <- bin4cat(full_rest$PRIORSUI, full_rest$PRIORSUI_CHART)
full_rest$PREABSURG_CAT4 <- bin4cat(full_rest$PREABSURG, full_rest$PREABSURG_CHART)
full_rest$FISTULA_CAT4 <- bin4cat(full_rest$FISTULAevent, full_rest$FISTULA_CHART)
full_rest$PREVOIDING_CAT4 <- bin4cat(full_rest$PREVOIDINGevent, full_rest$PREVOIDING_CHART)
full_rest$SUI_IND_CAT4 <- bin4cat(full_rest$SUI_IND, full_rest$SUI_IND_CHART)
full_rest$REOPERATION_CAT4 <- bin4cat(full_rest$REOPERATIONevent, full_rest$REOPERATION_CHART)
full_rest$DEATH_CAT4 <- bin4cat(full_rest$DEATHevent, full_rest$DEATH_CHART)
full_rest$BMI_CAT4 <- bin4cat(full_rest$BMI, full_rest$BMI_CHART)
full_rest$DAYS_SURGERY_DEATH_CAT4 <- bin4cat(full_rest$DAYS_SURGERY_DEATH, full_rest$DAYS_SURGERY_DEATH_CHART)
full_rest$REMOVAL_CAT4 <- bin4cat(full_rest$REMOVALevent, full_rest$REMOVAL_CHART)
full_rest$CONCOMITANTSURG_CAT4 <- bin4cat(full_rest$CONCOMITANTSURG, full_rest$CONCOMITANTSURG_CHART)
full_rest$PAIN_CAT4 <- bin4cat(full_rest$PAINevent, full_rest$PAIN_CHART)
full_rest$PREHISTORYCHRONICPAIN_CAT4 <- bin4cat(full_rest$PREHISTORYCHRONICPAIN, full_rest$PREHISTORYCHRONICPAIN_CHART)
full_rest$POSTVOIDING_CAT4 <- bin4cat(full_rest$POSTVOIDINGevent, full_rest$POSTVOIDING_CHART)
full_rest$INFECTION_CAT4 <- bin4cat(full_rest$INFECTIONevent, full_rest$INFECTION_CHART)
full_rest$PERFORATION_CAT4 <- bin4cat(full_rest$PERFORATIONevent, full_rest$PERFORATION_CHART)
full_rest$EROSION_CAT4 <- bin4cat(full_rest$EROSIONevent, full_rest$EROSION_CHART)
full_rest$URODYNAMICTESTING_CAT4 <- bin4cat(full_rest$URODYNAMICTESTING, full_rest$URODYNAMICTESTING_CHART)
full_rest$POSTHISTORYCHRONICPAIN_CAT4 <- bin4cat(full_rest$POSTHISTORYCHRONICPAIN, full_rest$POSTHISTORYCHRONICPAIN_CHART)

## Lists of variables - compare structured vs. full chart review (Gold)
disc.factor.var <- c("HISTORYMENOPAUSE_DISCORDANT", "HISTORYSMOKING_DISCORDANT", "PRIORPROLAPSE_DISCORDANT",
                     "PRIORSUI_DISCORDANT", "PREABSURG_DISCORDANT", "FISTULA_DISCORDANT",
                     "MESH_DISCORDANT_SCR", "NO_MESH_DISCORDANT_SCR", "INDETERMINATE_MESH_DISCORDANT_SCR",
                     "PREVOIDING_DISCORDANT", "SUI_IND_DISCORDANT", 
                     "REOPERATION_DISCORDANT", "DEATH_DISCORDANT", "REMOVAL_DISCORDANT", 
                     "CONCOMITANTSURG_DISCORDANT", "PAIN_DISCORDANT", "PREHISTORYCHRONICPAIN_DISCORDANT", 
                     "POSTVOIDING_DISCORDANT", "INFECTION_DISCORDANT", "PERFORATION_DISCORDANT",
                     "EROSION_DISCORDANT", "URODYNAMICTESTING_DISCORDANT", "POSTHISTORYCHRONICPAIN_DISCORDANT")
truth.factor.var <- c("HISTORYMENOPAUSE_TN", "HISTORYSMOKING_TN", "PRIORPROLAPSE_TN",
                     "PRIORSUI_TN", "PREABSURG_TN", "FISTULA_TN",
                     "MESH_TN_SCR", "NO_MESH_TN_SCR", "INDETERMINATE_MESH_TN_SCR", 
                     "PREVOIDING_TN", "SUI_IND_TN", 
                     "REOPERATION_TN", "DEATH_TN", "REMOVAL_TN", 
                     "CONCOMITANTSURG_TN", "PAIN_TN", "PREHISTORYCHRONICPAIN_TN", 
                     "POSTVOIDING_TN", "INFECTION_TN", "PERFORATION_TN",
                     "EROSION_TN", "URODYNAMICTESTING_TN", "POSTHISTORYCHRONICPAIN_TN")
cat4.factor.var <- c("HISTORYMENOPAUSE_CAT4", "HISTORYSMOKING_CAT4", "PRIORPROLAPSE_CAT4",
                     "PRIORSUI_CAT4", "PREABSURG_CAT4", "FISTULA_CAT4",
                     "MESH_CAT4_SCR", "NO_MESH_CAT4_SCR", "INDETERMINATE_MESH_CAT4_SCR",
                     "PREVOIDING_CAT4", "SUI_IND_CAT4", 
                     "REOPERATION_CAT4", "DEATH_CAT4", "REMOVAL_CAT4", 
                     "CONCOMITANTSURG_CAT4", "PAIN_CAT4", "PREHISTORYCHRONICPAIN_CAT4", 
                     "POSTVOIDING_CAT4", "INFECTION_CAT4", "PERFORATION_CAT4",
                     "EROSION_CAT4", "URODYNAMICTESTING_CAT4", "POSTHISTORYCHRONICPAIN_CAT4")

# Additional Chart Review Datasets
full_npp_rest <- full_rest[!is.na(full_rest$prior_prolapse) & full_rest$prior_prolapse == 2,]
full_as_rest <- full_rest[!is.na(full_rest$REGEX_Approach) & full_rest$REGEX_Approach == "Adj_sling",]
full_as_npp_rest <- full_npp_rest[!is.na(full_npp_rest$REGEX_Approach) & full_npp_rest$REGEX_Approach == "Adj_sling",]
full_ret_rest <- full_rest[!is.na(full_rest$REGEX_Approach) & full_rest$REGEX_Approach == "Retropubic",]
full_ret_npp_rest <- full_npp_rest[!is.na(full_npp_rest$REGEX_Approach) & full_npp_rest$REGEX_Approach == "Retropubic",]
full_si_rest <- full_rest[!is.na(full_rest$REGEX_Approach) & full_rest$REGEX_Approach == "Sngl_Inc",]
full_si_npp_rest <- full_npp_rest[!is.na(full_npp_rest$REGEX_Approach) & full_npp_rest$REGEX_Approach == "Sngl_Inc",]
full_tra_rest <- full_rest[!is.na(full_rest$REGEX_Approach) & (full_rest$REGEX_Approach == "Transob_In_Out" |
                           full_rest$REGEX_Approach == "Transob_Out_In" | full_rest$REGEX_Approach == "Transob_Unk"),]
full_tra_npp_rest <- full_npp_rest[!is.na(full_npp_rest$REGEX_Approach) & (full_npp_rest$REGEX_Approach == "Transob_In_Out" |
                                   full_npp_rest$REGEX_Approach == "Transob_Out_In" | full_npp_rest$REGEX_Approach == "Transob_Unk"),]
full_un_rest <- full_rest[!is.na(full_rest$REGEX_Approach) & (full_rest$REGEX_Approach == "Burch" |
                          full_rest$REGEX_Approach == "Indeterminate"),]
full_un_npp_rest <- full_npp_rest[!is.na(full_npp_rest$REGEX_Approach) & (full_npp_rest$REGEX_Approach == "Burch" |
                                  full_npp_rest$REGEX_Approach == "Indeterminate"),]

## Function to summarize factor fields
sum_factor <- function(dat, var, site){
  f2 <- rep(site, length(var))
  f3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(is.na(x))))               #n_missing
  f4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(is.na(x))/length(x))) #perc_missing
  f5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x))))              #n_nonmiss
  f6 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==1)))       #n_yes
  f7 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==1)/sum(!is.na(x)))) #perc_yes
  f8 <- rep(ver, length(var))
  f1 <- row.names(f3)
  f <- cbind(f1, f2, f3, f4, f5, f6, f7, f8)
  colnames(f) <- c("field", "site", "n_missing", "perc_missing", "n_nonmiss", "n_yes", "perc_yes", "version")
  # Censor counts 1-10
  f$n_yes <- ifelse(f$n_yes > 0 & f$n_yes < 11, "[1-10]", f$n_yes)
  f$perc_yes <- ifelse(f$n_yes == "[1-10]", "[1-10]", f$perc_yes)
  return(f)
}

## Summarize factor fields overall
f45 <- sum_factor(dat=mesh, var=factor.var, site=site)
write.csv(f45, paste("./", site, "_Factor_Descriptives_Overall_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f46 <- sum_factor(dat=mesh_npp_rest, var=factor.var, site=site)
write.csv(f46, paste("./", site, "_Factor_Descriptives_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f47 <- sum_factor(dat=mesh_no_prior_prolapse, var=factor.var, site=site)
write.csv(f47, paste("./", site, "_Factor_Descriptives_Overall_No_Prior_Prolapse_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f48 <- sum_factor(dat=mesh_rest, var=factor.var, site=site)
write.csv(f48, paste("./", site, "_Factor_Descriptives_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize factor fields by approach Adj_sling
f49 <- sum_factor(dat=as_npp_rest, var=factor.var, site=site)
write.csv(f49, paste("./", site, "_Factor_Descriptives_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f50 <- sum_factor(dat=as_rest, var=factor.var, site=site)
write.csv(f50, paste("./", site, "_Factor_Descriptives_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize factor fields by approach Retropubic
f51 <- sum_factor(dat=ret_npp_rest, var=factor.var, site=site)
write.csv(f51, paste("./", site, "_Factor_Descriptives_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f52 <- sum_factor(dat=ret_rest, var=factor.var, site=site)
write.csv(f52, paste("./", site, "_Factor_Descriptives_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize factor fields by approach Sngl_Inc
f53 <- sum_factor(dat=si_npp_rest, var=factor.var, site=site)
write.csv(f53, paste("./", site, "_Factor_Descriptives_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f54 <- sum_factor(dat=si_rest, var=factor.var, site=site)
write.csv(f54, paste("./", site, "_Factor_Descriptives_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize factor fields by approach Transobturator
f55 <- sum_factor(dat=tra_npp_rest, var=factor.var, site=site)
write.csv(f55, paste("./", site, "_Factor_Descriptives_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f56 <- sum_factor(dat=tra_rest, var=factor.var, site=site)
write.csv(f56, paste("./", site, "_Factor_Descriptives_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize factor fields by approach Unknown
f57 <- sum_factor(dat=un_npp_rest, var=factor.var, site=site)
write.csv(f57, paste("./", site, "_Factor_Descriptives_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f58 <- sum_factor(dat=un_rest, var=factor.var, site=site)
write.csv(f58, paste("./", site, "_Factor_Descriptives_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Function to summarize numeric fields
sum_numeric <- function(dat, var, site){
  n2 <- rep(site, length(var))
  n3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(is.na(x))))               #n_missing
  n4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(is.na(x))/length(x))) #perc_missing
  n5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x))))              #n_nonmiss
  n6 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, min(x, na.rm=TRUE))))
  n7 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA,
                                                                         quantile(x, probs=c(0.25), na.rm=TRUE))))
  n8 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, median(x, na.rm=TRUE))))
  n9 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA,
                                                                         quantile(x, probs=c(0.75), na.rm=TRUE))))
  n10 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, max(x, na.rm=TRUE))))
  n11 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, mean(x, na.rm=TRUE))))
  n12 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, sd(x, na.rm=TRUE))))
  n13 <- rep(ver, length(var))
  n1 <- row.names(n3)
  n <- cbind(n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13)
  colnames(n) <- c("field", "site", "n_missing", "perc_missing", "n_nonmiss", "min", "q1", "median",
                   "q3", "max", "mean", "std", "version")
  # Censor counts 1-10
  n$n_nonmiss <- ifelse(n$n_nonmiss > 0 & n$n_nonmiss < 11, "[1-10]", n$n_nonmiss)
  return(n)
}

## Summarize numeric fields overall
f72 <- sum_numeric(dat=mesh_no_prior_prolapse, var=numeric.var, site=site)
write.csv(f72, paste("./", site, "_Numeric_Descriptives_Overall_No_Prior_Prolapse_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f73 <- sum_numeric(dat=mesh_npp_rest, var=numeric.var, site=site)
write.csv(f73, paste("./", site, "_Numeric_Descriptives_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f74 <- sum_numeric(dat=mesh, var=numeric.var, site=site)
write.csv(f74, paste("./", site, "_Numeric_Descriptives_Overall_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f75 <- sum_numeric(dat=mesh_rest, var=numeric.var, site=site)
write.csv(f75, paste("./", site, "_Numeric_Descriptives_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize numeric fields by approach Adj_sling
f76 <- sum_numeric(dat=as_npp_rest, var=numeric.var, site=site)
write.csv(f76, paste("./", site, "_Numeric_Descriptives_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f77 <- sum_numeric(dat=as_rest, var=numeric.var, site=site)
write.csv(f77, paste("./", site, "_Numeric_Descriptives_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize numeric fields by approach Retropubic
f78 <- sum_numeric(dat=ret_npp_rest, var=numeric.var, site=site)
write.csv(f78, paste("./", site, "_Numeric_Descriptives_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f79 <- sum_numeric(dat=ret_rest, var=numeric.var, site=site)
write.csv(f79, paste("./", site, "_Numeric_Descriptives_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize numeric fields by approach Sngl_Inc
f80 <- sum_numeric(dat=si_npp_rest, var=numeric.var, site=site)
write.csv(f80, paste("./", site, "_Numeric_Descriptives_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f81 <- sum_numeric(dat=si_rest, var=numeric.var, site=site)
write.csv(f81, paste("./", site, "_Numeric_Descriptives_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize numeric fields by approach Transobturator
f82 <- sum_numeric(dat=tra_npp_rest, var=numeric.var, site=site)
write.csv(f82, paste("./", site, "_Numeric_Descriptives_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f83 <- sum_numeric(dat=tra_rest, var=numeric.var, site=site)
write.csv(f83, paste("./", site, "_Numeric_Descriptives_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Summarize numeric fields by approach Unknown
f84 <- sum_numeric(dat=un_npp_rest, var=numeric.var, site=site)
write.csv(f84, paste("./", site, "_Numeric_Descriptives_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f85 <- sum_numeric(dat=un_rest, var=numeric.var, site=site)
write.csv(f85, paste("./", site, "_Numeric_Descriptives_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)


# Chart Review
## Short Chart Review (all patients)
### Summarize factor fields - overall
f31 <- sum_factor(dat=short_struct, var=chart.factor.all, site=site)
write.csv(f31, paste("./", site, "_Factor_Descriptives_SCR_All_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f32 <- sum_factor(dat=short_struct_rest, var=chart.factor.all, site=site)
write.csv(f32, paste("./", site, "_Factor_Descriptives_SCR_All_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
            
## Full Chart Review (fewer patients)
### Summarize factor fields - overall
f33 <- sum_factor(dat=full_npp_rest, var=chart.factor.dd, site=site)
write.csv(f33, paste("./", site, "_Factor_Descriptives_FCR_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f34 <- sum_factor(dat=full_rest, var=chart.factor.dd, site=site)
write.csv(f34, paste("./", site, "_Factor_Descriptives_FCR_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize factor fields by approach - Adj sling
f35 <- sum_factor(dat=full_as_npp_rest, var=chart.factor.dd, site=site)
write.csv(f35, paste("./", site, "_Factor_Descriptives_FCR_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f36 <- sum_factor(dat=full_as_rest, var=chart.factor.dd, site=site)
write.csv(f36, paste("./", site, "_Factor_Descriptives_FCR_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize factor fields by approach - Retropubic
f37 <- sum_factor(dat=full_ret_npp_rest, var=chart.factor.dd, site=site)
write.csv(f37, paste("./", site, "_Factor_Descriptives_FCR_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f38 <- sum_factor(dat=full_ret_rest, var=chart.factor.dd, site=site)
write.csv(f38, paste("./", site, "_Factor_Descriptives_FCR_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize factor fields by approach - Sngl Inc
f39 <- sum_factor(dat=full_si_npp_rest, var=chart.factor.dd, site=site)
write.csv(f39, paste("./", site, "_Factor_Descriptives_FCR_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f40 <- sum_factor(dat=full_si_rest, var=chart.factor.dd, site=site)
write.csv(f40, paste("./", site, "_Factor_Descriptives_FCR_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize factor fields by approach - Transobturator
f41 <- sum_factor(dat=full_tra_npp_rest, var=chart.factor.dd, site=site)
write.csv(f41, paste("./", site, "_Factor_Descriptives_FCR_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f42 <- sum_factor(dat=full_tra_rest, var=chart.factor.dd, site=site)
write.csv(f42, paste("./", site, "_Factor_Descriptives_FCR_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize factor fields by approach - Unknown
f43 <- sum_factor(dat=full_un_npp_rest, var=chart.factor.dd, site=site)
write.csv(f43, paste("./", site, "_Factor_Descriptives_FCR_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f44 <- sum_factor(dat=full_un_rest, var=chart.factor.dd, site=site)
write.csv(f44, paste("./", site, "_Factor_Descriptives_FCR_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields - overall
f60 <- sum_numeric(dat=full_npp_rest, var=chart.num.dd, site=site)
write.csv(f60, paste("./", site, "_Numeric_Descriptives_FCR_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f61 <- sum_numeric(dat=full_rest, var=chart.num.dd, site=site)
write.csv(f61, paste("./", site, "_Numeric_Descriptives_FCR_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields by approach - Adj sling
f62 <- sum_numeric(dat=full_as_npp_rest, var=chart.num.dd, site=site)
write.csv(f62, paste("./", site, "_Numeric_Descriptives_FCR_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f63 <- sum_numeric(dat=full_as_rest, var=chart.num.dd, site=site)
write.csv(f63, paste("./", site, "_Numeric_Descriptives_FCR_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields by approach - Retropubic
f64 <- sum_numeric(dat=full_ret_npp_rest, var=chart.num.dd, site=site)
write.csv(f64, paste("./", site, "_Numeric_Descriptives_FCR_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f65 <- sum_numeric(dat=full_ret_rest, var=chart.num.dd, site=site)
write.csv(f65, paste("./", site, "_Numeric_Descriptives_FCR_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields by approach - Sngl Inc
f66 <- sum_numeric(dat=full_si_npp_rest, var=chart.num.dd, site=site)
write.csv(f66, paste("./", site, "_Numeric_Descriptives_FCR_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f67 <- sum_numeric(dat=full_si_rest, var=chart.num.dd, site=site)
write.csv(f67, paste("./", site, "_Numeric_Descriptives_FCR_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields by approach - Transobturator
f68 <- sum_numeric(dat=full_tra_npp_rest, var=chart.num.dd, site=site)
write.csv(f68, paste("./", site, "_Numeric_Descriptives_FCR_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f69 <- sum_numeric(dat=full_tra_rest, var=chart.num.dd, site=site)
write.csv(f69, paste("./", site, "_Numeric_Descriptives_FCR_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

### Summarize numeric fields by approach - Unknown
f70 <- sum_numeric(dat=full_un_npp_rest, var=chart.num.dd, site=site)
write.csv(f70, paste("./", site, "_Numeric_Descriptives_FCR_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f71 <- sum_numeric(dat=full_un_rest, var=chart.num.dd, site=site)
write.csv(f71, paste("./", site, "_Numeric_Descriptives_FCR_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

## Function to compare factor fields
compare_factor <- function(dat, var, s){
  f2 <- rep(s, length(var))
  f3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==1)))                    #n_discordant
  f4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x))))                           #N
  f5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==1)/sum(!is.na(x)))) #perc_discordant
  f6 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==0)))                    #n_concordant
  f7 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==0)/sum(!is.na(x)))) #perc_concordant
  f1 <- row.names(f3)
  fc <- cbind(f1, f2, f3, f4, f5, f6, f7)
  colnames(fc) <- c("field", "site", "n_discordant", "N", "perc_discordant", "n_concordant", "perc_concordant")
  return(fc)
}
compare_truth <- function(dat, var){
  t2 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==1)))                    #n TP
  t3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==1)/sum(!is.na(x)))) #perc TP
  t4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==2)))                    #n FP
  t5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==2)/sum(!is.na(x)))) #perc FP
  t6 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==3)))                    #n FN
  t7 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==3)/sum(!is.na(x)))) #perc FN
  t8 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==4)))                    #n TN
  t9 <- data.frame(sapply(dat[names(dat) %in% var], function(x) 100*sum(!is.na(x) & x==4)/sum(!is.na(x)))) #perc TN
  t1 <- row.names(t2)
  tc <- cbind(t1, t2, t3, t4, t5, t6, t7, t8, t9)
  colnames(tc) <- c("field", "n_tp", "perc_tp", "n_fp", "perc_fp", "n_fn", "perc_fn", "n_tn", "perc_tn")
  return(tc)
}
## Function to compare data availability
compare_present <- function(dat, var, c1=c1_order, c2=c2_order) {
  g2 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==1))) #Both present
  g3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==2))) #Cohort1 only
  g4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==3))) #Cohort2 only
  g5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) sum(!is.na(x) & x==4))) #Both NA
  g6 <- rep(ver, length(var))
  g1 <- row.names(g2)
  gc <- cbind(g1, g2, g3, g4, g5, g6)
  colnames(gc) <- c("field", "n_both_present", c1, c2, "n_both_null", "version")
  return(gc)
}
# Global function
global_compare <- function(dat, var.disc=disc.factor.var, var.truth=truth.factor.var, var.cat4=cat4.factor.var, st=site,
                           c1_order="n_structured_only", c2_order="n_chart_only"){
  fc <- compare_factor(dat, var=var.disc, s=st)
  tc <- compare_truth(dat, var=var.truth)
  gc <- compare_present(dat, var=var.cat4, c1_order, c2_order)
  hc <- cbind(fc, tc[,2:9], gc[,2:6])
  return(hc)
}

## Compare factor fields overall
f1 <- global_compare(dat=full_npp_rest)
write.csv(f1, paste("./", site, "_CompareSFCR_Factor_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f2 <- global_compare(dat=full_rest)
write.csv(f2, paste("./", site, "_CompareSFCR_Factor_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Adj Sling
f3 <- global_compare(dat=full_as_npp_rest)
write.csv(f3, paste("./", site, "_CompareSFCR_Factor_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f4 <- global_compare(dat=full_as_rest)
write.csv(f4, paste("./", site, "_CompareSFCR_Factor_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Retropubic
f5 <- global_compare(dat=full_ret_npp_rest)
write.csv(f5, paste("./", site, "_CompareSFCR_Factor_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f6 <- global_compare(dat=full_ret_rest)
write.csv(f6, paste("./", site, "_CompareSFCR_Factor_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Sngl Inc
f7 <- global_compare(dat=full_si_npp_rest)
write.csv(f7, paste("./", site, "_CompareSFCR_Factor_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f8 <- global_compare(dat=full_si_rest)
write.csv(f8, paste("./", site, "_CompareSFCR_Factor_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Transob
f9 <- global_compare(dat=full_tra_npp_rest)
write.csv(f9, paste("./", site, "_CompareSFCR_Factor_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f10 <- global_compare(dat=full_tra_rest)
write.csv(f10, paste("./", site, "_CompareSFCR_Factor_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Unknown
f11 <- global_compare(dat=full_un_npp_rest)
write.csv(f11, paste("./", site, "_CompareSFCR_Factor_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f12 <- global_compare(dat=full_un_rest)
write.csv(f12, paste("./", site, "_CompareSFCR_Factor_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)

# Regex vs. Short Chart Review (Gold Standard)
var.disc.rcr <- c("MESH_DISCORDANT_RCR", "NO_MESH_DISCORDANT_RCR", "INDETERMINATE_MESH_DISCORDANT_RCR",
                  "ADJ_SNGL_INC_DISCORDANT", "RETROPUBIC_DISCORDANT", "TRANSOB_DISCORDANT", "APP_UNKNOWN_DISCORDANT")
var.truth.rcr <- c("MESH_TN_RCR", "NO_MESH_TN_RCR", "INDETERMINATE_MESH_TN_RCR",
                   "ADJ_SNGL_INC_TN", "RETROPUBIC_TN", "TRANSOB_TN", "APP_UNKNOWN_TN")
var.cat4.rcr <- c("MESH_CAT4_RCR", "NO_MESH_CAT4_RCR", "INDETERMINATE_MESH_CAT4_RCR",
                  "ADJ_SNGL_INC_CAT4", "RETROPUBIC_CAT4", "TRANSOB_CAT4", "APP_UNKNOWN_CAT4")
f26 <- global_compare(dat=short_struct, var.disc=var.disc.rcr, var.truth=var.truth.rcr, var.cat4=var.cat4.rcr,
                      c1_order="n_regex_only", c2_order="n_chart_only")
write.csv(f26, paste("./", site, "_CompareRSCR_Factor_Overall_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)

# Structured vs. Regex Mesh (Gold Standard)
var.disc.rs <- c("MESH_DISCORDANT_RS", "NO_MESH_DISCORDANT_RS", "INDETERMINATE_MESH_DISCORDANT_RS")
var.truth.rs <- c("MESH_TN_RS", "NO_MESH_TN_RS", "INDETERMINATE_MESH_TN_RS")
var.cat4.rs <- c("MESH_CAT4_RS", "NO_MESH_CAT4_RS", "INDETERMINATE_MESH_CAT4_RS")
f27 <- global_compare(dat=mesh_no_prior_prolapse, var.disc=var.disc.rs, var.truth=var.truth.rs, var.cat4=var.cat4.rs,
                      c1_order="n_structured_only", c2_order="n_regex_only")
write.csv(f27, paste("./", site, "_CompareRS_Factor_Overall_No_Prior_Prolapse_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)
f28 <- global_compare(dat=mesh, var.disc=var.disc.rs, var.truth=var.truth.rs, var.cat4=var.cat4.rs,
                      c1_order="n_structured_only", c2_order="n_regex_only")
write.csv(f28, paste("./", site, "_CompareRS_Factor_Overall_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)

# Structured vs. Short Chart Review (Gold Standard)
var.disc.scr <- c("MESH_DISCORDANT_SCR", "NO_MESH_DISCORDANT_SCR", "INDETERMINATE_MESH_DISCORDANT_SCR")
var.truth.scr <- c("MESH_TN_SCR", "NO_MESH_TN_SCR", "INDETERMINATE_MESH_TN_SCR")
var.cat4.scr <- c("MESH_CAT4_SCR", "NO_MESH_CAT4_SCR", "INDETERMINATE_MESH_CAT4_SCR")
f30 <- global_compare(dat=short_struct, var.disc=var.disc.scr, var.truth=var.truth.scr, var.cat4=var.cat4.scr,
                      c1_order="n_structured_only", c2_order="n_chart_only")
write.csv(f30, paste("./", site, "_CompareSSCR_Factor_Overall_Not_Restricted_NLP.csv", sep="", collapse=NULL), row.names=FALSE)

## Function to compare numeric fields
compare_numeric <- function(dat, var, site){
  n2 <- rep(site, length(var))
  n3 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, mean(x, na.rm=TRUE))))   #mean
  n4 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, sd(x, na.rm=TRUE))))     #SD
  n5 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA,
                                                                       quantile(x, probs=c(0.25), na.rm=TRUE))))       #Q1
  n6 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA, median(x, na.rm=TRUE)))) #median
  n7 <- data.frame(sapply(dat[names(dat) %in% var], function(x) ifelse(sum(!is.na(x))==0, NA,
                                                                       quantile(x, probs=c(0.75), na.rm=TRUE))))       #Q3
  n1 <- row.names(n3)
  nc <- cbind(n1, n2, n3, n4, n5, n6, n7)
  colnames(nc) <- c("field", "site", "mean", "std", "q1", "median", "q3")
  return(nc)
}
#global function
global_compare_num <- function(dat, var.disc=diff.num.var, var.cat4=cat4.num.var, st=site,
                               c1_order="n_structured_only", c2_order="n_chart_only"){
  fc <- compare_numeric(dat, var=var.disc, s=st)
  gc <- compare_present(dat, var=var.cat4, c1_order, c2_order)
  hc <- cbind(fc, gc[,2:6])
  return(hc)
}
## Lists of variables
diff.num.var <- c("BMI_COMPARE", "DAYS_SURGERY_DEATH_COMPARE")
cat4.num.var <- c("BMI_CAT4", "DAYS_SURGERY_DEATH_CAT4")

# Overall
f13 <- global_compare_num(full_npp_rest)
write.csv(f13, paste("./", site, "_CompareSFCR_Numeric_Overall_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f14 <- global_compare_num(full_rest)
write.csv(f14, paste("./", site, "_CompareSFCR_Numeric_Overall_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Adj Sling
f15 <- global_compare_num(full_as_npp_rest)
write.csv(f15, paste("./", site, "_CompareSFCR_Numeric_Adj_Sling_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f16 <- global_compare_num(full_as_rest)
write.csv(f16, paste("./", site, "_CompareSFCR_Numeric_Adj_Sling_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Retropubic
f17 <- global_compare_num(full_ret_npp_rest)
write.csv(f17, paste("./", site, "_CompareSFCR_Numeric_Retropubic_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f18 <- global_compare_num(full_ret_rest)
write.csv(f18, paste("./", site, "_CompareSFCR_Numeric_Retropubic_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Sngl Inc
f19 <- global_compare_num(full_si_npp_rest)
write.csv(f19, paste("./", site, "_CompareSFCR_Numeric_Sngl_Inc_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f20 <- global_compare_num(full_si_rest)
write.csv(f20, paste("./", site, "_CompareSFCR_Numeric_Sngl_Inc_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Transob
f21 <- global_compare_num(full_tra_npp_rest)
write.csv(f21, paste("./", site, "_CompareSFCR_Numeric_Transob_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f22 <- global_compare_num(full_tra_rest)
write.csv(f22, paste("./", site, "_CompareSFCR_Numeric_Transob_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
# Unknown
f23 <- global_compare_num(full_un_npp_rest)
write.csv(f23, paste("./", site, "_CompareSFCR_Numeric_Unknown_No_Prior_Prolapse_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)
f24 <- global_compare_num(full_un_rest)
write.csv(f24, paste("./", site, "_CompareSFCR_Numeric_Unknown_Restricted_NLP_Mesh.csv", sep="", collapse=NULL), row.names=FALSE)