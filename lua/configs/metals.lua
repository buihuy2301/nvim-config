-- nvim-metals: Scala LSP (independent of nvim-lspconfig)
local nvlsp = require "nvchad.configs.lspconfig"

local M = {}

M.setup = function()
  local metals_config = require("metals").bare_config()

  -- Reuse NvChad's completion capabilities
  metals_config.capabilities = nvlsp.capabilities

  -- Keymaps: run NvChad's defaults (gd, gD, <leader>D, <leader>ra, workspace)
  -- then add the common LSP keys NvChad doesn't map + a few Metals extras.
  metals_config.on_attach = function(client, bufnr)
    -- NvChad defaults: gd -> definition, gD -> declaration,
    -- <leader>D -> type definition, <leader>ra -> rename, <leader>w* -> workspace
    nvlsp.on_attach(client, bufnr)

    local map = vim.keymap.set
    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end

    -- Metals doesn't implement textDocument/declaration, so NvChad's default
    -- gD -> vim.lsp.buf.declaration errors. Point gD at definition instead.
    map("n", "gD", vim.lsp.buf.definition, opts "Go to definition")

    -- Common LSP mappings (NvChad style) that aren't in the defaults
    map("n", "gr", vim.lsp.buf.references, opts "Find references")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "K", vim.lsp.buf.hover, opts "Hover documentation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Signature help")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "[d", vim.diagnostic.goto_prev, opts "Prev diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, opts "Next diagnostic")

    -- Metals-specific extras
    map("n", "<leader>mc", function()
      require("telescope").extensions.metals.commands()
    end, opts "Metals commands")
    map("n", "<leader>mo", function()
      require("metals").organize_imports()
    end, opts "Metals organize imports")
    map("n", "<leader>mh", function()
      require("metals").hover_worksheet()
    end, opts "Metals hover worksheet")
  end

  metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  }

  metals_config.init_options = {
    statusBarProvider = "off",
  }

  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end

return M
