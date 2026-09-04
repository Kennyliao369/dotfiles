-- init.lua
-- Neovim 0.12

-- theme
vim.cmd.colorscheme("habamax")

-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.plugins")
require("config.lsp")

