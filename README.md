# UK-Police-Data-Merger
# Process ZIP and Extract Filtered CSV Data

This R script processes a ZIP file containing folders with CSV files. It extracts, filters, and combines the data based on specific criteria, producing a single CSV output file.

## Features
- Extracts all folders and CSV files from a ZIP archive.
- Reads CSV files and checks for the presence of the `LSOA.name` column.
- Filters rows where `LSOA.name` contains "Hartlepool" (after trimming the last 5 characters).
- Adds a `FolderName` column to indicate the source folder.
- Combines filtered data from all CSV files into one output CSV file.

## Requirements
- R (4.4.1 or later recommended).
- Required library: `dplyr` (for data manipulation).

## How It Works
1. **Unzipping**:
   - The ZIP file is extracted to a temporary directory.
   - Each folder inside the ZIP is scanned for CSV files.

2. **Reading CSV Files**:
   - If a folder contains a single CSV file, it is read into R.
   - The script checks for the `LSOA.name` column.

3. **Filtering Data**:
   - Trims the last 5 characters from `LSOA.name` and creates a new column `LSOA.name_trimmed`.
   - Filters rows where `LSOA.name_trimmed` contains "Hartlepool".

4. **Adding Metadata**:
   - Appends the folder name as a new column (`FolderName`).

5. **Combining and Saving**:
   - All filtered datasets are combined using `bind_rows()`.
   - The combined data is written to the specified output file.

## Usage
1. Replace `ZIP-FILE-PATH` with the path to the ZIP file.
2. Replace `OUTPUT-FILE-PATH` with the desired output file path.
3. Run the script in R.

### Example
```r
library(dplyr)

zip_file <- "path/to/your/zipfile.zip"  # Path to the ZIP file
output_file <- "path/to/output/combined_data.csv"  # Desired output file path

process_zip(zip_file, output_file)
```

### Output Details
The output CSV will include:
- Filtered rows where `LSOA.name_trimmed` contains "Hartlepool".
- A new `FolderName` column indicating the original folder.

#### Sample Output
| LSOA.name         | LSOA.name_trimmed | OtherColumn1 | FolderName  |
|-------------------|-------------------|--------------|-------------|
| Hartlepool 001A   | Hartlepool   | Value1       | Folder1     |
| Hartlepool 001B   | Hartlepool    | Value2       | Folder2     |

## Function Details
### Signature
```r
process_zip <- function(zip_path, output_csv)
```
- **Arguments**:
  - `zip_path`: Path to the input ZIP file.
  - `output_csv`: Path to save the combined CSV file.

### Example Walkthrough
#### Input ZIP Structure:
```
data.zip
├── Folder1
│   └── data1.csv
├── Folder2
│   └── data2.csv
└── Folder3
    └── data3.csv
```
- Each CSV contains a column `LSOA.name` and other relevant data.

#### Steps:
1. Extract `data.zip`.
2. Process `data1.csv`, `data2.csv`, and `data3.csv`.
3. Filter rows containing "Hartlepool" in `LSOA.name_trimmed`.
4. Combine filtered data.

#### Output:
- A single CSV file (`combined_data.csv`):
```csv
LSOA.name,LSOA.name_trimmed,OtherColumn1,OtherColumn2,FolderName
Hartlepool West,Hartlepool West,Value1,Value2,Folder1
Hartlepool East,Hartlepool East,Value3,Value4,Folder2
```

