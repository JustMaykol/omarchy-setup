# omarchy-setup

My personal setup for a clean [Omarchy](https://omarchy.org/) install.

## Usage

On a freshly installed Omarchy machine:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/JustMaykol/omarchy-setup/main/omarchy-setup.sh)
```

Or by cloning the repository:

```bash
git clone https://github.com/JustMaykol/omarchy-setup.git
bash omarchy-setup/omarchy-setup.sh
```

Then open a new terminal to load the aliases.

It can be run multiple times: changes to `~/.bashrc` and `input.lua` go between the
`>>> omarchy-setup >>>` and `<<< omarchy-setup <<<` markers and are replaced instead of duplicated.

## What it does

**`~/.bashrc`**
- Improved `eff`: doesn't open the editor if you cancel the search.
- Removes Omarchy aliases I don't use: `a c cx cy d r t h ic ix icx mup gcam gcad`.
- Removes Omarchy functions I don't use: `sff n iso2sd format-drive hdl hds hdlm hsl tdl tds tdlm tsl rsw lsw dsw fip dip lip ga gd`.
- Adds `ga` = `git add` and `gp` = `git push`.

**`~/.config/hypr/input.lua`**
- Caps Lock works normally again; the Compose key moves to Right Alt.

**`~/.config/herdr/config.toml`**
- Restores herdr's official keybindings (removes Omarchy's tmux-style ones). Omarchy's theme and UI
  are kept, and a `config.toml.bak-keybind-*` backup is saved.

**Packages**
- Uninstalls `omarchy-nvim`, `neovim` and `tmux`.
- Removes `codex` from mise.
- Deletes leftover Neovim, tmux and Codex configuration.

## Remaining aliases

| Alias | Command |
|---|---|
| `ls` `lsa` `lt` `lta` | listings with `eza` |
| `ff` / `eff` | find files with `fzf` / open them in the editor |
| `cd` | `cd` + zoxide |
| `open` | `xdg-open` |
| `..` `...` `....` | go up directories |
| `g` `ga` `gcm` `gp` | `git`, `git add`, `git commit -m`, `git push` |
| `compress` / `decompress` | `tar.gz` |
| `ssh` | `ssh` with automatic reconnection |

## herdr keybindings

`prefix` = `ctrl+b`: press it, release it, then press the key. Workspace = "space", tab = window,
pane = each split inside a tab. `prefix ?` shows all keybindings.

**Workspaces**

| Action | Keybinding |
|---|---|
| Create | `prefix` `shift+n` |
| Close | `prefix` `shift+d` |
| Rename | `prefix` `shift+w` |
| Switch | `prefix` `w` (picker: `↑`/`↓` and `Enter`) |

**Tabs**

| Action | Keybinding |
|---|---|
| Create | `prefix` `c` |
| Close | `prefix` `shift+x` |
| Rename | `prefix` `shift+t` |
| Previous / next | `prefix` `p` / `prefix` `n` |
| Go to tab 1–9 | `prefix` `1`…`9` |

**Panes**

| Action | Keybinding |
|---|---|
| Split side by side | `prefix` `v` |
| Split top/bottom | `prefix` `-` |
| Close | `prefix` `x` |
| Move | `prefix` `h` `j` `k` `l` |
| Next / previous | `prefix` `tab` / `prefix` `shift+tab` |
| Swap position | `prefix` `shift+h/j/k/l` |
| Maximize / restore | `prefix` `z` |
| Resize | `prefix` `r`, arrows, `Esc` |
| Rename | `prefix` `shift+p` |

**Other**

| Action | Keybinding |
|---|---|
| Show all keybindings | `prefix` `?` |
| Leave without closing anything (detach) | `prefix` `q` (come back with `herdr`) |
| Copy mode | `prefix` `[` |
| Open the pane history in the editor | `prefix` `e` |
| Go to the latest notification | `prefix` `o` |
| Show / hide sidebar | `prefix` `b` |
| Session picker | `prefix` `g` |
| Settings | `prefix` `s` |
| Reload config | `prefix` `shift+r` |
