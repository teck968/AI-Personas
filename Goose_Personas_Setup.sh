#!/bin/bash

# Step 1: Clone the repository
REPO_URL="https://github.com/teck968/AI-Personas"
LOCAL_FOLDER="Personas"

echo "Checking if $LOCAL_FOLDER exists..."
if [ -d "$LOCAL_FOLDER" ]; then
  echo "Directory $LOCAL_FOLDER already exists."
  # Prompt user for action
  read -p "Do you want to pull the latest changes? (y/n): " response
  case "$response" in
    [Yy]* ) 
      echo "Pulling the latest changes..."
      cd "$LOCAL_FOLDER" && git pull && cd ..
      ;;
    [Nn]* )
      echo "Skipping pull. Using the existing directory as-is."
      ;;
    * )
      echo "Invalid input. Exiting."
      exit 1
      ;;
  esac
else
  echo "Cloning repository into $LOCAL_FOLDER..."
  git clone "$REPO_URL" "$LOCAL_FOLDER"
fi

echo "Repository setup complete."

# Step 2: Generate instructions to create memory mappings
echo "Generating instructions for memory mappings..."

MEMORY_INSTRUCTIONS=""
for FILE_PATH in "$PWD/$LOCAL_FOLDER"/*.md; do
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
MEMORY_INSTRUCTIONS+="Remember when switching personas, identify very briefly the its capabilities and provide a short list of ways that the user can get started.\n"
echo -e "Memory instructions generated:\n$MEMORY_INSTRUCTIONS"

# Step 3: Execute the instructions in Goose via command line
echo "Executing instructions in Goose..."

COMMAND="goose run -t \"$MEMORY_INSTRUCTIONS\""

# Run the command
eval "$COMMAND"

echo "Goose instructions executed. All mappings should now be in place!"