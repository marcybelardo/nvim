local wk = require("which-key")

wk.setup({
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

wk.add({
	{ "<leader>f", group = "Fuzzy Find" },
	{ "<leader>b", group = "Buffer" },
	{ "g", group = "LSP" },
})
