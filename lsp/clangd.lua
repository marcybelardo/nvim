return {
	cmd = { "clangd", "--background-index" },
	filetypes = { "c", "cpp" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
		".git",
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
