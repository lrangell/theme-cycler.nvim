# theme-cycler.nvim

A plugin to quickly cycle between your themes and persist the desired one across vim sessions without touching your config.

![demo](https://user-images.githubusercontent.com/11699033/210461674-61f98c11-4b92-49ab-a748-f0f7847f3b46.gif)

## Installation

Via [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use 'lrangell/theme-cycler.nvim'
```

## Configuration

By default it shows all themes except for the built-in ones, you can disable that and blacklist additional themes via the setup function.

```lua
require"themeCycler".setup({blacklist = {"minicyan", "minischeme"}, blacklist_default = true})
```

## Usage

Simply call the open function to show the popup, it will change the current theme on cursor move,
press return to save the selected theme and it will restore when vim starts.

```lua
require"themeCycler".open()
```

You can also map using:

```lua
vim.keymap.set("n", "<space>t", require"themeCycler".open_lazy)
```

Require the plugins on neovim startup to restore the saved theme.

```lua
require"themeCycler"
```
