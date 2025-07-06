#!/bin/bash

# Theme Switcher for Dotfiles
# Supports Rose Pine and Catppuccin themes

# Get script directory to find themes relative to the dotfiles
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
THEME_DIR="$DOTFILES_DIR/.config/themes"
WAYBAR_DIR="$HOME/.config/waybar"
SWAYNC_DIR="$HOME/.config/swaync"
SWAY_DIR="$HOME/.config/sway"
LY_DIR="$HOME/.config/ly"

# Available themes
THEMES=("rose-pine" "rose-pine-moon" "rose-pine-dawn" "catppuccin-latte" "catppuccin-frappe" "catppuccin-macchiato" "catppuccin-mocha")

# Function to display usage
usage() {
    echo "Usage: $0 [theme]"
    echo "Available themes:"
    echo "  Rose Pine variants:"
    echo "    - rose-pine       (Base Rose Pine - dark)"
    echo "    - rose-pine-moon  (Rose Pine Moon - dark)"
    echo "    - rose-pine-dawn  (Rose Pine Dawn - light)"
    echo ""
    echo "  Catppuccin variants:"
    echo "    - catppuccin-latte      (Catppuccin Latte - light)"
    echo "    - catppuccin-frappe     (Catppuccin Frappé - dark)"
    echo "    - catppuccin-macchiato  (Catppuccin Macchiato - dark)"
    echo "    - catppuccin-mocha      (Catppuccin Mocha - dark)"
    echo ""
    echo "Example: $0 rose-pine-moon"
    echo "Example: $0 catppuccin-latte"
    exit 1
}

# Function to check if theme exists
theme_exists() {
    local theme=$1
    [[ -d "$THEME_DIR/$theme" ]]
}

# Function to apply theme
apply_theme() {
    local theme=$1
    
    echo "Applying $theme theme..."
    
    # Create directories if they don't exist
    mkdir -p "$WAYBAR_DIR" "$SWAYNC_DIR" "$SWAY_DIR" "$LY_DIR"
    
    # Copy theme files
    if [[ -f "$THEME_DIR/$theme/waybar.css" ]]; then
        cp "$THEME_DIR/$theme/waybar.css" "$WAYBAR_DIR/style.css"
        echo "✓ Applied $theme theme to waybar"
    fi
    
    if [[ -f "$THEME_DIR/$theme/swaync.css" ]]; then
        cp "$THEME_DIR/$theme/swaync.css" "$SWAYNC_DIR/style.css"
        echo "✓ Applied $theme theme to swaync"
    fi
    
    if [[ -f "$THEME_DIR/$theme/sway-theme.conf" ]]; then
        cp "$THEME_DIR/$theme/sway-theme.conf" "$SWAY_DIR/theme.conf"
        echo "✓ Applied $theme theme to sway"
    fi
    
    if [[ -f "$THEME_DIR/$theme/ly.ini" ]]; then
        cp "$THEME_DIR/$theme/ly.ini" "$LY_DIR/config.ini"
        echo "✓ Applied $theme theme to ly"
    fi
    
    # Create a file to remember the current theme
    echo "$theme" > "$HOME/.config/current-theme"
    
    echo ""
    echo "Theme $theme applied successfully!"
    echo "Restart sway or reload your configuration to see changes:"
    echo "  swaymsg reload"
    echo "  pkill waybar && waybar &"
    echo "  pkill swaync && swaync &"
}

# Function to show current theme
show_current_theme() {
    if [[ -f "$HOME/.config/current-theme" ]]; then
        local current_theme=$(cat "$HOME/.config/current-theme")
        echo "Current theme: $current_theme"
    else
        echo "No theme currently set"
    fi
}

# Main script
main() {
    if [[ $# -eq 0 ]]; then
        show_current_theme
        echo ""
        usage
    fi
    
    local theme=$1
    
    if [[ "$theme" == "--help" || "$theme" == "-h" ]]; then
        usage
    fi
    
    if [[ "$theme" == "--current" || "$theme" == "-c" ]]; then
        show_current_theme
        exit 0
    fi
    
    if ! theme_exists "$theme"; then
        echo "Error: Theme '$theme' not found."
        echo ""
        usage
    fi
    
    apply_theme "$theme"
}

main "$@"