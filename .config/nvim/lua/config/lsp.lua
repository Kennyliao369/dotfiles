-- lua/config/lsp.lua

vim.lsp.enable({ "pyright", "clangd", "lua_ls" })

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  float = { border = "rounded", source = "if_many" },

--  virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
--  virtual_lines = { current_line = true },
--  signs = {
--    text = {
--      [vim.diagnostic.severity.ERROR] = "E",
--      [vim.diagnostic.severity.WARN]  = "W",
--      [vim.diagnostic.severity.INFO]  = "I",
--      [vim.diagnostic.severity.HINT]  = "H",
--    },
--  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- LSP function key
    local function lspmap(method, mode, lhs, rhs, desc)
      if client:supports_method(method) then
        vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
      end
    end

--    lspmap("textDocument/formatting", "n", "<leader>f", function()
--      vim.lsp.buf.format({ async = true })
--    end, "Formatting")


    -- Enable auto-completion
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end

  end,
})

