vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
        vim.keymap.set('n', 'gD', "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
    end,
})

local servers = {
	bashls = {},
	clangd = {},
	gopls = {},
	elixirls = { cmd = { "/usr/share/elixir-ls/language_server.sh" } },
	lua_ls = {},
	rust_analyzer = {},
	zls = {},
}

for server, opts in pairs(servers) do
    if vim.fn.has("nvim-0.11") == 0 then
        require("lspconfig")[server].setup(opts)
        return
    end

    if not vim.tbl_isempty(opts) then
        vim.lsp.config(server, opts)
    end

    vim.lsp.enable(server)
end
