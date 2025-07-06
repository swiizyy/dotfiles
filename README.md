# Williams's "Dotfiles"

**Hey, there!**

**I’m Williams, and I'm passionate about IT and coding and Homelab nerds.**

This Repository **Dotfiles** contain my personal config files. Here you'll find configs, customizations, themes, and whatever I need to personalize my mac OS experience.

> :warning: Be aware, products can change over time. I do my best to keep up with the latest changes and releases, but please understand that this won’t always be the case.

## Cross-Platform Package Manager Support

This dotfiles repository now includes unified package manager commands that work across different operating systems and distributions. The system automatically detects your package manager and provides consistent commands:

**Supported Package Managers:**
- **xbps** (Void Linux)
- **pacman** (Arch Linux)
- **apt** (Debian/Ubuntu)
- **dnf** (Fedora)
- **yum** (RHEL/CentOS)
- **zypper** (openSUSE)
- **brew** (macOS - Homebrew)
- **port** (macOS - MacPorts)

**Unified Commands:**
- `pkg-install <package>` - Install packages
- `pkg-update` - Update system packages
- `pkg-search <package>` - Search for packages
- `pkg-remove <package>` - Remove packages
- `pkg-list` - List installed packages
- `pkg-info <package>` - Show package information

The installation scripts in the Makefile automatically use the appropriate package manager for your system.

## Terminal and Application Icons with Nerd-Fonts

To display icons in terminal or applications Fonts, I'm using [Nerd-Fonts](https://www.nerdfonts.com). I'm currently using the **Hack Nerd Font Mono** in terminal applications, and **Hack Nerd Font** in applications.

## Contribution

If you’d like to contribute to this project, reach out to me on social media or [Discord](https://discord.com/channels/@me/1084262885955469342), or create a pull request for the necessary changes.