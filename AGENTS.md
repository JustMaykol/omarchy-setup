# omarchy-setup

Mi configuración personal para una instalación limpia de [Omarchy](https://omarchy.org/) (Arch +
Hyprland). Todo vive en un solo script, `omarchy-setup.sh`, que se ejecuta en una máquina recién
instalada (o en esta misma, para aplicar cambios). El README documenta qué hace cada paso.

## Archivos

- `omarchy-setup.sh`: el script. Una sección por paso, separadas por `# ----` y anunciadas con
  `step "..."`.
- `README.md`: qué hace el script, aliases que quedan y atajos de herdr.

## Reglas del script

- **Idempotente**: se puede ejecutar muchas veces sin duplicar ni romper nada.
  - Cambios en archivos de config del usuario (`~/.bashrc`, `input.lua`) van con `write_block`,
    entre los marcadores `>>> omarchy-setup >>>` / `<<< omarchy-setup <<<`, que se reemplazan.
  - Instalar solo si falta (`command -v ... ||`, `pacman -S --needed`, `plugin_installed`), porque
    algunos instaladores de Omarchy sobrescriben configuración (p. ej. `settings.json` de VS Code).
  - Lo que el usuario puede cambiar después (como el tema) se aplica solo la primera vez.
- Si una herramienta no está instalada, el paso lo dice y sigue (`echo "X no está instalado, nada
  que hacer."`); cada paso termina con `echo "Listo."` o un mensaje equivalente.
- Usar los comandos de Omarchy (`omarchy install`, `omarchy default`, `omarchy plugin`,
  `omarchy theme`, `omarchy bar`) en vez de editar sus archivos a mano cuando existan. Para
  personalizaciones que Omarchy no expone, usar sus hooks (`~/.config/omarchy/hooks/*.d/`).
- `set -euo pipefail`: los comandos que pueden fallar sin problema llevan `|| true` o `2>/dev/null`.
- Bash, indentación de 2 espacios, comentarios breves en español explicando el *porqué*.

## Convenciones del repo

- Comentarios del script y mensajes de commit: **español**. README: **inglés**.
- Cada cambio en el script se refleja en la sección correspondiente del README (misma organización
  por secciones en negrita). Si se quita/agrega un alias, actualizar también la tabla de aliases.
- Commits: título corto en español, en imperativo o descriptivo (p. ej. "Brave Origin como
  navegador por defecto"), con cuerpo en viñetas si hay varios cambios.
- Tras modificar el script, verificar sintaxis con `bash -n omarchy-setup.sh` (y `shellcheck` si
  está disponible). Antes de ejecutarlo en esta máquina, preguntar: usa `sudo pacman` y borra
  configuración (`rm -rf` de nvim, tmux, codex).

## Contexto de la máquina

- Esta es mi máquina con Omarchy (Surface, kernel `linux-surface`). La config de Hyprland es Lua
  (`~/.config/hypr/*.lua`, API `hl.config`).
- Editor: VS Code. Navegador: Brave Origin. Multiplexor: herdr (no tmux). Tema: Saga.
- No uso Neovim, tmux ni Codex: el script los desinstala.
