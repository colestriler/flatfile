#!/bin/bash

# Source and destination directories
SOURCE_DIR="$1"
DEST_DIR="$2"

EXCLUDE_PATHS=(
    "node_modules"
    ".pnp"
    ".pnp.js"
    "coverage"
    ".next"
    "out"
    "build"
    ".DS_Store"
    "*.pem"
    "npm-debug.log*"
    "yarn-debug.log*"
    "yarn-error.log*"
    ".pnpm-debug.log*"
    ".env*.local"
    ".vercel"
    "*.tsbuildinfo"
    "next-env.d.ts"
    ".idea"
    ".sentryclirc"
    "dist",
    "app/api/test"
)

# Create the destination directory
mkdir -p "$DEST_DIR"

# Convert the array of exclude paths to find's -path options
EXCLUDE_FIND_ARGS=()
for path in "${EXCLUDE_PATHS[@]}"; do
    EXCLUDE_FIND_ARGS+=( -path "$SOURCE_DIR/$path" -prune -o )
done

# Find and copy relevant files, then rename them
find "$SOURCE_DIR" \
    "${EXCLUDE_FIND_ARGS[@]}" \
    -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.css" -o -name "*.sh" \) -print0 | while IFS= read -r -d '' file; do
    # Get the relative path within the source directory
    relative_path="${file#$SOURCE_DIR/}"
    
    # Generate the new file name based on the full relative path
    new_file=$(echo "$relative_path" | sed 's/\//_/g')
    
    # Print the source and destination file paths for debugging
    echo "Copying $file to $DEST_DIR/$new_file"
    
    # Copy the file to the destination directory with the new name
    cp "$file" "$DEST_DIR/$new_file" 2>&1 || { echo "Failed to copy $file"; exit 1; }
done







