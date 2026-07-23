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
-- Python (basedpyright)
---------------------------------------------------------
-- Root at the Python project (venv lives here) BEFORE falling back to .git,
-- otherwise the venv is never found and imports fail to resolve (gd gets
-- stuck on the import row).
lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".venv",
    "venv",
    ".git",
  },
  settings = {
    basedpyright = {
      -- Ruff owns import sorting; avoid duplicate "organize imports" actions.
      disableOrganizeImports = true,
      -- Match VSCode/Pylance's default instead of basedpyright's noisier
      -- "recommended" mode. Bump to "standard"/"strict" per-project via a
      -- pyproject.toml [tool.basedpyright] or pyrightconfig.json.
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
---------------------------------------------------------
-- Python linting / import sorting (ruff — native server)
---------------------------------------------------------
-- Split of duties: basedpyright does type-checking + go-to-def + hover;
-- ruff does lint diagnostics, quick-fixes and import sorting. Hover is
-- disabled here so basedpyright is the single source of hover text.
lsp.config.ruff = {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    ".git",
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    on_attach(client, bufnr)
  end,
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

local servers = { "html", "cssls", "basedpyright", "ruff", "gopls", "lua_ls" }
vim.lsp.enable(servers)
