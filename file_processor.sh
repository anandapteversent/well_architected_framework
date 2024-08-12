#!/bin/bash

# Check if correct number of arguments is passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file output_file column_name"
    exit 1
fi

input_file="$1"
output_file="$2"
column_name="$3"

# Get the column number of the column to remove
column_number=$(head -n 1 "$input_file" | tr ',' '\n' | nl -v 0 | grep -w "$column_name" | cut -f 1)

# Check if the column exists
if [ -z "$column_number" ]; then
    echo "Column '$column_name' not found in the input file."
    exit 1
fi

# Use awk to remove the column and create a new CSV file
awk -v col="$column_number" -F, '{
    $col = ""; sub(",,", ",", $0); sub(",$", "", $0); sub("^,", "", $0);
    print
}' "$input_file" > "$output_file"

echo "Column '$column_name' has been removed and the output saved to '$output_file'."