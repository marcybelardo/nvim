-- spellcheck in md
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell wrap",
})

-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ timeout = 300 })
	end,
})

-- lsp autocmds
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
	local map = function(k, f, d)
		vim.keymap.set("n", k, f, { buffer = event.buf, desc = "LSP: " .. d })
	end

	map("gl", vim.diagnostic.open_float, "Open diagnostic float")
	map("K", vim.lsp.buf.hover, "Hover documentation")
	map("gD", vim.lsp.buf.declaration, "Goto declaration")

	local function client_supports_method(client, method, bufnr)
		if vim.fn.has("nvim-0.11") == 1 then
			return client:supports_method(method, bufnr)
		else
			return client.supports_method(method, { bufnr = bufnr })
		end
	end

	local client = vim.lsp.get_client_by_id(event.data.client_id)
	if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
		local highlight_augroup = vim.api.nvim_create_augroup("lsp-hl", { clear = false })

		-- when cursor stops moving: highlight all instances of symbol under cursor
		-- when cursor moves: clear highlighting
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = event.buf,
			group = highlight_augroup,
			callback = vim.lsp.buf.clear_references,
		})

		-- when LSP detaches: clear highlighting
		vim.api.nvim_create_autocmd("LspDetach", {
			group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
			callback = function(event2)
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = "lsp-hl", buffer = event2.buf })
			end,
		})
	end
    end,
})

