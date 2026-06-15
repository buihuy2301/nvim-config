local null_ls = require "null-ls"

local sources = {
  -- Python
  null_ls.builtins.formatting.ruff,
  null_ls.builtins.diagnostics.ruff,

  -- Go
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
}

null_ls.setup { sources = sources }
