-- lua/config/options.lua
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true

-- Display / Editing
opt.wrap = false
opt.breakindent = true
opt.cursorline = true
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.showmode = true
-- opt.cmdheight = 0

-- Whitespace / Invisible characters
opt.list = true
opt.listchars = "tab:» ,trail:·,nbsp:␣,extends:›,precedes:‹"

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes:1"

-- Mouse
opt.mouse = "a"

-- Clipboard
-- sudo pacman -S wl-clipboard (Wayland clipboard bridge)
opt.clipboard = "unnamedplus"

-- Split / Windows
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.inccommand = "split"

-- Files
opt.undofile = true
opt.swapfile = false
-- opt.confirm = true
-- opt.path:append("**")

-- Performance / Timing
opt.updatetime = 250
opt.timeout = false
-- opt.timeoutlen = 500

-- Command-line completion (wildmenu)
opt.wildmode = "longest:full,full"
opt.wildmenu = true
opt.wildoptions = "pum"

-- Insert-mode completion / Popup menu
opt.autocomplete = true
opt.autocompletedelay = 200
opt.completeopt = "menu,menuone,noselect,popup"
opt.pumheight = 10
opt.pummaxwidth = 40
-- opt.pumborder = "rounded"

