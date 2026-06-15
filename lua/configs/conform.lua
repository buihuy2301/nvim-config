local options = {
  -- Run formatter on save
  format_on_save = {
    timeout_ms = 3000,
    -- NOTE: Setting lsp_fallback to 'false' is often preferred with conform
    -- to avoid conflicts, but 'true' is fine if you want the extra safety.
    lsp_fallback = true,
  },

  -- Per-filetype formatters
  formatters_by_ft = {
    python = { "black" },

    go = { "goimports", "gofmt" },

    lua = { "stylua" },

    -- Add Prettier for Web Development
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
  },
}

-- Ensure these formatters are installed via Mason (see previous response)
require("conform").setup {
  format_on_save = options.format_on_save,
  formatters_by_ft = options.formatters_by_ft,

  -- You only need to define custom formatters here.
  -- 'black', 'gofmt', 'goimports', and 'stylua' are usually auto-detected
  -- if installed via Mason and don't require explicit definitions unless
  -- you need custom arguments.
  formatters = {
    -- Removed the custom 'ruff_format' definition.
    -- Keeping the Go definitions, though they often aren't necessary if
    -- you use Mason and the commands are on your PATH.
    gofmt = {
      command = "gofmt",
      args = {},
    },

    goimports = {
      command = "goimports",
      args = {},
    },
    -- Optional: If 'black' needs custom arguments, define it here:
    -- black = {
    --   command = "black",
    --   args = { "--stdin-filename", "$FILENAME", "-" },
    -- },
  },
}
