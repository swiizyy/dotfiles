# Theme Documentation

This document describes the unified theming system for the dotfiles, which provides consistent styling across all Wayland/Sway components.

## Available Themes

### Rose Pine
A warm, cozy dark theme inspired by the natural tones of rose gardens.

**Color Palette:**
- **Base**: #191724 (Dark background)
- **Surface**: #1f1d2e (Card background)
- **Overlay**: #26233a (Overlay background)
- **Text**: #e0def4 (Primary text)
- **Pine**: #31748f (Blue accent)
- **Foam**: #9ccfd8 (Cyan accent)
- **Rose**: #ebbcba (Pink accent)
- **Love**: #eb6f92 (Red accent)
- **Gold**: #f6c177 (Yellow accent)
- **Iris**: #c4a7e7 (Purple accent)

### Catppuccin Mocha
A modern, vibrant theme with excellent contrast and readability.

**Color Palette:**
- **Base**: #1e1e2e (Dark background)
- **Mantle**: #181825 (Darker background)
- **Surface0**: #313244 (Card background)
- **Text**: #cdd6f4 (Primary text)
- **Blue**: #89b4fa (Blue accent)
- **Sapphire**: #74c7ec (Light blue accent)
- **Green**: #a6e3a1 (Green accent)
- **Yellow**: #f9e2af (Yellow accent)
- **Red**: #f38ba8 (Red accent)
- **Pink**: #f5c2e7 (Pink accent)
- **Mauve**: #cba6f7 (Purple accent)

## Theme Components

The theming system applies consistent colors across:

### Waybar (Status Bar)
- Background colors for different modules
- Workspace indicators
- System status colors (battery, CPU, memory, etc.)
- Button hover states

### swaync (Notifications)
- Notification background and borders
- Text and accent colors
- Control center styling
- Button states and interactions

### Sway (Window Manager)
- Window border colors
- Focused/unfocused states
- Urgent window indicators
- Workspace colors

### ly (Display Manager)
- Login screen colors
- Input field styling
- Error and success message colors
- Session selection colors

## Usage

### Theme Switcher
Use the `theme-switcher` command to change themes:

```bash
# Switch to Rose Pine theme
theme-switcher rose-pine

# Switch to Catppuccin theme
theme-switcher catppuccin

# Check current theme
theme-switcher --current

# Show help
theme-switcher --help
```

### Make Commands
You can also use make commands for theme management:

```bash
# Install theme system
make themes

# Apply Rose Pine theme
make theme-rose-pine

# Apply Catppuccin theme
make theme-catppuccin
```

### Manual Installation
The theme system is automatically installed with `make install-void`, but you can install themes manually:

```bash
# Link theme files
ln -sf ~/.config/themes/rose-pine/waybar.css ~/.config/waybar/style.css
ln -sf ~/.config/themes/rose-pine/swaync.css ~/.config/swaync/style.css
ln -sf ~/.config/themes/rose-pine/sway-theme.conf ~/.config/sway/theme.conf
ln -sf ~/.config/themes/rose-pine/ly.ini ~/.config/ly/config.ini
```

## Applying Theme Changes

After switching themes, you may need to restart or reload components:

```bash
# Reload Sway configuration
swaymsg reload

# Restart Waybar
pkill waybar && waybar &

# Restart notification daemon
pkill swaync && swaync &
```

For ly (display manager), changes take effect on the next login.

## Customization

### Creating Custom Themes
To create a custom theme:

1. Create a new directory in `.config/themes/`:
   ```bash
   mkdir -p ~/.config/themes/my-theme
   ```

2. Copy existing theme files as templates:
   ```bash
   cp ~/.config/themes/rose-pine/* ~/.config/themes/my-theme/
   ```

3. Edit the color values in each file
4. Apply your theme:
   ```bash
   theme-switcher my-theme
   ```

### Color Format
Colors can be specified in several formats:
- **Hex**: #191724
- **RGB**: rgb(25, 23, 36)
- **RGBA**: rgba(25, 23, 36, 0.9)

### Theme File Structure
Each theme directory should contain:
- `waybar.css` - Waybar styling
- `swaync.css` - Notification styling
- `sway-theme.conf` - Sway window manager colors
- `ly.ini` - Display manager colors

## Troubleshooting

### Theme Not Applied
- Ensure the theme directory exists
- Check file permissions
- Verify symlinks are created correctly
- Restart affected components

### Colors Not Showing
- Check if the application supports the color format used
- Verify CSS syntax is correct
- Ensure the configuration files are in the correct locations

### Performance Issues
- Some themes with transparency may impact performance
- Disable animations if needed
- Consider using solid colors instead of gradients