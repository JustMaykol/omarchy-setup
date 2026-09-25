#!/bin/bash
# Configuración personal para una instalación limpia de Omarchy.
# Se puede ejecutar varias veces sin duplicar nada.
#
# Uso: bash ~/omarchy-setup.sh

set -euo pipefail

BASHRC="$HOME/.bashrc"
INPUT_LUA="$HOME/.config/hypr/input.lua"

# Escribe un bloque entre marcadores; si ya existe, lo reemplaza
write_block() {
  local file="$1" comment="$2" content="$3"
  local start="$comment >>> omarchy-setup >>>"
  local end="$comment <<< omarchy-setup <<<"

  touch "$file"
  sed -i "/^$comment >>> omarchy-setup >>>$/,/^$comment <<< omarchy-setup <<<$/d" "$file"
  # Quitar líneas en blanco al final para no acumularlas en cada ejecución
  sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$file"
  printf '\n%s\n%s\n%s\n' "$start" "$content" "$end" >>"$file"
}

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }

# ---------------------------------------------------------------------------
step "Aliases y funciones en ~/.bashrc"

write_block "$BASHRC" "#" "$(cat <<'EOF'
# eff: solo abre el editor si se eligió un archivo (no al cancelar)
unalias eff 2>/dev/null
eff() { local f; f=$(ff) && [ -n "$f" ] && $EDITOR "$f"; }

# Aliases de Omarchy que no uso
unalias a c cx cy d r t h ic ix icx mup gcam gcad 2>/dev/null

# Funciones de Omarchy que no uso
unset -f sff n iso2sd format-drive hdl hds hdlm hsl _herdr_ratio _herdr_split tdl tds tdlm tsl rsw lsw dsw fip dip lip ga gd 2>/dev/null

# Git
alias ga='git add'
alias gp='git push'
EOF
)"
echo "Listo."

# ---------------------------------------------------------------------------
step "Caps Lock normal, Compose en Alt derecho (~/.config/hypr/input.lua)"

write_block "$INPUT_LUA" "--" "$(cat <<'EOF'
-- Compose en Alt derecho (en vez de Caps Lock), para que Caps Lock funcione normal.
hl.config({
  input = {
    kb_options = "compose:ralt,shift:both_capslock_cancel",
  },
})
EOF
)"

