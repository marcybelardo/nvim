-- ######################################
-- ##                                  ##
-- ##      Marcy's Neovim Config       ##
-- ##                                  ##
-- ######################################

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
