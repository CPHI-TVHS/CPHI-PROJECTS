# User edit folder file path
path <- "U://NEST//Analysis"
# User edit site name (e.g. "Cornell", "Lahey", "Mayo", "Yale")
site <- "VUMC"
# User edit server internet access (TRUE or FALSE)
internet_access <- TRUE
# User edit date format for variables in flat file (ex. DATETIMESURGERY)
# Examples:
# If format is yyyy-mm-dd, then use "%Y-%m-%d"
# If format is mm-dd-yyyy, then use "%m-%d-%Y
# If format is mm/dd/yyyy, then use "%m/%d/%Y"
# If format is mm/dd/yy, then use "%m/%d/%y"
choose_date_format <- "%Y-%m-%d"


# User edit ONLY if want to use existing R library
# which may look like new_lib <- "C:/Users/username/Documents/R/win-library/3.6"
new_lib <- paste(path, "//Rlibrary", sep="")


## DO NOT EDIT ##
.libPaths(new_lib)
setwd(path)
source('./Descriptives.R')
