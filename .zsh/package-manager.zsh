#!/bin/bash
# Package Manager Unification
# ---
# Dynamic aliases to detect and use the correct package manager according to the distribution
# This provides unified commands that work across different Linux distributions and macOS

# Function to detect the package manager
detect_package_manager() {
    # Check for various package managers in order of preference
    if command -v xbps-install >/dev/null 2>&1; then
        echo "xbps"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    elif command -v apt >/dev/null 2>&1; then
        echo "apt"
    elif command -v dnf >/dev/null 2>&1; then
        echo "dnf"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v zypper >/dev/null 2>&1; then
        echo "zypper"
    elif command -v brew >/dev/null 2>&1; then
        echo "brew"
    elif command -v port >/dev/null 2>&1; then
        echo "port"
    elif command -v flatpak >/dev/null 2>&1; then
        echo "flatpak"
    else
        echo "unknown"
    fi
}

# Function to run/launch applications
pkg_run_app() {
    local app_name="$1"
    shift
    local app_args="$@"
    
    if [[ -z "$app_name" ]]; then
        echo "Usage: pkg-run <application-name>"
        return 1
    fi
    
    # Check if it's a Flatpak application first
    if command -v flatpak >/dev/null 2>&1; then
        if flatpak list --app 2>/dev/null | grep -q "$app_name"; then
            echo "Launching Flatpak app: $app_name"
            flatpak run "$app_name" $app_args
            return 0
        fi
    fi
    
    # Check if it's available in PATH
    if command -v "$app_name" >/dev/null 2>&1; then
        echo "Launching system app: $app_name"
        "$app_name" $app_args
        return 0
    fi
    
    # Try to find it in common application directories
    local app_dirs=("/usr/bin" "/usr/local/bin" "/opt/*/bin" "$HOME/.local/bin")
    for dir in "${app_dirs[@]}"; do
        if [[ -x "$dir/$app_name" ]]; then
            echo "Launching app from $dir: $app_name"
            "$dir/$app_name" $app_args
            return 0
        fi
    done
    
    echo "Application '$app_name' not found. Try:"
    echo "  - Check available Flatpak apps: flatpak list --app"
    echo "  - Check installed packages: pkg-list"
    echo "  - Search for the app: pkg-search $app_name"
    return 1
}

# Function to execute package manager commands
pkg_exec() {
    local action="$1"
    shift
    local packages="$*"
    
    local pkg_manager
    pkg_manager=$(detect_package_manager)
    
    case $pkg_manager in
        "xbps")
            case $action in
                "install") sudo xbps-install $packages ;;
                "update") sudo xbps-install -Su ;;
                "search") xbps-query -Rs $packages ;;
                "remove") sudo xbps-remove $packages ;;
                "list") xbps-query -l ;;
                "info") xbps-query -R $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "pacman")
            case $action in
                "install") sudo pacman -S $packages ;;
                "update") sudo pacman -Syu ;;
                "search") pacman -Ss $packages ;;
                "remove") sudo pacman -R $packages ;;
                "list") pacman -Q ;;
                "info") pacman -Si $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "apt")
            case $action in
                "install") sudo apt install $packages ;;
                "update") sudo apt update && sudo apt upgrade ;;
                "search") apt search $packages ;;
                "remove") sudo apt remove $packages ;;
                "list") apt list --installed ;;
                "info") apt show $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "dnf")
            case $action in
                "install") sudo dnf install $packages ;;
                "update") sudo dnf update ;;
                "search") dnf search $packages ;;
                "remove") sudo dnf remove $packages ;;
                "list") dnf list installed ;;
                "info") dnf info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "yum")
            case $action in
                "install") sudo yum install $packages ;;
                "update") sudo yum update ;;
                "search") yum search $packages ;;
                "remove") sudo yum remove $packages ;;
                "list") yum list installed ;;
                "info") yum info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "zypper")
            case $action in
                "install") sudo zypper install $packages ;;
                "update") sudo zypper update ;;
                "search") zypper search $packages ;;
                "remove") sudo zypper remove $packages ;;
                "list") zypper search --installed-only ;;
                "info") zypper info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "brew")
            case $action in
                "install") brew install $packages ;;
                "update") brew update && brew upgrade ;;
                "search") brew search $packages ;;
                "remove") brew uninstall $packages ;;
                "list") brew list ;;
                "info") brew info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "port")
            case $action in
                "install") sudo port install $packages ;;
                "update") sudo port selfupdate && sudo port upgrade outdated ;;
                "search") port search $packages ;;
                "remove") sudo port uninstall $packages ;;
                "list") port installed ;;
                "info") port info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        "flatpak")
            case $action in
                "install") flatpak install $packages ;;
                "update") flatpak update ;;
                "search") flatpak search $packages ;;
                "remove") flatpak uninstall $packages ;;
                "list") flatpak list ;;
                "info") flatpak info $packages ;;
                "run") pkg_run_app $packages ;;
                *) echo "Unknown action: $action" ;;
            esac
            ;;
        *)
            echo "No supported package manager found. Please install packages manually."
            exit 1
            ;;
    esac
}

