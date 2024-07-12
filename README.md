# Project File Flattener

This bash script is designed to flatten your project file structure, making it easier to upload files to Claude.ai's new project files feature. It copies files from a source directory to a destination directory, renaming them based on their original path to maintain uniqueness and traceability.

For example, it will take a folder that looks like this:
```
/src
  /app
    Button.tsx
    Card.tsx
```

and return a single folder like this:
```
/
  src_app_Buton.tsx
  src_app_Card.tsx
```


## Why This Is Useful

1. **Simplified Upload Process**: Claude.ai's project files feature has limitations on directory structure. This script flattens your project structure, making it easier to upload and work with your files in Claude.ai.

2. **Preserves File Relationships**: By encoding the original file path into the new filename, you can easily trace back where each file came from in your original project structure.

3. **Handles Name Conflicts**: Files with the same name but in different directories won't overwrite each other, as their new names include their original paths.

4. **Selective Copying**: The script only copies specific file types (`.ts`, `.tsx`, `.css`, `.sh`) and excludes common directories and files that are typically not needed (like `node_modules`, build outputs, etc.).

## How to Use

1. Save the script as `flatten_copy.sh` in your desired location.

2. Modify the `EXCLUDE_PATHS` list to exclude paths from being copied.

3. Select which file types to include: `-type f \( -name ".ts" -o -name ".tsx" -o -name ".css" -o -name "*.sh" \)`

4. Make the script executable:
`chmod +x flatten_copy.sh`

5. Run the script with source and destination directories:
`./flatten_copy.sh /path/to/source/directory /path/to/destination/directory`

## Features

- Copies only `.ts`, `.tsx`, `.css`, and `.sh` files.
- Excludes common directories and files (e.g., `node_modules`, `.next`, build outputs).
- Renames files based on their original path, replacing directory separators with underscores.
- Provides verbose output, showing each file being copied.
- Exits with an error if any file copy operation fails.

## Customization

- You can modify the `EXCLUDE_PATHS` array to add or remove directories/files to exclude.
- To include additional file types, modify the `-name` conditions in the `find` command.

## Notes

- Always test the script on a small subset of your project before running it on your entire codebase.
- Ensure you have write permissions for the destination directory.
- The script will overwrite files in the destination directory if they have the same name as the flattened files.

## Troubleshooting

If you encounter any issues:
1. Check that you have the necessary permissions for both source and destination directories.
2. Ensure the source directory path is correct and contains the files you expect.
3. Check the console output for any error messages about failed copy operations.
