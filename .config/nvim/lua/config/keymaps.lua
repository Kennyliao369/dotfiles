-- lua/config/keymaps.lua

local map = vim.keymap.set

--leader key
map("n", "<Space>", "<Nop>", { desc = "leader nop" })

-- Search
map("n", "<Esc>", "<CMD>noh<CR>", { desc = "Clear search highlight" })

-- Undo / Redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Live grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Help tags" })
map("n", "<leader>fd", function() require("telescope.builtin").diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>fr", function() require("telescope.builtin").resume() end, { desc = "Resume last picker" })

-- telescope-file-browser
map("n", "<leader>e", function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    select_buffer = true,
  })
end, { desc = "File browser (dir of current file)" })

-- markview
vim.keymap.set('n', '<leader>mt', '<cmd>Markview toggle<cr>', { desc = 'Markview toggle' })
vim.keymap.set('n', '<leader>ms', '<cmd>Markview splitToggle<cr>', { desc = 'Markview splitToggle' })
vim.keymap.set('n', '<leader>mh', '<cmd>Markview hybridToggle<cr>', { desc = 'Markview hybridToggle' })
