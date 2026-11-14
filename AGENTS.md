# Dotfiles Repository Instructions

This is a personal macOS dotfiles repository for a keyboard-driven development
environment. Remote: https://github.com/le4ker/dotfiles. `nvim/` is a separate
git checkout inside this directory and is ignored by the parent repository.

## Repository Structure

```text
.config/
├── .github/        # Repository assets
├── git/            # Git config, work-specific overrides, SSH signing
├── zsh/            # Zsh + Oh My Zsh configuration
├── nvim/           # Separate Neovim (NvMegaChad) repository
├── vim/            # Fallback Vim configuration
├── kitty/          # Kitty terminal emulator
├── yabai/          # Tiling window manager
├── skhd/           # Hotkey daemon
├── sketchybar/     # Custom macOS menu bar
├── vimium/         # Chrome Vimium extension settings
├── LICENSE         # Project license
├── Makefile        # Installation and service management
└── README.md       # Project overview and keybinding reference
```

## Makefile Targets

Run `make help` to list available targets. Main targets:

| Target           | Purpose                                           |
| ---------------- | ------------------------------------------------- |
| `install`        | Full setup: Homebrew packages, symlinks, services |
| `brew-install`   | Install Homebrew packages                         |
| `brew-update`    | Update and clean Homebrew packages                |
| `link`           | Back up `~/.zshrc`, then create config symlinks   |
| `unlink`         | Remove symlinks and restore the `~/.zshrc` backup |
| `services-start` | Start yabai, skhd, sketchybar daemons             |
| `services-stop`  | Stop daemons                                      |
| `restart`        | Restart all services                              |
| `uninstall`      | Stop services and remove symlinks                 |
| `update`         | Update all Homebrew packages                      |

Do not run setup, uninstall, or service-management targets unless the task calls
for changing the local machine state.

## Commit Message Format

Use Conventional Commits:

```text
<type>(<scope>): <description>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`,
`ci`, `chore`, `revert`.

Examples:

- `feat(skhd): add window swap keybinding`
- `fix(zsh): correct pyenv initialization order`
- `chore(brew): add ripgrep to packages`

## Design Philosophy

- **Keyboard-driven**: Navigation uses yabai/skhd for windows, Vimium for the
  browser, and Neovim for editing.
- **Minimal UI**: sketchybar shows essential status information.
- **SIP enabled**: Mouse operations in yabai are intentionally disabled.
- **Secrets not tracked**: `~/.env-secrets` and `~/.panther-aliases` are loaded
  at runtime and must never be committed.

## Git Signing

SSH commit signing via 1Password is scoped to work repositories (`panther`),
configured through `git/config-panther` and an `includeIf` directive. Personal
repositories do not require signed commits.

## Neovim

`nvim/` is a separate git repository (NvMegaChad), not tracked by this parent
repository. It has its own `AGENTS.md`, `Makefile`, and `README.md`. Read
`nvim/AGENTS.md` before changing Neovim configuration and follow its
conventions.

## Shell (Zsh)

- Framework: Oh My Zsh with theme `gnzh`.
- Plugins: `zsh-autosuggestions`, `autojump`, `sudo`, `git`, `docker-compose`.
- Version managers: `rbenv` (Ruby), `pyenv` (Python).
- SSH in Kitty uses `kitten ssh` for terminal integration.

## Services (yabai, skhd, sketchybar)

These services form the window and UI layer:

- **yabai**: BSP tiling layout, 6px gaps, integrated with sketchybar (32px bar).
- **skhd**: Vim-style window navigation (`alt+h/j/k/l`), fullscreen, and layout
  shortcuts.
- **sketchybar**: Shows workspaces, clock, Wi-Fi, volume, battery, AirPods, and
  focus mode.

After changing service configuration, apply it with `make restart` when the task
calls for updating the running services.
