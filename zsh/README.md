# Zsh Configuration

## Files

| File    | Purpose              |
| ------- | -------------------- |
| `zshrc` | Main Zsh config file |

## Framework

[Oh My Zsh](https://ohmyz.sh/) with theme `gnzh`.

## Plugins

| Plugin                | Purpose                                |
| --------------------- | -------------------------------------- |
| `zsh-autosuggestions` | Fish-style inline command suggestions  |
| `autojump`            | Frecency-based directory jumping (`j`) |
| `sudo`                | Press `Esc` twice to prepend `sudo`    |
| `git`                 | Git aliases and prompt info            |
| `docker-compose`      | Docker Compose aliases and completions |

## Environment

| Variable     | Value            | Purpose                       |
| ------------ | ---------------- | ----------------------------- |
| `EDITOR`     | `vim`            | Default editor                |
| `HISTFILE`   | `~/.zsh_history` | History file location         |
| `HISTSIZE`   | `100000`         | Max history entries in memory |
| `SAVEHIST`   | `100000`         | Max history entries on disk   |
| `PYENV_ROOT` | `~/.pyenv`       | pyenv installation root       |

## Shell Options

| Option             | Effect                                         |
| ------------------ | ---------------------------------------------- |
| `HIST_IGNORE_DUPS` | Skip duplicate consecutive history entries     |
| `SHARE_HISTORY`    | Share history across all active shell sessions |
| `AUTO_CD`          | Change directory by typing its name (no `cd`)  |
| `CORRECT`          | Suggest corrections for mistyped commands      |

## PATH Additions (in order)

1. `~/.local/bin` — user-local binaries
2. `~/.rbenv/bin` — rbenv
3. `~/.pyenv/bin` — pyenv
4. `/opt/homebrew/opt/grep/libexec/gnubin` — GNU grep (overrides macOS grep)
5. `~/.pulumi/bin` — Pulumi CLI

## Version Managers

- **Ruby**: `rbenv` — initialized with `--no-rehash` for faster startup
- **Python**: `pyenv` — initialized for Zsh

## Aliases

| Alias | Expansion    | Purpose                                                |
| ----- | ------------ | ------------------------------------------------------ |
| `ssh` | `kitten ssh` | Use Kitty's SSH kitten for proper terminal integration |

## Runtime Secrets (not tracked)

- `~/.env-secrets` — environment variables and secrets, sourced if present
- `~/.panther-aliases` — work-specific shell aliases, sourced if present
