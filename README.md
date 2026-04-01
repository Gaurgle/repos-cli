# repos

See what changed across your repos since you last sat down.

If you work on multiple projects and switch between machines — a work laptop and a home setup, say — you know the feeling. You sit down, and you're not sure which repos have new commits you need to pull, which ones you forgot to push last night, or where you left uncommitted work.

`repos` gives you that overview in one command. It checks GitHub, compares with what you have locally, and shows you the status of everything that's been active recently. That's it. No setup, no config files, no background processes. Just a bash script, `gh`, and `jq`.

It's fast because it doesn't check every repo you own — it asks GitHub which repos were recently pushed to, then only fetches those.

## Examples

**Default mode** — shows repos active in the latest time slot:

```
repos — latest active slot: 2026-03-31  Evening (18-00)

  frontend-app ·································· 2 behind
    ~/repos/acme/frontend-app
      a1b2c3d feat: add dark mode toggle
      e4f5g6h fix: navbar responsive breakpoint
  backend-api ··································· synced
    ~/repos/acme/backend-api
      d7e8f9a refactor: extract auth middleware
  mobile-app ···································· 1 ahead
    ~/repos/acme/mobile-app
      b2c3d4e feat: push notification support

  also active (elsewhere):
    docs ········································ 1 behind
      ~/work/docs
        c5d6e7f docs: update API reference

  local changes:
    infra ···································· 2 uncommitted
      ~/repos/acme/infra

  ──────────────────────────────
  1 behind · 1 synced · 1 ahead · 1 uncommitted
```

**All synced** — nothing to do:

```
repos — latest active slot: 2026-04-01  Work (09-18)

  webapp ········································ synced
    ~/repos/webapp
      f8a9b0c feat: add user preferences page
  cli-tool ······································ synced
    ~/repos/cli-tool
      a3b4c5d fix: handle empty config file

  ──────────────────────────────
  2 synced
```

**Using `--since`** — activity since a specific date:

```
repos — since 2026-03-25

  webapp ········································ synced
    ~/repos/webapp
      f8a9b0c feat: add user preferences page
  cli-tool ······································ 3 behind
    ~/repos/cli-tool
      d1e2f3a feat: streaming output
      b4c5d6e refactor: plugin system
      a7b8c9d fix: windows path handling
  design-system ································ 1 ahead
    ~/repos/design-system
      e0f1a2b feat: new color tokens

  ──────────────────────────────
  1 behind · 1 synced · 1 ahead
```

## Installation

```bash
git clone https://github.com/Gaurgle/repos-cli.git
cd repos-cli
./install.sh
```

This copies `repos` to `~/.local/bin/` and verifies dependencies. To install elsewhere:

```bash
./install.sh /usr/local/bin
```

Or just copy it manually:

```bash
cp repos ~/.local/bin/repos
chmod +x ~/.local/bin/repos
```

## Usage

```
repos [options]
```

| Flag | Description |
|---|---|
| *(default)* | Find the latest time slot with activity and show those repos |
| `--since DATE` | Show all activity since `DATE` (e.g. `2026-03-15`) |
| `--today` | Show all activity since midnight |
| `--all` | Show all divergence, no time filter |
| `-v` | Also list repos not cloned locally |
| `-h, --help` | Show help |

By default, `repos` searches for local clones under the current directory. Set `REPO_CHECK_DIR` to override:

```bash
REPO_CHECK_DIR=~/code repos
```

## Time slots

The default mode groups GitHub push activity into time slots to show only what's relevant to your current session:

| Slot | Hours |
|---|---|
| Work | 09:00 – 18:00 |
| Evening | 18:00 – 00:00 |
| Night | 00:00 – 09:00 |

It picks the most recent slot with any activity. If you pushed code at work and now you're home, it shows what happened during that work session.

## Output sections

| Section | What it shows |
|---|---|
| **Main list** | Repos with GitHub activity found under your current directory |
| **Also active (elsewhere)** | Same repos found in other locations on your machine (e.g. `~/work` vs `~/repos`) |
| **Local changes** | Repos under your current directory with uncommitted files or unpushed commits, even if they had no recent GitHub activity |

## Requirements

- **bash**
- **[gh](https://cli.github.com/)** — GitHub CLI, authenticated (`gh auth login`)
- **[jq](https://jqlang.github.io/jq/)** — JSON processor
- **git**

## License

[MIT](LICENSE)
