(macro setup [mod ?opts ...]
  `(with-module [m# ,mod]
    ((. m# :setup) ,(or ?opts {}))
    ,...))

(setup :mini.icons)
(setup :mini.files {:mappings {:go_in_plus :<CR>}}
  (keymap :n "<leader>e" #(MiniFiles.open) {:desc "Open files"}))
(setup :mini.extra)
(setup :mini.pick {:mappings {:toggle_info "<C-/>"}}
  (set MiniPick.config.source.show MiniPick.default_show)
  (keymap :n "<leader>ff" MiniPick.builtin.files {:desc "Pick files"})
  (keymap :n "<leader>fg" MiniPick.builtin.grep_live {:desc "Live grep"})
  (keymap :n "<leader><Space>" MiniPick.builtin.buffers {:desc "Pick buffers"})
  (keymap :n "<leader>fh" MiniPick.builtin.help {:desc "Pick help"})

  (when MiniExtra
    (keymap :n "<leader>fr" MiniExtra.pickers.visit_paths {:desc "Pick paths"})
    (keymap :n "<leader>fd" #(MiniExtra.pickers.diagnostic {:get_opts {:severity {:min vim.diagnostic.severity.WARN}}}) {:desc "Pick diagnostics"})
    (augroup mini#
      (autocmd :LspAttach "*" #(keymap :n "<leader>s" #(MiniExtra.pickers.lsp {:scope :workspace_symbol}) {:buffer (. $1 :buf)}))
      (autocmd :LspAttach "*" #(vim.keymap.del :n "<leader>s" {:buffer (. $1 :buf)})))))
(setup :mini.indentscope)

(autocmd mini# :LspAttach {:once true}
  #(setup :mini.notify {:content {:format #(. $ :msg)}
                        :window {:config #{:anchor "SE"
                                           :border :rounded
                                           :row (- vim.o.lines vim.o.cmdheight (math.min 1 vim.o.laststatus))}
                                 :winblend 0}}))

(setup :mini.starter)
(setup :mini.snippets)
(setup :mini.completion)
