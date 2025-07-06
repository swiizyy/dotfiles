# Migration Guide: X11/i3 to Wayland/Sway

This guide will help you migrate from X11 with i3 window manager to Wayland with Sway compositor on Void Linux.

## Overview

Sway is a tiling Wayland compositor and a drop-in replacement for the i3 window manager. This migration maintains most of your familiar i3 keybindings and workflow while moving to the modern Wayland protocol.

## Key Differences

### Wayland vs X11
- **Wayland**: Modern display server protocol with better security, performance, and multi-monitor support
- **X11**: Legacy display server with broader application compatibility

### Sway vs i3
- **Sway**: i3-compatible Wayland compositor
- **i3**: X11 window manager

## Migration Steps

### 1. Install Void Linux Packages

```bash
# Run the installation script
./scripts/install-void.sh

# Or install manually:
sudo xbps-install -S sway waybar swaylock swayidle swaybg swaync
sudo xbps-install -S foot alacritty starship zsh git direnv
sudo xbps-install -S dmenu wmenu grim slurp wl-clipboard pavucontrol
```

### 2. Set Up Dotfiles

```bash
# Install dotfiles with Void Linux support
make install-void
```

### 3. Configure Your Display Manager

#### For GDM (GNOME Display Manager):
- Sway should appear as an option in the session selector

#### For LightDM:
Add to `/etc/lightdm/lightdm.conf`:
```ini
[Seat:*]
sessions-directory=/usr/share/wayland-sessions
```

#### For SDDM:
Add to `/etc/sddm.conf`:
```ini
[Wayland]
SessionDir=/usr/share/wayland-sessions
```

### 4. Start Sway

```bash
# From TTY (recommended for first time)
sway

# Or select "Sway" from your display manager
```

## Configuration Migration

### i3 Config → Sway Config
Most i3 configurations can be copied to Sway with minimal changes:

```bash
# Copy your i3 config as a starting point
cp ~/.config/i3/config ~/.config/sway/config

# Then edit for Wayland-specific features
nano ~/.config/sway/config
```

### Key Configuration Changes

#### Output Configuration (Multi-monitor)
```bash
# Sway uses different output configuration
# List outputs
swaymsg -t get_outputs

# Configure in sway config
output HDMI-A-1 resolution 1920x1080 position 1920,0
output eDP-1 resolution 1920x1080 position 0,0
```

#### Screenshots
Replace X11 screenshot tools:
```bash
# Old (X11)
bindsym Print exec scrot

# New (Wayland)
bindsym Print exec grim ~/Pictures/screenshot.png
bindsym Shift+Print exec grim -g "$(slurp)" ~/Pictures/screenshot.png
```

#### Clipboard
```bash
# Wayland clipboard
# Copy: wl-copy
# Paste: wl-paste
```

## Application Compatibility

### Native Wayland Applications
- **Terminal**: foot, alacritty, kitty
- **Browser**: Firefox (with MOZ_ENABLE_WAYLAND=1), Chromium
- **Editor**: neovim, VS Code (with --enable-features=UseOzonePlatform --ozone-platform=wayland)

### XWayland Applications
Most X11 applications work through XWayland:
- Legacy applications
- Some proprietary software
- Applications with tray icons

### Environment Variables
Add to your shell configuration:
```bash
# ~/.zshenv or ~/.bashrc
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
```

## Features and Benefits

### Sway-Specific Features
- **Better HiDPI support**: Fractional scaling
- **Improved security**: Application isolation
- **Better multi-monitor**: Per-monitor scaling
- **Screen sharing**: Built-in support with pipewire

### Wayland Benefits
- **Smooth animations**: VSync by default
- **Better resource usage**: More efficient rendering
- **Modern architecture**: Better for modern hardware

## Troubleshooting

### Common Issues

#### Screen Sharing Not Working
```bash
# Install pipewire and xdg-desktop-portal
sudo xbps-install -S pipewire xdg-desktop-portal-wlr
```

#### Applications Not Scaling Properly
```bash
# In sway config
output * scale 1.5
```

#### Tray Icons Missing
```bash
# Some applications need XWayland for tray icons
# Check if sway is configured to start XWayland
xwayland enable
```

#### Performance Issues
```bash
# Disable unused features
# In sway config
output * adaptive_sync off
```

### Debugging

```bash
# Check sway status
swaymsg -t get_tree

# Monitor sway logs
journalctl -f _COMM=sway

# Check Wayland session
echo $WAYLAND_DISPLAY
```

## Rolling Back

If you need to return to X11/i3:

1. Install i3 and X11 components:
```bash
sudo xbps-install -S i3 xorg-server xinit
```

2. Select X11 session from display manager
3. Your i3 configuration should still be in `~/.config/i3/`

## Additional Resources

- [Sway Documentation](https://github.com/swaywm/sway/wiki)
- [Wayland Documentation](https://wayland.freedesktop.org/)
- [Void Linux Handbook](https://docs.voidlinux.org/)

## Next Steps

1. Customize your sway configuration in `~/.config/sway/config`
2. Set up waybar themes in `~/.config/waybar/`
3. Configure notification settings in `~/.config/swaync/`
4. Explore Wayland-native applications for better integration