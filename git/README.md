# Git Configuration

## Files

| File              | Purpose                                    |
| ----------------- | ------------------------------------------ |
| `config`          | Global git settings                        |
| `config-panther`  | Work overrides (email + SSH signing)       |
| `allowed_signers` | Trusted SSH public keys for commit signing |
| `ignore`          | Global gitignore patterns                  |
| `gitk`            | gitk GUI preferences                       |

## Identity

- **Name**: Panos Sakkos
- **Email**: panos.sakkos@gmail.com (personal default)
- **Work email**: panos.sakkos@panther.com (applied via `includeIf` for `~/dev/panther/`)

## Workflow Settings

| Setting                | Value    | Effect                                           |
| ---------------------- | -------- | ------------------------------------------------ |
| `pull.rebase`          | `true`   | Rebase instead of merge on pull                  |
| `push.default`         | `simple` | Push current branch to its upstream              |
| `push.autoSetupRemote` | `true`   | Auto-create remote tracking branch on first push |
| `push.followTags`      | `true`   | Push annotated tags along with commits           |
| `fetch.prune`          | `true`   | Remove stale remote-tracking branches on fetch   |
| `fetch.pruneTags`      | `true`   | Remove stale remote-tracking tags on fetch       |
| `fetch.all`            | `true`   | Fetch from all remotes                           |
| `init.defaultBranch`   | `main`   | New repos start on `main`                        |
| `help.autocorrect`     | `prompt` | Prompt before running autocorrected command      |

## Diff Settings

| Setting               | Value       | Effect                                    |
| --------------------- | ----------- | ----------------------------------------- |
| `diff.algorithm`      | `histogram` | Better diff output for refactored code    |
| `diff.colorMoved`     | `plain`     | Highlight moved lines in a distinct color |
| `diff.mnemonicPrefix` | `true`      | Use `i/w/c/o` prefixes instead of `a/b`   |
| `diff.renames`        | `true`      | Detect renamed files in diffs             |

## Display & Sorting

- Branches sorted by most recent committer date (`-committerdate`)
- Tags sorted by version (`version:refname`)
- Column UI set to `auto`

## Commit Signing (Work Only)

Commits in `~/dev/panther/` are signed via SSH using 1Password:

- **Format**: SSH
- **Signing key**: ed25519 key managed by 1Password (`op-ssh-sign`)
- **Allowed signers file**: `allowed_signers` in this directory
- Signing is **not** applied to personal repositories

## Global Gitignore

Ignores `**/.claude/settings.local.json` across all repositories.
