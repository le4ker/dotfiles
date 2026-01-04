# Dotfiles

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)
![Homebrew](https://img.shields.io/badge/Homebrew-FBB040?style=flat&logo=homebrew&logoColor=black)
![Kitty](https://img.shields.io/badge/Kitty-000000?style=flat&logo=gnometerminal&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)
![Vim](https://img.shields.io/badge/Vim-019733?style=flat&logo=vim&logoColor=white)

Personal macOS configuration files for a keyboard-driven development environment.

## What's Included

| Tool                                                                                       | Description                                                       |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------- |
| [git](https://git-scm.com)                                                                 | Version control with modern defaults                              |
| [kitty](https://sw.kovidgoyal.net/kitty/)                                                  | GPU-accelerated terminal emulator                                 |
| [neovim](https://neovim.io)                                                                | Configured via [NvMegaChad](https://github.com/le4ker/NvMegaChad) |
| [skhd](https://github.com/koekeishiya/skhd)                                                | Hotkey daemon for window management                               |
| [sketchybar](https://github.com/felixkratz/sketchybar)                                     | Custom macOS menu bar                                             |
| [vim](https://www.vim.org)                                                                 | Classic editor                                                    |
| [vimium](https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) | Vim keybindings for Chrome (backup config)                        |
| [yabai](https://github.com/koekeishiya/yabai)                                              | Tiling window manager                                             |
| [zsh](https://www.zsh.org)                                                                 | Shell with Oh My Zsh                                              |

## Installation

```bash
# Install everything (Homebrew packages + symlinks + services)
make install

# Or run individual steps
make brew-install    # Install Homebrew packages only
make link            # Create symlinks only
make services-start  # Start services only
```

## Usage

```bash
make help            # Show all available commands
make update          # Update all Homebrew packages
make restart         # Restart yabai, skhd, and sketchybar
make uninstall       # Stop services and remove symlinks
```

## Keyboard Shortcuts (skhd + yabai)

### Window Focus

| Shortcut        | Action                             |
| --------------- | ---------------------------------- |
| `alt + h/j/k/l` | Focus window west/south/north/east |

### Window Management

| Shortcut                | Action             |
| ----------------------- | ------------------ |
| `shift + alt + h/j/k/l` | Swap window        |
| `ctrl + alt + h/j/k/l`  | Warp/move window   |
| `shift + alt + space`   | Toggle float       |
| `shift + alt + f`       | Toggle fullscreen  |
| `shift + alt + r`       | Rotate layout      |
| `shift + alt + x/y`     | Mirror on x/y axis |

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://ohmyz.sh)

## Notes

- SIP (System Integrity Protection) remains **enabled** - mouse-based window operations are disabled in favor of keyboard shortcuts
- Work-specific git config is conditionally loaded from `git/config-panther`
- Secrets are sourced from `~/.env-secrets` (not tracked)

## License

[MIT](LICENSE)