# Detect the current package manager
PKG_MANAGER=$(detect_package_manager)

# Define unified aliases based on the detected package manager
case $PKG_MANAGER in
    "xbps")
        # Void Linux - xbps
        alias pkg-install="sudo xbps-install"
        alias pkg-update="sudo xbps-install -Su"
        alias pkg-search="xbps-query -Rs"
        alias pkg-remove="sudo xbps-remove"
        alias pkg-list="xbps-query -l"
        alias pkg-info="xbps-query -R"
        alias pkg-run="pkg_run_app"
        ;;
    "pacman")
        # Arch Linux - pacman
        alias pkg-install="sudo pacman -S"
        alias pkg-update="sudo pacman -Syu"
        alias pkg-search="pacman -Ss"
        alias pkg-remove="sudo pacman -R"
        alias pkg-list="pacman -Q"
        alias pkg-info="pacman -Si"
        alias pkg-run="pkg_run_app"
        ;;
    "apt")
        # Debian/Ubuntu - apt
        alias pkg-install="sudo apt install"
        alias pkg-update="sudo apt update && sudo apt upgrade"
        alias pkg-search="apt search"
        alias pkg-remove="sudo apt remove"
        alias pkg-list="apt list --installed"
        alias pkg-info="apt show"
        alias pkg-run="pkg_run_app"
        ;;
    "dnf")
        # Fedora - dnf
        alias pkg-install="sudo dnf install"
        alias pkg-update="sudo dnf update"
        alias pkg-search="dnf search"
        alias pkg-remove="sudo dnf remove"
        alias pkg-list="dnf list installed"
        alias pkg-info="dnf info"
        alias pkg-run="pkg_run_app"
        ;;
    "yum")
        # RHEL/CentOS - yum
        alias pkg-install="sudo yum install"
        alias pkg-update="sudo yum update"
        alias pkg-search="yum search"
        alias pkg-remove="sudo yum remove"
        alias pkg-list="yum list installed"
        alias pkg-info="yum info"
        alias pkg-run="pkg_run_app"
        ;;
    "zypper")
        # openSUSE - zypper
        alias pkg-install="sudo zypper install"
        alias pkg-update="sudo zypper update"
        alias pkg-search="zypper search"
        alias pkg-remove="sudo zypper remove"
        alias pkg-list="zypper search --installed-only"
        alias pkg-info="zypper info"
        alias pkg-run="pkg_run_app"
        ;;
    "brew")
        # macOS - Homebrew
        alias pkg-install="brew install"
        alias pkg-update="brew update && brew upgrade"
        alias pkg-search="brew search"
        alias pkg-remove="brew uninstall"
        alias pkg-list="brew list"
        alias pkg-info="brew info"
        alias pkg-run="pkg_run_app"
        ;;
    "port")
        # macOS - MacPorts
        alias pkg-install="sudo port install"
        alias pkg-update="sudo port selfupdate && sudo port upgrade outdated"
        alias pkg-search="port search"
        alias pkg-remove="sudo port uninstall"
        alias pkg-list="port installed"
        alias pkg-info="port info"
        alias pkg-run="pkg_run_app"
        ;;
    "flatpak")
        # Universal - Flatpak
        alias pkg-install="flatpak install"
        alias pkg-update="flatpak update"
        alias pkg-search="flatpak search"
        alias pkg-remove="flatpak uninstall"
        alias pkg-list="flatpak list"
        alias pkg-info="flatpak info"
        alias pkg-run="pkg_run_app"
        ;;
    *)
        # Unknown package manager - provide informative aliases
        alias pkg-install="echo 'No supported package manager found. Please install packages manually.'"
        alias pkg-update="echo 'No supported package manager found. Please update packages manually.'"
        alias pkg-search="echo 'No supported package manager found. Please search packages manually.'"
        alias pkg-remove="echo 'No supported package manager found. Please remove packages manually.'"
        alias pkg-list="echo 'No supported package manager found. Please list packages manually.'"
        alias pkg-info="echo 'No supported package manager found. Please get package info manually.'"
        alias pkg-run="echo 'No supported package manager found. Please run applications manually.'"
        ;;
esac

# Export the detected package manager for use in other scripts
export PKG_MANAGER

# If called directly (not sourced), execute the command
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    pkg_exec "$@"
fi