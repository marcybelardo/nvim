local options = {
	laststatus = 3,
	ruler = false,
	showmode = false,
	showcmd = false,
	mouse = "a",
	clipboard = "unnamedplus",
	history = 100,
	swapfile = false,
	backup = false,
	undofile = true,
	cursorline = true,
	ttyfast = true,
	smoothscroll = true,
	wrap = false,

	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",

	smarttab = true,
	cindent = true,
	tabstop = 4,
	shiftwidth = 4,

	foldmethod = "expr",
	foldlevel = 99,
	foldexpr = "nvim_treesitter#foldexpr()",

	smartcase = true,
	ignorecase = true,

	hlsearch = true,

	termguicolors = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	signs = false,
	virtual_lines = {
		current_line = true,
	},
})

