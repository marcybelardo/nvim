for _, s in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local server = vim.fn.fnamemodify(s, ":t:r")
    vim.lsp.enable(server)
end

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
	    border = "rounded",
	    source = true,
	},
	signs = {
	    text = {
		[vim.diagnostic.severity.ERROR] = "󰅚 ",
		[vim.diagnostic.severity.WARN] = "󰀪 ",
		[vim.diagnostic.severity.INFO] = "󰋽 ",
		[vim.diagnostic.severity.HINT] = "󰌶 ",
	    },
	    numhl = {
		[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		[vim.diagnostic.severity.WARN] = "WarningMsg",
	    },
	},
})

