# Fish shell config for Hyprland

set -gx PATH $HOME/.local/bin $PATH

# Wayland environment
set -gx QT_QPA_PLATFORM wayland
set -gx XDG_CURRENT_DESKTOP Hyprland
set -gx XDG_SESSION_DESKTOP Hyprland
set -gx XDG_SESSION_TYPE wayland
set -gx ELECTRON_OZONE_PLATFORM_HINT wayland
set -gx ELECTRON_ENABLE_WAYLAND 1

# Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias reload-waybar='pkill waybar; waybar &'
alias reload-dunst='pkill dunst; dunst &'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Functions
function wallpaper
    change-wallpaper $argv
end

function screenshot
    screenshot $argv
end 