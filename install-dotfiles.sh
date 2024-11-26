#!/bin/bash

# Define the source directory for your dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Check if the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory does not exist: $DOTFILES_DIR"
    exit 1
fi

# Create a backup directory for existing dotfiles
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Backup directory created: $BACKUP_DIR"

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ]; then
        echo "Backing up existing file: $target"
        mv "$target" "$BACKUP_DIR/"
    fi

    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Install dotfiles
echo "Starting dotfiles installation..."
for file in "$DOTFILES_DIR"/.*; do
    # Skip the current and parent directory entries
    if [[ "$file" == "$DOTFILES_DIR"/. || "$file" == "$DOTFILES_DIR"/.. ]]; then
        continue
    fi

    # Skip .gitignore if you don't want it in your home directory
    if [[ "$(basename "$file")" == ".gitignore" ]]; then
        echo "Skipping .gitignore"
        continue
    fi

    # Get the base filename
    filename=$(basename "$file")
    target="$HOME/$filename"

    echo "Processing: $filename"  # Add this line for debugging
    create_symlink "$file" "$target"
done

echo "Dotfiles installation complete!"
