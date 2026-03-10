# CLAUDE.md — dotfiles repository

This is a personal macOS dotfiles repository for a keyboard-driven development environment.
Remote: https://github.com/le4ker/dotfiles

## Repository Structure

```text
.config/
├── git/            # Git config, work-specific overrides, SSH signing
├── zsh/            # Zsh + Oh My Zsh configuration
├── nvim/           # Neovim (NvMegaChad) — separate git repo
├── vim/            # Fallback Vim configuration
├── kitty/          # Kitty terminal emulator
├── yabai/          # Tiling window manager
├── skhd/           # Hotkey daemon
├── sketchybar/     # Custom macOS menu bar
├── vimium/         # Chrome Vimium extension settings
├── github-copilot/ # GitHub Copilot config
├── Makefile        # Installation and service management
└── README.md       # Project overview and keybinding reference
```

## Key Makefile Targets

| Target           | Purpose                                         |
| ---------------- | ----------------------------------------------- |
| `install`        | Full setup: brew packages + symlinks + services |
| `brew-install`   | Install Homebrew packages                       |
| `brew-update`    | Update and clean Homebrew packages              |
| `link`           | Create symlinks (e.g. ~/.zshrc, ~/.gitconfig)   |
| `unlink`         | Remove symlinks and restore backups             |
| `services-start` | Start yabai, skhd, sketchybar daemons           |
| `services-stop`  | Stop daemons                                    |
| `restart`        | Gracefully restart all services                 |
| `uninstall`      | Stop services and remove symlinks               |
| `update`         | Update all Homebrew packages                    |

Run `make help` to list all targets.

## Commit Message Format

Use Conventional Commits:

```text
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

Examples:

- `feat(skhd): add window swap keybinding`
- `fix(zsh): correct pyenv initialization order`
- `chore(brew): add ripgrep to packages`

## Design Philosophy

- **Keyboard-driven**: All navigation and operations via keyboard shortcuts (yabai/skhd for windows, Vimium for browser, Neovim for editing)
- **Minimal UI**: Status bar (sketchybar) shows only essential info
- **SIP enabled**: Mouse operations in yabai are intentionally disabled
- **Secrets not tracked**: `~/.env-secrets` and `~/.panther-aliases` are loaded at runtime but never committed

## Git Signing

SSH commit signing via 1Password is scoped to work repos only (panther), configured via `git/config-panther` with an `includeIf` directive. Personal repos do not require signed commits.

## Neovim

`nvim/` is a separate git repository (NvMegaChad). It has its own `CLAUDE.md`, `Makefile`, and `README.md`. When making changes to Neovim config, follow the conventions documented in `nvim/CLAUDE.md`.

## Shell (Zsh)

- Framework: Oh My Zsh with theme `gnzh`
- Plugins: `zsh-autosuggestions`, `autojump`, `sudo`, `git`, `docker-compose`
- Version managers: `rbenv` (Ruby), `pyenv` (Python)
- SSH in Kitty uses `kitten ssh` for proper terminal integration

## Service Configuration (yabai + skhd + sketchybar)

These three services form the window/UI layer:

- **yabai**: BSP tiling layout, 6px gaps, integrates with sketchybar (32px bar height)
- **skhd**: Vim-style window navigation (`alt+h/j/k/l`), fullscreen and layout shortcuts
- **sketchybar**: Displays workspaces, clock, wifi, volume, battery, AirPods, focus mode

After editing any service config, run `make restart` to apply changes.
