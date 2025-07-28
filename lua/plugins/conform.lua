local cf = require("conform")

cf.setup({
    format_on_save = {
	timeout_ms = 500,
	lsp_format = "fallback",
    },
    formatters_by_ft = {
	c = { "clang-format" },
	go = { "gofmt" },
	lua = { "stylua" },
	markdown = { "markdownfmt" },
	rust = { "rustfmt" },
	zig = { "zigfmt" },
   },
})

cf.formatters.clang_format = {
    args = { "-style=Linux" },
}
