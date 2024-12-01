#!/bin/bash

# Loop over all .hs files with an underscore in the name
for file in *_[a-z]*.hs; do
  # Check if the file exists
  if [[ -f "$file" ]]; then
    # Generate the new filename with CamelCase format
    new_name=$(echo "$file" | sed -E 's/_([a-z])/\U\1/g')
    
    # Update the module name inside the file
    # Match the module line and convert it to CamelCase for the final component
    sed -i -E 's/(module [A-Za-z.]+)\.([A-Za-z]+)_([a-zA-Z]+)/\1.\u\2\u\3/g' "$file"

    # Rename the file
    mv "$file" "$new_name"
    echo "Renamed '$file' to '$new_name' and updated module name inside"
  fi
done



# Insert into the cabal file by replacing the existing Exposed-Modules section
#awk -v replacement="$(<modules.tmp)" '/^exposed-modules:/ { print replacement; found=1; next } !found || !/^ *$/' "$CABAL_FILE" > tmp && mv tmp "$CABAL_FILE"

## Clean up temporary file
#rm modules.tmp

#echo "Modules updated in $CABAL_FILE"
