-- ######################################
-- ##                                  ##
-- ##      Marcy's Neovim Config       ##
-- ##                                  ##
-- ######################################

-- ######################################
-- ##              Config              ##
-- ######################################

local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("folke/which-key.nvim")
Plug("nvim-treesitter/nvim-treesitter")
Plug("rebelot/kanagawa.nvim")
Plug("echasnovski/mini.nvim")
Plug("zenbones-theme/zenbones.nvim")
Plug("rktjmp/lush.nvim")

Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")

Plug("L3MON4D3/LuaSnip")
Plug("saadparwaiz1/cmp_luasnip")

Plug("tpope/vim-sensible")
Plug("tpope/vim-surround")
Plug("tpope/vim-fugitive")
Plug("tpope/vim-sleuth")

Plug("junegunn/goyo.vim")
Plug("junegunn/limelight.vim")

Plug("gpanders/nvim-parinfer")
Plug("MeanderingProgrammer/render-markdown.nvim", { ['for'] = 'markdown' })

vim.call("plug#end")

require("config.autocmd")
require("config.mappings")
require("config.options")

vim.o.background = "dark"
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
require("plugins.cmp")
require("plugins.treesitter")
