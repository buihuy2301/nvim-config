local M = {}

function M.on_attach(bufnr)
  local gs = package.loaded.gitsigns
  local map = vim.keymap.set

  local function keymap_opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      return "]c"
    end
    vim.schedule(gs.next_hunk)
    return "<Ignore>"
  end, { buffer = bufnr, expr = true, desc = "Gitsigns: next hunk" })

  map("n", "[c", function()
    if vim.wo.diff then
      return "[c"
    end
    vim.schedule(gs.prev_hunk)
    return "<Ignore>"
  end, { buffer = bufnr, expr = true, desc = "Gitsigns: prev hunk" })

  -- Actions (leader>g, avoiding <leader>gs = Neogit and <leader>gt = telescope git status)
  map("n", "<leader>gS", gs.stage_hunk, keymap_opts "Gitsigns: stage hunk")
  map("n", "<leader>gr", gs.reset_hunk, keymap_opts "Gitsigns: reset hunk")
  map("v", "<leader>gS", function()
    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, keymap_opts "Gitsigns: stage selected hunk")
  map("v", "<leader>gr", function()
    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, keymap_opts "Gitsigns: reset selected hunk")
  map("n", "<leader>gu", gs.undo_stage_hunk, keymap_opts "Gitsigns: undo stage hunk")
  map("n", "<leader>gR", gs.reset_buffer, keymap_opts "Gitsigns: reset buffer")
  map("n", "<leader>gp", gs.preview_hunk, keymap_opts "Gitsigns: preview hunk")
  map("n", "<leader>gb", function()
    gs.blame_line { full = true }
  end, keymap_opts "Gitsigns: blame line")
  map("n", "<leader>gd", gs.diffthis, keymap_opts "Gitsigns: diff this")
  map("n", "<leader>gD", function()
    gs.diffthis "~"
  end, keymap_opts "Gitsigns: diff this (last commit)")

  -- Toggles
  map("n", "<leader>tb", gs.toggle_current_line_blame, keymap_opts "Gitsigns: toggle line blame")
  map("n", "<leader>td", gs.toggle_deleted, keymap_opts "Gitsigns: toggle deleted")

  -- Text object
  map({ "o", "x" }, "ih", gs.select_hunk, keymap_opts "Gitsigns: select hunk")
end

return M
