local function map(m, k, v, d)
	vim.keymap.set(m, k, v, { desc = d, noremap = true, silent = true })
end

map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map({ "n", "x" }, "gy", '"+y', "Copy to clipboard")
map({ "n", "x" }, "gp", '"+p', "Paste clipboard")

map("n", "<leader>w", "<Cmd>write<CR>", "Save file")
map("n", "<leader>q", "<Cmd>quitall<CR>", "Quit vim")
map("n", "<leader>u", "<Cmd>update<CR> <Cmd>source<CR>", "Update vim")

map("n", "<leader>?", "<CMD>Pick oldfiles<CR>", "Search file history")
map("n", "<leader><space>", "<CMD>Pick buffers<CR>", "Search open files")
map("n", "<leader>ff", "<CMD>Pick files<CR>", "Search all files")
map("n", "<leader>fg", "<CMD>Pick grep_live<CR>", "Search in project")
map("n", "<leader>fd", "<CMD>Pick diagnostic<CR>", "Search diagnostics")
map("n", "<leader>fs", "<CMD>Pick buf_lines<CR>", "Buffer local search")
map("n", "<leader>fh", "<CMD>Pick help<CR>", "Search help tags")

map("n", "<leader>e", "<Cmd>lua MiniFiles.open()<CR>", "File explorer")
