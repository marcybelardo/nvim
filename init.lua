-- ######################################
-- ##                                  ##
-- ##      Marcy's Neovim Config       ##
-- ##                                  ##
-- ######################################

-- ######################################
-- ##            Lazy Setup            ##
-- ######################################

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

-- ######################################
-- ##              Plugins             ##
-- ######################################

lazy.plugins = {
	{ "rebelot/kanagawa.nvim" },
	{ "folke/which-key.nvim" },
	{ "echasnovski/mini.nvim", branch = "main" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", branch = "main" },
	{ "MeanderingProgrammer/render-markdown.nvim" },
	{ "gpanders/nvim-parinfer" },
	{ "tpope/vim-surround" },
}

if vim.fn.has("nvim-0.11") == 0 then
	vim.list_extend(lazy.plugins, {
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

-- ######################################
-- ##              Config              ##
-- ######################################

require("config.autocmd")
require("config.mappings")
require("config.options")

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

require("plugins.which-key")
require("plugins.mini")
require("plugins.lsp")
require("render-markdown").setup({})
