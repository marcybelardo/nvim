return {
	filetypes = { "c" },
	root_markers = {
		".clangd",
		".git",
		"Makefile",
	},
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = {
			"utf-8",
			"utf-16",
		},
	},
}
