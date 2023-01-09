return {
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "tab",
          tab_width = "2",
          indent_width = "2",
        },
      },
      diagnostics = {
        globals = { "vim", "require" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}
