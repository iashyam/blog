#!/bin/bash

# Configuration
RAW_POSTS_DIR="posts"
POSTS_DIR="_posts"
ARCHETYPE_FILE="_archetypes/posts_archetype.md"

DATE=$(date +%Y-%m-%d)
TAGS=""

# Parse arguments
FORCE_OVERWRITE=false
while getopts "t:f" opt; do
    case $opt in
        t) TAGS="$OPTARG";;
        f) FORCE_OVERWRITE=true;;
        *) echo "Usage: synp [-f] [-t \"tag1,tag2\"] {post-name}"; exit 1;;
    esac
done
shift $((OPTIND - 1))

# Check arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: synp [-f] [-t \"tag1,tag2\"] {post-name}"
    exit 1
fi

POST_NAME="$1"
RAW_POST_PATH="$RAW_POSTS_DIR/$POST_NAME.md"
OUTPUT_FILE="$POSTS_DIR/$DATE-$POST_NAME.md"

# Check if the post exists
if [ ! -f "$RAW_POST_PATH" ]; then
    echo "Error: Markdown post '$RAW_POST_PATH' not found!"
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

# Add metadata from archetype and replace placeholders
if [ -f "$ARCHETYPE_FILE" ]; then
    sed -e "s/{{ title }}/$POST_NAME/g" \
        -e "s/{{ date }}/$DATE/g" "$ARCHETYPE_FILE" > "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Append custom tags if provided
if [ -n "$TAGS" ]; then
    sed -i "/^tags:/c\tags: [$TAGS]" "$OUTPUT_FILE"
fi

# Append raw Markdown content
cat "$RAW_POST_PATH" >> "$OUTPUT_FILE"

# Success message
echo "Post '$POST_NAME' published successfully as '$OUTPUT_FILE'."

