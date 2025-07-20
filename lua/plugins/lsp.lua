vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
        vim.keymap.set('n', 'gD', "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
        vim.keymap.set({'n', 'x'}, 'gq', "<CMD>lua vim.lsp.buf.format({async = true})<CR>", opts)
        vim.keymap.set('i', '<C-s>', "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
        vim.keymap.set('n', '<leader>ld', "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
        vim.keymap.set('n', '<leader>li', "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
        vim.keymap.set('n', '<leader>lt', "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
        vim.keymap.set('n', '<leader>lr', "<CMD>lua vim.lsp.buf.references()<CR>", opts)
        vim.keymap.set('n', '<leader>ln', "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
        vim.keymap.set('n', '<leader>la', "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
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
