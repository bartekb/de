# Hyprland Environment for CachyOS

Minimal Hyprland setup with Catppuccin Mocha theme. No animations, clean and functional.

## Features

- **Hyprland** - Wayland compositor
- **Waybar** - Status bar with Catppuccin Mocha
- **Fuzzel** - Application launcher
- **Dunst** - Notifications
- **Hypridle/Hyprlock** - Power management and screen lock
- **Ghostty** - Terminal
- **Google Chrome, VSCode, Cursor, Teams, WebStorm** - Wayland-optimized
- **Steam** - Gaming platform with Vulkan support
- **Fish Shell** - Pre-configured with aliases
- **Wallpaper management** - Via hyprpaper
- **Screenshot annotations** - Via swappy
- **Comprehensive fonts** - Programming, international, emoji support

## Installation

```bash
git clone <repo-url>
cd de
chmod +x install.sh
./install.sh
```

Reboot and select Hyprland from display manager or run `Hyprland` from TTY.

## Key Bindings

### Basic
- `Super + T` - Terminal
- `Super + D` - Launcher
- `Super + B` - Browser
- `Super + E` - File manager
- `Super + Q` - Close window
- `Super + L` - Lock screen
- `Super + Shift + W` - Random wallpaper

### Navigation
- `Super + Arrow Keys` - Move focus
- `Super + Shift + Arrow Keys` - Move windows
- `Super + 1-0` - Switch workspaces
- `Super + Shift + 1-0` - Move windows to workspaces

### System
- `Print` - Screenshot area with annotations
- `Super + Print` - Screenshot full with annotations
- `Super + Shift + Print` - Screenshot area to clipboard
- `Super + Shift + S` - Suspend
- Media keys - Audio/brightness control

## File Structure

```
config/
├── hypr/
│   ├── hyprland.conf
│   ├── hypridle.conf
│   ├── hyprlock.conf
│   ├── hyprpaper.conf
│   └── wallpapers/
├── waybar/
│   ├── config
│   └── style.css
├── fuzzel/
│   └── fuzzel.ini
├── dunst/
│   └── dunstrc
├── fish/
│   └── config.fish
├── swappy/
│   └── config
└── applications/
    └── *-wayland.desktop

scripts/
├── screenshot
├── volume-control
├── brightness-control
├── change-wallpaper
├── init-dirs
└── setup-wayland-apps
```

## Colors

Catppuccin Mocha theme throughout all components.

## Requirements

- CachyOS (or Arch Linux)
- Fish shell
- AUR access (yay auto-installed)
- sudo privileges
- AMD GPU (Vulkan drivers included for Radeon 7600XT)

## Usage

### Wallpaper Management
```bash
change-wallpaper list
change-wallpaper set filename.png
change-wallpaper random
change-wallpaper path /full/path/to/image
```

### Screenshot Management
```bash
screenshot area           # Area screenshot with annotations
screenshot full           # Full screenshot with annotations
screenshot window         # Window screenshot with annotations
screenshot area-save      # Direct save without annotations
screenshot full-save      # Direct save without annotations
screenshot window-save    # Direct save without annotations
```

### Fish Shell Aliases
```bash
ll                  # ls -la
reload-waybar       # Restart waybar
reload-dunst        # Restart dunst
gs                  # git status
wallpaper random    # Change wallpaper
screenshot area     # Screenshot with annotations
```

## Troubleshooting

### Blurry Applications
```bash
./scripts/setup-wayland-apps
```

### Waybar Not Showing
```bash
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
```

### Audio Issues
```bash
systemctl --user status pipewire
```

### Screen Sharing Issues
Ensure xdg-desktop-portal-wlr is running:
```bash
systemctl --user status xdg-desktop-portal-wlr
systemctl --user restart xdg-desktop-portal-wlr
```

### Font Issues
If text appears as squares, refresh font cache:
```bash
fc-cache -fv
```

## Included Fonts

### System Fonts
- **Noto Fonts** - Universal font family with emoji and CJK support
- **Liberation Fonts** - Microsoft Office compatibility
- **DejaVu Fonts** - General purpose fonts
- **Open Sans** - Modern web font

### Programming Fonts
- **JetBrains Mono** - IDE font with ligatures
- **Fira Code** - Programming font with ligatures
- **Cascadia Code** - Microsoft's programming font
- **Source Code Pro** - Adobe's monospace font

### Icon Fonts
- **Font Awesome** - Web icons
- **Nerd Fonts Symbols** - Terminal icons

---

*Minimal, functional Hyprland environment without animations.*
