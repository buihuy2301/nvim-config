require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- Toggle Markdown Preview
map("n", "<leader>rm", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Render Markdown" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Git Neogit" })

-- VimTeX mappings (Using the same style that works for you)
map("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { desc = "LaTeX: Toggle Compile" })
map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "LaTeX: View PDF" })
map("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "LaTeX: Show Errors" })
map("n", "<leader>lc", "<cmd>VimtexClean<CR>", { desc = "LaTeX: Clean Aux Files" })
