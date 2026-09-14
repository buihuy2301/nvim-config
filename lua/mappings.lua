require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Toggle Markdown Preview
map("n", "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Render Markdown" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Git Neogit" })

-- Aerial (code outline)
map("n", "<leader>o", "<cmd>AerialToggle!<cr>", { desc = "Aerial toggle outline" })
map("n", "<leader>O", "<cmd>AerialNavToggle<cr>", { desc = "Aerial nav window" })

-- Diffview
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open (working tree)" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview history (current file)" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview history (repo)" })
map("v", "<leader>gh", "<esc><cmd>'<,'>DiffviewFileHistory<cr>", { desc = "Diffview history (selection)" })

-- VimTeX mappings (Using the same style that works for you)
map("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: Toggle Compile" })
map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: View PDF" })
map("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "LaTeX: Show Errors" })
map("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "LaTeX: Clean Aux Files" })
