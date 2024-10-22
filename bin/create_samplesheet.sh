#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input_directory> <output_csv>"
  exit 1
fi

# Command-line arguments
input_dir="$1"
output_csv="$2"

# Create the header of the CSV file
echo "sample,file,index" > "$output_csv"

# Loop through all BAM files in the directory
for bam_file in "$input_dir"/*.bam; do
  # Get the base filename without the extension
  sample_name=$(basename "$bam_file" .bam | sed 's/\./_/g')
  
  # Find the corresponding BAI file
  bai_file="${bam_file}.bai"
  # If the BAI file exists, add the entry to the CSV
  if [ -f "$bai_file" ]; then
    echo "$sample_name,$bam_file,$bai_file" >> "$output_csv"
  else
    echo "Error: No index file found for $bam_file"
    exit 1
  fi
done

echo "CSV file created: $output_csv"
