# Williams's "Dotfiles"

**Hey, there!**

**I'm Williams, and I'm passionate about IT and coding and Homelab nerds.**

This Repository **Dotfiles** contain my personal config files. Here you'll find configs, customizations, themes, and whatever I need to personalize my macOS and Linux experience.

> :warning: Be aware, products can change over time. I do my best to keep up with the latest changes and releases, but please understand that this won't always be the case.

## Supported Systems

- **macOS**: Original dotfiles with macOS-specific configurations
- **Void Linux**: New support for Void Linux with Wayland/Sway setup

## Cross-Platform Package Manager Support

This dotfiles repository includes unified package manager commands that work across different operating systems and distributions. The system automatically detects your package manager and provides consistent commands:

**Supported Package Managers:**
- **xbps** (Void Linux)
- **pacman** (Arch Linux)
- **apt** (Debian/Ubuntu)
- **dnf** (Fedora)
- **yum** (RHEL/CentOS)
- **zypper** (openSUSE)
- **brew** (macOS - Homebrew)
- **port** (macOS - MacPorts)
- **flatpak** (Universal - Cross-distribution)

**Unified Commands:**
- `pkg-install <package>` - Install packages
- `pkg-update` - Update system packages
- `pkg-search <package>` - Search for packages
- `pkg-remove <package>` - Remove packages
- `pkg-list` - List installed packages
- `pkg-info <package>` - Show package information
- `pkg-run <application>` - Launch applications (works with Flatpak apps and system binaries)

The installation scripts in the Makefile automatically use the appropriate package manager for your system.

### Application Launching

The `pkg-run` command provides a unified way to launch applications regardless of how they were installed:

- **Flatpak Apps**: Automatically detects and launches Flatpak applications using `flatpak run`
- **System Binaries**: Launches applications installed via package managers or available in PATH
- **Smart Detection**: Prioritizes Flatpak apps first, then falls back to system binaries

Examples:
```bash
# Launch a Flatpak application
pkg-run org.mozilla.firefox

# Launch a system application
pkg-run firefox

# Launch any application by name
pkg-run code
```

## Quick Start

### macOS Installation
```bash
make install
```

### Void Linux Installation (Wayland/Sway)
```bash
# Install system packages
./scripts/install-void.sh

# Install dotfiles
make install-void
```

## Wayland/Sway Setup (Void Linux)

This dotfiles repository now includes comprehensive support for Void Linux with a modern Wayland-based workflow:

### Components
- **Sway**: Tiling Wayland compositor (i3-compatible)
- **Waybar**: Highly customizable status bar
- **swaync**: Notification daemon for Sway
- **ly**: Lightweight TUI display manager
- **Starship**: Cross-shell prompt with Void Linux detection
- **Foot**: Default terminal emulator
- **Various utilities**: grim, slurp, wl-clipboard, etc.

### Features
- ✅ i3-compatible keybindings and workflow
- ✅ Modern Wayland protocol benefits
- ✅ Beautiful, customizable interface
- ✅ Multi-monitor support
- ✅ HiDPI/fractional scaling
- ✅ Screen sharing and recording
- ✅ Notification management

### Migration Guide
If you're migrating from X11/i3 to Wayland/Sway, check out the [Migration Guide](docs/MIGRATION.md) for detailed instructions.

## Terminal and Application Icons with Nerd-Fonts

To display icons in terminal or applications Fonts, I'm using [Nerd-Fonts](https://www.nerdfonts.com). I'm currently using the **Hack Nerd Font Mono** in terminal applications, and **Hack Nerd Font** in applications.

## Configuration Structure

```
dotfiles/
├── .config/
│   ├── starship.toml       # Starship prompt configuration
│   ├── sway/               # Sway compositor configuration
│   ├── waybar/             # Waybar status bar configuration
│   ├── swaync/             # Notification daemon configuration
│   └── ly/                 # ly display manager configuration
├── .zsh/                   # Zsh configuration files
├── scripts/                # Installation scripts
├── docs/                   # Documentation
└── Makefile               # Installation automation
```

## Contribution

If you'd like to contribute to this project, reach out to me on social media or [Discord](https://discord.com/channels/@me/1084262885955469342), or create a pull request for the necessary changes.