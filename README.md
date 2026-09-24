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
