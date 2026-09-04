-- lua/config/plugins.lua

-- Install pack
vim.pack.add({
  { src = "https://github.com/romus204/tree-sitter-manager.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/OXY2DEV/markview.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = vim.version.range("^0.2"),
  },
  { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
})

-- Setup plugins

-- tree-sitter-manager
require("tree-sitter-manager").setup({
  ensure_installed = { "python", "cpp", "qmljs" },
  auto_install = true,
  highlight = true,
})

-- telescope, telescope-file-browser
local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    layout_strategy = "flex",
    path_display = { "truncate" },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      vertical = { mirror = true },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      grouped = true,
      -- initial_mode = "normal",
      mappings = {
        ["n"] = {
          ["a"] = fb_actions.create,

          ["gR"] = fb_actions.change_cwd,
          ["gr"] = fb_actions.goto_cwd,
          ["gh"] = fb_actions.goto_home_dir,

          ["t"] = fb_actions.toggle_all,

          ["g"] = false,
          ["c"] = false,
          ["e"] = false,
          ["w"] = false,
        },
        ["i"] = {
          ["<A-a>"] = fb_actions.create,

          ["<C-g>R"] = fb_actions.change_cwd,
          ["<C-g>r"] = fb_actions.goto_cwd,
          ["<C-g>h"] = fb_actions.goto_home_dir,

          ["<C-t>"] = fb_actions.toggle_all,

          ["<C-g>"] = false,
          ["<A-c>"] = false,
          ["<C-e>"] = false,
          ["<C-w>"] = false,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

-- Disable autocomplete in telescope
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(ev)
    vim.bo[ev.buf].autocomplete = false
  end,
})

-- nvim-autopairs
require('nvim-autopairs').setup({
  check_ts = true,
})

-- markview
require("markview").setup({
  preview = {
    enable = true,
    enable_hybrid_mode = false,
    -- hybrid_modes = { 'n' },
    -- linewise_hybrid_mode = true,
  }
})

-- gitsigns
require("gitsigns").setup({
  signcolumn = true,
  numhl = false,
  -- official default recommendation
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = "Go to next change"})

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end,  { desc = "Go to prev change" })

    -- Preview
    map('n', '<leader>hp', gitsigns.preview_hunk)
    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
    map('n', '<leader>hq', gitsigns.setqflist)

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>tw', gitsigns.toggle_word_diff)

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk)

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk)
    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)
    map('n', '<leader>hR', gitsigns.reset_buffer)
  end,
})

-- lualine
require("lualine").setup({
  options = {
    theme = 'auto',
    --            
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    globalstatus = true
  },
  sections = {
    lualine_a = {
      { 'mode', padding = { left = 1, right = 1 }, },
      {
        'lsp_status',
        show_name = false,
        icons_enabled = false,
        symbols = {
          spinner = { '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣽', '⣾' },
          done = '⣿',
          separator = '',
        },
        padding = { left = 0, right = 1 },
        fmt = function(str) return vim.trim(str) end,
      },
    },
    lualine_b = { 'branch' },
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {
      { 'diagnostics', padding = { left = 1, right = 1 }},
      { 'diff', padding = { left = 1, right = 1 }},
      { 'encoding', padding = { left = 1, right = 1 }},
    },
    lualine_y = { 'progress' },
    lualine_z = {{ 'location', padding = { left = 1, right = 1 }}}
  },
})
