local M = {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup({
          ui = {
            border = "single",
          },
        })
      end,
    },
    "williamboman/mason-lspconfig.nvim",
  },
  event = "BufReadPre",
}

local server = {
  ts = "tsserver",
  deno = "denols",
  lua = "lua_ls",
  eslint = "eslint",
  go = "gopls",
  json = "jsonls",
  yaml = "yamlls",
}

function M.config()
  local lsp = require "lsp-zero"

  lsp.preset "recommended"

  local install_servers = {}
  for k, v in pairs(server) do
    table.insert(install_servers, v)
  end

  lsp.ensure_installed(install_servers)

  lsp.set_preferences({
    manage_nvim_cmp = false, -- managed in ./cmp.lua
    suggest_lsp_servers = true,
    sign_icons = {
      error = "•",
      warn = "•",
      hint = "•",
      info = "•",
    },
  })

  vim.diagnostic.config({
    virtual_text = false,
  })

  -- LSP server configurations
  local lspconfig = require "lspconfig"
  lsp.configure(server.lua, require "user.lsp.settings.luals")
  lsp.configure(server.json, require "user.lsp.settings.jsonls")
  lsp.configure(server.ts, {
    root_dir = lspconfig.util.root_pattern "package.json",
    single_file_support = false,
    init_options = {
      lint = false,
      format = false,
    },
  })
  lsp.configure(server.deno, {
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.lock"),
    init_options = {
      lint = false,
    },
  })
  lspconfig.eslint.setup({
    root_dir = lspconfig.util.root_pattern(".eslintrc.json", ".eslintrc.js", "package.json", "tsconfig.json", ".git"),
    settings = {
      format = false,
    },
  })
  lsp.configure(server.yaml, {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  })

  -- Keymaps
  lsp.on_attach(function(client, bufnr)
    -- Handle tsserver and denols
    if lspconfig.util.root_pattern "deno.json" (vim.fn.getcwd()) then
      if client.name == "tsserver" then
        client.stop()
        return
      end
    end

    -- KEYMAPS
    local function setBufOpts(desc)
      return { noremap = true, silent = true, buffer = bufnr, desc = desc }
    end

    local keymap = vim.keymap.set

    keymap("n", "gD", vim.lsp.buf.declaration, setBufOpts "Jump to declaration")
    keymap("n", "gd", vim.lsp.buf.definition, setBufOpts "Jump to definition")
    keymap("n", "gh", vim.lsp.buf.hover, setBufOpts "Hover")
    --keymap("n", "gI", vim.lsp.buf.implementation, setBufOpts "Implementation")
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, setBufOpts "Signature help")
    keymap("n", "gr", vim.lsp.buf.references, setBufOpts "Find references")
    keymap("n", "<F2>", vim.lsp.buf.rename, setBufOpts "Rename")
    keymap("n", "[d", function()
      vim.diagnostic.goto_prev({ border = "single" })
    end, setBufOpts "Jump to previous diagnostic")
    keymap("n", "gl", function()
      vim.diagnostic.open_float({ border = "single" })
    end, setBufOpts "Open diagnostics")
    keymap("n", "]d", function()
      vim.diagnostic.goto_next({ border = "single" })
    end, setBufOpts "Jump to next diagnostic")

    -- FORMAT ON SAVE
    if client.supports_method "textDocument/formatting" then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          local ft = vim.bo[bufnr].filetype
          local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(buf_client)
              -- Disable tsserver formatting
              if buf_client.name == "tsserver" then
                return false
              end
              if have_nls then
                return buf_client.name == "null-ls"
              end
              return buf_client.name ~= "null-ls"
            end,
          })
        end,
      })
    end
  end)

  lsp.setup({})
  require("lspconfig.ui.windows").default_options.border = "single"
end

return M
