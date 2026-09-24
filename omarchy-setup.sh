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
