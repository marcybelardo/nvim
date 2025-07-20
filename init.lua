local lazy = {}

function lazy.install(path)
	local uv = vim.uv or vim.loop
	if not uv.fs_stat(path) then
		print("Installing lazy.nvim...")
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable",
			path,
		})
	end
end

function lazy.setup(plugins)
	if vim.g.plugins_ready then
		return
	end

	-- You can comment out the line below after lazy.nvim is installed
	-- lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)

	require("lazy").setup(plugins, lazy.opts)
	vim.g.plugins_ready = true
end

lazy.path = table.concat({
	vim.fn.stdpath("data") --[[@as string]],
	"lazy",
	"lazy.nvim"
}, "/")

lazy.opts = {}

lazy.plugins = {
	{ "rebelot/kanagawa.nvim" },
	{ "folke/which-key.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "echasnovski/mini.nvim", branch = "main" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", branch = "main" },
	{ "MeanderingProgrammer/render-markdown.nvim" },
}

if vim.fn.has("nvim-0.11") == 0 then
	vim.list_extend(lazy.plugins, {
		{ "neovim/nvim-lspconfig", tag = "v1.8.0", pin = true },
		{
			"nvim-treesitter/nvim-treesitter",
			tag = "v0.10.0",
			pin = true,
			main = "nvim-treesitter.configs",
			opts = {
				highlight = { enable = true },
				ensure_installed = { "lua", "vim", "vimdoc", "c", "query" },
			},
		},
	})
end

lazy.setup(lazy.plugins)

require("config.autocmd")
require("config.mappings")
require("config.options")

-- PLUGIN CONFIGS

vim.cmd.colorscheme("kanagawa")

if vim.fn.has("nvim-0.11") == 1 then
	local filetypes = { "lua" }

	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetypes,
		callback = function()
			-- enable syntax highlighting
			vim.treesitter.start()
		end,
	})
end

require("which-key").setup({
	icons = {
		mappings = false,
		keys = {
			Space = "Space",
			Esc = "Esc",
			BS = "Backspace",
			C = "Ctrl-",
		},
	},
})

require("which-key").add({
	{ "<leader>f", group = "Fuzzy Find" },
	{ "<leader>b", group = "Buffer" },
})

require("mini.icons").setup({ style = "glyph" })
require("mini.comment").setup({})
require("mini.surround").setup({})
require("mini.notify").setup({
	lsp_progress = { enable = false },
})
vim.notify = require("mini.notify").make_notify({})
require("mini.files").setup({})
require("mini.pick").setup({})

local mini_statusline = require("mini.statusline")

local function statusline()
	local mode, mode_hl = mini_statusline.section_mode({trunc_width = 120})
	local diagnostics = mini_statusline.section_diagnostics({trunc_width = 75})
	local lsp = mini_statusline.section_lsp({icon = 'LSP', trunc_width = 75})
	local filename = mini_statusline.section_filename({trunc_width = 140})
	local percent = '%2p%%'
	local location = '%3l:%-2c'

	return mini_statusline.combine_groups({
		{hl = mode_hl,                  strings = {mode}},
		{hl = 'MiniStatuslineDevinfo',  strings = {diagnostics, lsp}},
		'%<', -- Mark general truncate point
		{hl = 'MiniStatuslineFilename', strings = {filename}},
		'%=', -- End left alignment
		{hl = 'MiniStatuslineFilename', strings = {'%{&filetype}'}},
		{hl = 'MiniStatuslineFileinfo', strings = {percent}},
		{hl = mode_hl,                  strings = {location}},
	})
end

-- See :help MiniStatusline.config
mini_statusline.setup({
	content = {active = statusline},
})

require("mini.indentscope").setup({
	symbol = "▏"
})

require("mini.starter").setup({})
require("mini.extra").setup({})
require("mini.snippets").setup({})
require("mini.completion").setup({})
require("render-markdown").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
        vim.keymap.set('n', 'gD', "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
        vim.keymap.set({'n', 'x'}, 'gq', "<CMD>lua vim.lsp.buf.format({async = true})<CR>", opts)
        vim.keymap.set('i', '<C-s>', "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.keymap.set('n', '<leader>ld', "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.keymap.set('n', '<leader>li', "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.keymap.set('n', '<leader>lt', "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
        vim.keymap.set('n', '<leader>lr', "<CMD>lua vim.lsp.buf.references()<CR>", opts)
        vim.keymap.set('n', '<leader>ln', "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
        vim.keymap.set('n', '<leader>la', "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
    end,
})

local function lsp_setup(server, opts)
    if vim.fn.has("nvim-0.11") == 0 then
        require("lspconfig")[server].setup(opts)
        return
    end

    if not vim.tbl_isempty(opts) then
        vim.lsp.config(server, opts)
    end

    vim.lsp.enable(server)
end

lsp_setup("bashls", {})
lsp_setup("clangd", {})
lsp_setup("gopls", {})
lsp_setup("elixirls", {
	cmd = { "/usr/share/elixir-ls/language_server.sh" }
})
lsp_setup("lua_ls", {})
lsp_setup("rust_analyzer", {})
lsp_setup("zls", {})
