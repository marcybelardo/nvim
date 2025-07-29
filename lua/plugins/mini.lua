require("mini.icons").setup({ style = "glyph" })
require("mini.notify").setup({
	lsp_progress = { enable = false },
})
vim.notify = require("mini.notify").make_notify({})
require("mini.files").setup({
	mappings = {
		go_in_plus = '<Return>',
	},
})
require("mini.pick").setup({})

local mini_statusline = require("mini.statusline")

local function statusline()
	local mode, mode_hl = mini_statusline.section_mode({trunc_width = 120})
	local diagnostics = mini_statusline.section_diagnostics({trunc_width = 75})
	local lsp = mini_statusline.section_lsp({icon = 'LSP', trunc_width = 75})
	local lsp_name = ""
	if vim.lsp.get_clients()[1] ~= nil then
		lsp_name = string.format(" %s ", vim.lsp.get_clients()[1].name)
	end
	local filename = mini_statusline.section_filename({trunc_width = 140})
	local percent = '%2p%%'
	local location = '%3l:%-2c'

	return mini_statusline.combine_groups({
		{hl = mode_hl,                  strings = {mode}},
		{hl = 'MiniStatuslineDevinfo',  strings = {diagnostics, lsp}},
		lsp_name,
		'%<', -- Mark general truncate point
		{hl = 'MiniStatuslineFilename', strings = {filename}},
		'%=', -- End left alignment
		{hl = 'MiniStatuslineFilename', strings = {'%{&filetype}'}},
		{hl = 'MiniStatuslineFileinfo', strings = {percent}},
		{hl = mode_hl,                  strings = {location}},
	})
end

mini_statusline.setup({
	content = { active = statusline },
})

require("mini.indentscope").setup({
	symbol = "▏"
})

require("mini.starter").setup({})
require("mini.extra").setup({})
require("mini.completion").setup({})

local gen_loader = require("mini.snippets").gen_loader
require("mini.snippets").setup({
	snippets = {
		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		gen_loader.from_lang(),
	}
})
