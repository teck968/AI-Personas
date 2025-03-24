#!/bin/bash

# Step 1: Check and update the repository
# Check if the current directory is a Git repository
if [ -d ".git" ]; then
  # It's a Git repository; prompt user to pull the latest changes
  read -p "Do you want to pull the latest changes from the repository? (y/n): " response
  case "$response" in
    [Yy]* )
      echo "Pulling the latest changes..."
      git pull || { echo "Error: Failed to pull changes."; exit 1; }
      ;;
    [Nn]* )
      echo "Skipping the pull. Using the current state of the directory as-is."
      ;;
    * )
      echo "Invalid input. Exiting."
      exit 1
      ;;
  esac
else
  # Not a Git repository; warn the user and proceed
  echo "Warning: This does not appear to be a Git repository. You will not be able to pull updates automatically."
  echo "Proceeding with the current files in the directory."
fi


# Step 2: Generate instructions to create memory mappings
echo "Generating instructions for memory mappings..."

MEMORY_INSTRUCTIONS=""
for FILE_PATH in "$PWD"/*.md; do
  FILE_NAME=$(basename "$FILE_PATH")

  # Skip README.md
  if [[ "$FILE_NAME" == "README.md" ]]; then
    continue
  fi

  # Remove ".md" from the mode name and format it
  MODE_NAME=$(echo "$FILE_NAME" | sed 's/\.md$//;s/_/ /g; s/\b\(.\)/\u\1/g') # Convert filename to mode name

  # Use fully qualified paths for the file
  MEMORY_INSTRUCTIONS+="Remember that persona:'$MODE_NAME' is defined in the file: $FILE_PATH.\n"
done

# Add the default mode mapping
MEMORY_INSTRUCTIONS+="Remember the 'Default' persona represents Goose’s unrestricted, general-purpose functionality.\n"
MEMORY_INSTRUCTIONS+="Review each persona's file contents and add its use cases to the memory."
MEMORY_INSTRUCTIONS+="Store all of these memories globally with appropriate tags.\n"
MEMORY_INSTRUCTIONS+="Remember when switching personas, identify very briefly its capabilities and provide a short list of ways that the user can get started.\n"
echo -e "Memory instructions generated."

# Step 3: Execute the instructions in Goose via command line
echo "Executing instructions in Goose..."

COMMAND="goose run -t \"$MEMORY_INSTRUCTIONS\""

# Run the command
eval "$COMMAND"

echo "Goose instructions executed. All mappings should now be in place!"
