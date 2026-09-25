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

**Default editor**
- Sets VS Code as the default editor (installs it with `omarchy install editor vscode` if missing):
  `$EDITOR` (so `eff` opens files in VS Code), git's `core.editor` (`code --wait`), and the file
  manager's handler for text, Markdown, scripts, JSON, YAML, TOML and similar files.

**Default browser**
- Installs Brave Origin (if missing) and sets it as the default browser.

**Omarchy shell plugins** (`~/.config/omarchy/plugins`)
- Installs `cava` (OmaSpotify's equalizer) and `qt6-multimedia` (video designs in Lock Screen Explorer).
- Installs and enables (skips the ones already installed):
  - [Activity Monitor](https://github.com/stappmus/omarchy-activity-monitor)
  - [Lock Screen Explorer](https://github.com/SirJul1337/omarchy-lock-explorer)
  - [OmaSpotify](https://github.com/jeremylanger/omaspotify)
  - [Omasing](https://github.com/stappmus/Omasing)
  - [Screen Time](https://github.com/ax1g/quickshell-screentime-plugin)
  - [Workspace Apps](https://github.com/elixirblend/omarchy-workspace-apps)
- Keeps these built-in Omarchy plugins enabled: Audio, Background, Bar, Bluetooth, Clipboard, Clock,
  Dev gallery, Disk speed test, Emojis, Idle, Image picker, Keyboard layout, Network, Night Light,
  Notifications, Omarchy menu, Omarchy update, Polkit Agent, Power, Reminders, Speed Test,
  System tray, Weather, Wi-Fi QR.
- Disables the rest: Active window, Agents, Battery, Display, Dropbox, Indicators, Lock Screen
  (replaced by Lock Screen Explorer), Media, Microphone, On-screen display, Spacer, Tailscale,
  Workspaces (replaced by Workspace Apps).
- Keeps the bar at the top of the screen.

**Theme**
- Installs and applies the [Saga](https://github.com/HANCORE-linux/omarchy-saga-theme) theme (only the
  first time, so a theme chosen later isn't overwritten).

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
