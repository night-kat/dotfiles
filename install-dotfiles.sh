#!bin/bash

DOTFILES_DIR="$HOME/dotfiles"

BACKUP_DIR="$HOME/dotfiles-backup"

create_symlink() {
    local source="$1"
    local target="$2"

    if [-e "$target" ]; then 
        echo "Backing up existing file $target"
        mv "$target" "$BACKUP_DIR/"
    fi

# Install dotfiles
    for file in "$DOTFILES_DIR"/.*; do
        # Skip the current and parent directory entries
        if [[ "$file" == "$DOTFILES_DIR"/. || "$file" == "$DOTFILES_DIR"/.. ]]; then
            continue
        fi

        # Get the base filename
        filename=$(basename "$file")
        target="$HOME/$filename"

        create_symlink "$file" "$target"
    done

    echo "Dotfiles installation complete!"
}
