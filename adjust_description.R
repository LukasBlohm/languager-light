# Script to modify DESCRIPTION file
adjust_description <- function(restricted = FALSE) {
  
  desc <- read.dcf("DESCRIPTION", all = TRUE)
  
  packages_to_remove <- c("reticulate") 
  
  # If it's the restricted app, alter the dependencies
  if (restricted) {
    desc$Imports <- paste0(
      unlist(stringr::str_split(desc$Imports, ","))[!stringr::str_detect(
        unlist(stringr::str_split(desc$Imports, ",")), packages_to_remove)], 
      collapse = ",")
  }
  
  write.dcf(desc, "DESCRIPTION")
}

# Example usage
adjust_description(restricted = TRUE) 
