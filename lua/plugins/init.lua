return {
  -- Your existing plugins...
  -- Ensure LSP servers are installed by Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "html",
        "cssls",
        "pyright", -- Python LSP
        "gopls", -- Go LSP
        "black", -- Python Formatter (for conform)
        "gofmt", -- Go Formatter (for conform)
        "goimports", -- Go Formatter (for conform)
      },
    },
  },
  -- Existing nvim-treesitter config...
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
        "go",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Your conform.nvim config (already provided)
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use mini.nvim suite
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ft = { "markdown" },
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- highly recommended for diffs
      "nvim-telescope/telescope.nvim", -- optional: for pickers
    },
    config = true,
    cmd = "Neogit", -- Lazy loads when you run the command
  },
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "scala", "sbt", "java" },
    config = function()
      require("configs.metals").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.on_attach = require("configs.gitsigns").on_attach
      return opts
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      image = {
        enabled = true,
        doc = {
          inline = true, -- Renders images directly inside markdown
          float = false,
          max_width = 80,
          max_height = 40,
        },
      },
    },
  },
}
