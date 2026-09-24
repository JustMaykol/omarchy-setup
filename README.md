# omarchy-setup

Mi configuración personal para una instalación limpia de [Omarchy](https://omarchy.org/).

## Uso

En una PC recién instalada con Omarchy:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/JustMaykol/omarchy-setup/main/omarchy-setup.sh)
```

O clonando el repositorio:

```bash
git clone https://github.com/JustMaykol/omarchy-setup.git
bash omarchy-setup/omarchy-setup.sh
```

Después abre una terminal nueva para cargar los aliases.

Se puede ejecutar varias veces: los cambios en `~/.bashrc` e `input.lua` van entre las marcas
`>>> omarchy-setup >>>` y `<<< omarchy-setup <<<`, y se reemplazan en vez de duplicarse.

## Qué hace

**`~/.bashrc`**
- `eff` mejorado: no abre el editor si cancelas la búsqueda.
- Quita aliases de Omarchy que no uso: `a c cx cy d r t h ic ix icx mup gcam gcad`.
- Quita funciones de Omarchy que no uso: `sff n iso2sd format-drive hdl hds hdlm hsl tdl tds tdlm tsl rsw lsw dsw fip dip lip ga gd`.
- Añade `ga` = `git add` y `gp` = `git push`.

**`~/.config/hypr/input.lua`**
- Caps Lock vuelve a funcionar normal; la tecla Compose pasa a Alt derecho.

**`~/.config/herdr/config.toml`**
- Vuelve a los atajos oficiales de herdr (quita los estilo tmux de Omarchy). El tema y la UI de
  Omarchy se mantienen, y se guarda un backup `config.toml.bak-keybind-*`.

**Paquetes**
- Desinstala `omarchy-nvim`, `neovim` y `tmux`.
- Quita `codex` de mise.
- Borra la configuración sobrante de Neovim, tmux y Codex.

## Aliases que quedan

| Alias | Comando |
|---|---|
| `ls` `lsa` `lt` `lta` | listados con `eza` |
| `ff` / `eff` | buscar archivos con `fzf` / abrirlos en el editor |
| `cd` | `cd` + zoxide |
| `open` | `xdg-open` |
| `..` `...` `....` | subir carpetas |
| `g` `ga` `gcm` `gp` | `git`, `git add`, `git commit -m`, `git push` |
| `compress` / `decompress` | `tar.gz` |
| `ssh` | `ssh` con reconexión automática |

## Atajos de herdr

`prefix` = `ctrl+b`: se pulsa, se suelta y luego la tecla. Workspace = "space", tab = ventana,
pane = cada división dentro de una tab. `prefix ?` muestra todos los atajos.

**Workspaces**

| Acción | Atajo |
|---|---|
| Crear | `prefix` `shift+n` |
| Cerrar | `prefix` `shift+d` |
| Renombrar | `prefix` `shift+w` |
| Cambiar | `prefix` `w` (selector: `↑`/`↓` y `Enter`) |

**Tabs**

| Acción | Atajo |
|---|---|
| Crear | `prefix` `c` |
| Cerrar | `prefix` `shift+x` |
| Renombrar | `prefix` `shift+t` |
| Anterior / siguiente | `prefix` `p` / `prefix` `n` |
| Ir a la tab 1–9 | `prefix` `1`…`9` |

**Panes**

| Acción | Atajo |
|---|---|
| Dividir lado a lado | `prefix` `v` |
| Dividir arriba/abajo | `prefix` `-` |
| Cerrar | `prefix` `x` |
| Moverse | `prefix` `h` `j` `k` `l` |
| Siguiente / anterior | `prefix` `tab` / `prefix` `shift+tab` |
| Intercambiar posición | `prefix` `shift+h/j/k/l` |
| Maximizar / restaurar | `prefix` `z` |
| Cambiar tamaño | `prefix` `r`, flechas, `Esc` |
| Renombrar | `prefix` `shift+p` |

**Otros**

| Acción | Atajo |
|---|---|
| Ver todos los atajos | `prefix` `?` |
| Salir sin cerrar nada (detach) | `prefix` `q` (se vuelve con `herdr`) |
| Modo copia | `prefix` `[` |
| Abrir el historial del pane en el editor | `prefix` `e` |
| Ir a la última notificación | `prefix` `o` |
| Mostrar / ocultar barra lateral | `prefix` `b` |
| Buscador de sesiones | `prefix` `g` |
| Ajustes | `prefix` `s` |
| Recargar config | `prefix` `shift+r` |