if [[ -n ${HYPRLAND_INSTANCE_SIGNATURE:-} ]] && command -v hyprctl &>/dev/null; then
  hyprctl reload >/dev/null
  errors=$(hyprctl configerrors)
  if [[ -n ${errors//[[:space:]]/} ]]; then
    echo "Hyprland reporta errores:"
    echo "$errors"
  else
    echo "Listo (Hyprland recargado sin errores)."
  fi
else
  echo "Listo (se aplicará al iniciar Hyprland)."
fi

# ---------------------------------------------------------------------------
step "Atajos oficiales de herdr (~/.config/herdr/config.toml)"

HERDR_CONFIG="$HOME/.config/herdr/config.toml"

if ! command -v herdr &>/dev/null; then
  echo "herdr no está instalado, nada que hacer."
elif [[ -f $HERDR_CONFIG ]] && grep -qE '^\[\[?keys[].]' "$HERDR_CONFIG"; then
  # Quita los atajos estilo tmux de Omarchy (deja un backup); el tema y la UI se mantienen
  herdr config reset-keys
  herdr server reload-config &>/dev/null || true
  echo "Listo."
else
  echo "Ya usa los atajos oficiales."
fi

# ---------------------------------------------------------------------------
step "VS Code como editor por defecto"

# Solo se instala si falta: el instalador de Omarchy sobrescribe settings.json de VS Code
command -v code &>/dev/null || omarchy install editor vscode

# $EDITOR (omarchy-launch-editor) abre el editor elegido aquí
omarchy default editor code

# git necesita --wait para esperar a que se cierre el archivo del commit
git config --global core.editor "code --wait"

# Abrir archivos de texto con VS Code desde el explorador de archivos
xdg-mime default code.desktop \
  text/plain text/markdown text/x-shellscript application/x-shellscript application/json \
  application/toml text/x-toml application/yaml text/x-yaml text/x-log text/csv application/xml \
  text/x-python text/x-csrc text/x-chdr text/css
echo "Listo."

# ---------------------------------------------------------------------------
step "Brave Origin como navegador por defecto"

# Solo se instala si falta: el instalador de Omarchy sobrescribe brave-origin-flags.conf
command -v brave-origin &>/dev/null || omarchy install browser brave-origin
omarchy default browser brave-origin
echo "Listo."

# ---------------------------------------------------------------------------
step "Dependencias de los plugins (cava, qt6-multimedia)"

# cava: ecualizador de OmaSpotify. qt6-multimedia: videos en Lock Screen Explorer.
sudo pacman -S --needed --noconfirm cava qt6-multimedia
echo "Listo."

# ---------------------------------------------------------------------------
step "Plugins del shell de Omarchy (~/.config/omarchy/plugins)"

PLUGINS_DIR="$HOME/.config/omarchy/plugins"
PLUGINS=(
  https://github.com/stappmus/omarchy-activity-monitor.git   # Activity Monitor
  https://github.com/SirJul1337/omarchy-lock-explorer.git     # Lock Screen Explorer
  https://github.com/jeremylanger/omaspotify.git              # OmaSpotify
  https://github.com/stappmus/Omasing.git                     # Omasing
  https://github.com/ax1g/quickshell-screentime-plugin.git    # Screen Time
  https://github.com/elixirblend/omarchy-workspace-apps.git   # Workspace Apps
)

# El id del plugin sale de su manifest, así que se detecta si ya está instalado por su repo
plugin_installed() {
  local url="${1%.git}" dir remote
  for dir in "$PLUGINS_DIR"/*/; do
    remote=$(git -C "$dir" remote get-url origin 2>/dev/null) || continue
    [[ ${remote%.git} == "$url" ]] && return 0
  done
  return 1
}

if ! command -v omarchy &>/dev/null; then
  echo "omarchy no está instalado, nada que hacer."
else
  for url in "${PLUGINS[@]}"; do
    if plugin_installed "$url"; then
      echo "Ya instalado: $url"
    else
      omarchy plugin add "$url" --enable --yes
    fi
  done
  echo "Listo."
fi

# ---------------------------------------------------------------------------
step "Plugins de Omarchy: activar los que uso, desactivar el resto"

PLUGINS_ENABLED=(
  audio background bar bluetooth clipboard clock dev-gallery disk-speedtest emojis idle
  image-picker keyboard-layout menu network nightlight notifications polkit power reminders
  speedtest system-update tray weather wifiqr
)
# lock y workspaces los reemplazan Lock Screen Explorer y Workspace Apps
PLUGINS_DISABLED=(
  active-window agents battery dropbox indicators lock media microphone monitor osd spacer
  tailscale workspaces
)

if ! command -v omarchy &>/dev/null; then
  echo "omarchy no está instalado, nada que hacer."
else
  for id in "${PLUGINS_ENABLED[@]}"; do omarchy plugin enable "omarchy.$id" >/dev/null; done
  for id in "${PLUGINS_DISABLED[@]}"; do omarchy plugin disable "omarchy.$id" >/dev/null; done
  omarchy bar position top >/dev/null
  echo "Listo."
fi

# ---------------------------------------------------------------------------
step "Tema Saga"

# Hook: con Saga, VS Code usa el tema del repo de Saga en vez del que genera Omarchy
SAGA_HOOK="$HOME/.config/omarchy/hooks/theme-set.d/vscode-saga"
mkdir -p "$(dirname "$SAGA_HOOK")"
cat >"$SAGA_HOOK" <<'HOOK'
#!/bin/bash
# Con el tema Saga, usar en VS Code el tema del repo de Saga en vez del que genera Omarchy.
# Omarchy ignora el tema de VS Code de los temas instalados desde git.

[[ $1 == saga ]] || exit 0
command -v code &>/dev/null || exit 0

src="$HOME/.config/omarchy/themes/saga/vscode-extension"
ext_base="$HOME/.vscode/extensions"
ext_dir="$ext_base/local.theme-saga-1.0.0"
settings="$HOME/.config/Code/User/settings.json"
[[ -d $src && -f $settings ]] || exit 0

# Instalar la extensión como local (VS Code solo carga temas desde extensiones)
mkdir -p "$ext_dir"
cp -r "$src/." "$ext_dir/"

extensions_file="$ext_base/extensions.json"
[[ -f $extensions_file ]] || printf '[]\n' >"$extensions_file"
tmp=$(mktemp)
if jq --arg path "$ext_dir" --arg rel "$(basename "$ext_dir")" '
  map(select(.identifier.id != "local.theme-saga")) + [{
    identifier: { id: "local.theme-saga" },
    version: "1.0.0",
    location: { "$mid": 1, fsPath: $path, external: ("file://" + $path), path: $path, scheme: "file" },
    relativeLocation: $rel
  }]' "$extensions_file" >"$tmp"; then
  mv "$tmp" "$extensions_file"
else
  rm -f "$tmp"
fi

sed -i --follow-symlinks -E \
  's|("workbench.colorTheme"[[:space:]]*:[[:space:]]*")[^"]*(")|\1Saga\2|' "$settings"
HOOK
chmod +x "$SAGA_HOOK"

# Solo se instala (y aplica) la primera vez, para no pisar el tema si luego lo cambio
if ! command -v omarchy &>/dev/null; then
  echo "omarchy no está instalado, nada que hacer."
elif [[ -d $HOME/.config/omarchy/themes/saga ]]; then
  # Si Saga ya es el tema actual, aplicar el hook ahora
  [[ $(omarchy theme current) == Saga ]] && "$SAGA_HOOK" saga
  echo "Ya instalado."
else
  omarchy theme install https://github.com/HANCORE-linux/omarchy-saga-theme.git
  echo "Listo."
fi

# ---------------------------------------------------------------------------
step "Desinstalar Neovim y tmux"

to_remove=()
for pkg in omarchy-nvim neovim tmux; do
  pacman -Qq "$pkg" &>/dev/null && to_remove+=("$pkg")
done

if (( ${#to_remove[@]} )); then
  sudo pacman -Rns --noconfirm "${to_remove[@]}"
else
  echo "Ya estaban desinstalados."
fi

# ---------------------------------------------------------------------------
step "Quitar Codex de mise"

if command -v mise &>/dev/null; then
  mise unuse -g codex 2>/dev/null || true
  mise uninstall --all codex 2>/dev/null || true
  echo "Listo."
else
  echo "mise no está instalado, nada que hacer."
fi

# ---------------------------------------------------------------------------
step "Borrar configuración sobrante de Neovim, tmux y Codex"

rm -rf \
  "$HOME/.config/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim" \
  "$HOME/.config/tmux" \
  "$HOME/.codex"
echo "Listo."

# ---------------------------------------------------------------------------
printf '\n\033[1;32m✔ Configuración aplicada.\033[0m Abre una terminal nueva o ejecuta: source ~/.bashrc\n'
