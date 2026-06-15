-- Load NvChad defaults
local nvlsp = require "nvchad.configs.lspconfig"
local on_attach = nvlsp.on_attach
local capabilities = nvlsp.capabilities

-- NEW API (Neovim 0.11+)
local lsp = vim.lsp

-- Global defaults for ALL LSP servers
lsp.config('*', {
  on_attach = on_attach,
  capabilities = capabilities,
  root_markers = { ".git", "pyproject.toml", "go.mod" },
})

---------------------------------------------------------
-- Python (pyright)
---------------------------------------------------------
lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml" },
}
---------------------------------------------------------
-- Go (gopls)
---------------------------------------------------------
lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  root_markers = { "go.mod", ".git" },
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
    },
  },
}
---------------------------------------------------------
-- Lua (lua_ls)
---------------------------------------------------------
lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("config") .. "/lua",
        },
      },
      telemetry = { enable = false },
    }
  }
}

local servers = { "html", "cssls", "basedpyright", "gopls", "lua_ls" }
vim.lsp.enable(servers)
