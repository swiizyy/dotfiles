# Added locations to path variable
export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin

# NVM directory
export NVM_DIR="$HOME/.nvm"

export EDITOR=nano

# Wayland environment variables (for Void Linux)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export GDK_BACKEND=wayland
    export XDG_CURRENT_DESKTOP=sway
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
fi
