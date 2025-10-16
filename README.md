# icinga2-nvim

Modern Neovim plugin providing syntax highlighting and filetype detection for Icinga 2 configuration files.

## Features

- Native Neovim filetype detection (Lua)
- Full syntax highlighting (Vimscript syntax file)
- Configurable custom paths for non-standard installations
- Easy install via plugin managers or manual clone

## Installation

### Using lazy.nvim

```lua
{
  "tolecnal/icinga2-nvim",
  config = function()
  require("icinga2-nvim").setup()
  end,
}
```

### Using packer.nvim

```lua
use({
  "tolecnal/icinga2-nvim",
  config = function()
  require("icinga2-nvim").setup()
  end,
})
```

### Manual

Clone into your runtime path:

```bash
git clone https://github.com/tolecnal/icinga2-nvim ~/.local/share/nvim/site/pack/plugins/start/icinga2-nvim
```

## Usage

Open an Icinga 2 configuration file (e.g. `/etc/icinga2/icinga2.conf`) and verify:

```vim
:set filetype?
```

You should see `filetype=icinga2` and syntax highlighting should apply.

## Configuration

### Default Paths

By default, the plugin detects Icinga 2 configuration files in these locations:

- `/etc/icinga2/*.conf`
- `/usr/share/icinga2/include/itl/*.conf`
- `/usr/share/icinga2/include/plugins/*.conf`
- `/usr/share/icinga2/include/*.conf`

### Custom Paths

If you have Icinga 2 installed in non-standard locations, you can add custom paths:

```lua
require("icinga2-nvim").setup({
  custom_paths = {
    "/opt/icinga2/*.conf",
    "/home/user/icinga2-configs/*.conf",
    "~/my-monitoring/*.conf",
  }
})
```
