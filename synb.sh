#!/bin/bash

# Configuration
NOTEBOOK_DIR="notebooks"
POSTS_DIR="_posts"
ARCHETYPE_FILE="_archetypes/archetype.md"
DATE=$(date +%Y-%m-%d)
TAGS=""

# Parse arguments
FORCE_OVERWRITE=false
while getopts "t:f" opt; do
    case $opt in
        t) TAGS="$OPTARG";;
        f) FORCE_OVERWRITE=true;;
        *) echo "Usage: synb [-f] [-t \"tag1,tag2\"] {notebook-name}"; exit 1;;
    esac
done
shift $((OPTIND - 1))

# Check arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: synb [-f] [-t \"tag1,tag2\"] {notebook-name}"
    exit 1
fi

NOTEBOOK_NAME="$1"
NOTEBOOK_PATH="$NOTEBOOK_DIR/$NOTEBOOK_NAME.ipynb"
OUTPUT_FILE="$POSTS_DIR/$DATE-$NOTEBOOK_NAME.md"
MEDIA_DIR="assets/$NOTEBOOK_NAME"
mkdir -p "$MEDIA_DIR"

# Check if the notebook exists
if [ ! -f "$NOTEBOOK_PATH" ]; then
    echo "Error: Notebook '$NOTEBOOK_PATH' not found!"
    exit 1
fi

# Check if the post already exists
if [ -f "$OUTPUT_FILE" ] && [ "$FORCE_OVERWRITE" = false ]; then
    echo "Warning: Post '$OUTPUT_FILE' already exists."
    read -p "Do you want to overwrite it? (y/n): " choice
    case "$choice" in 
        y|Y ) echo "Overwriting...";;
        n|N ) echo "Aborting."; exit 0;;
        * ) echo "Invalid choice."; exit 1;;
    esac
fi

# Convert the notebook to Markdown while ensuring images go into MEDIA_DIR
jupyter nbconvert --to markdown --output-dir="$MEDIA_DIR" "$NOTEBOOK_PATH"

# Locate the converted Markdown file
TEMP_FILE="$MEDIA_DIR/$NOTEBOOK_NAME.md"

# Ensure conversion was successful
if [ ! -f "$TEMP_FILE" ]; then
    echo "Error: Conversion failed."
    exit 1
fi

# Update image paths in the Markdown file
sed -i -E "s|(!\[.*\]\()([^)]*)(\))|\1$MEDIA_DIR/\2\3|g" "$TEMP_FILE"

# Add metadata from archetype and replace placeholders
if [ -f "$ARCHETYPE_FILE" ]; then
    sed -e "s/{{ title }}/$NOTEBOOK_NAME/g" \
        -e "s/{{ date }}/$DATE/g" "$ARCHETYPE_FILE" > "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Append custom tags if provided
if [ -n "$TAGS" ]; then
    sed -i "/^tags:/c\tags: [$TAGS]" "$OUTPUT_FILE"
fi

# Append converted Markdown content
cat "$TEMP_FILE" >> "$OUTPUT_FILE"

# Cleanup temp files
rm "$TEMP_FILE"

# Success message
echo "Notebook '$NOTEBOOK_NAME' published successfully as '$OUTPUT_FILE'."
