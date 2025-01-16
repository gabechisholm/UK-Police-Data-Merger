library(dplyr)

# Function to process the zip file and merge CSVs
process_zip <- function(zip_path, output_csv) {
  # Create a temporary directory for extraction
  temp_dir <- tempdir()
  unzip(zip_path, exdir = temp_dir)
  folders <- list.dirs(temp_dir, recursive = FALSE)
  data_list <- list()
  
  for (folder in folders) {
    csv_files <- list.files(folder, pattern = "\\.csv$", full.names = TRUE)
    if (length(csv_files) == 1) {
      data <- read.csv(csv_files[1], stringsAsFactors = FALSE)
      if ("LSOA.name" %in% colnames(data)) {
        data <- data %>%
          mutate(LSOA.name_trimmed = substr(LSOA.name, 1, nchar(LSOA.name) - 5)) %>%
          filter(grepl("Hartlepool", LSOA.name_trimmed))
      }
      data$FolderName <- basename(folder)
      data_list[[length(data_list) + 1]] <- data
    }
  }
  combined_data <- bind_rows(data_list)
  output_dir <- dirname(output_csv)
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  write.csv(combined_data, output_csv, row.names = FALSE)
  message("Combined CSV saved to: ", output_csv)
}

zip_file <- "C:\\Users\\RNSMGC\\Downloads\\0f8c5c46d9112b860aadb00e5eeac595c4a6bdf0.zip" # zip file path
output_file <- "C:\\Users\\RNSMGC\\Downloads\\data_temp\\combined_data.csv"     # desired output CSV file name
process_zip(zip_file, output_file)
