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
	{ "g", group = "LSP" },
})
