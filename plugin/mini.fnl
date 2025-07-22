(macro setup [mod ?opts ...]
  `(with-module [m# ,mod]
    ((. m# :setup) ,(or ?opts {}))
    ,...))

(setup :mini.surround)
(setup :mini.icons)
(setup :mini.files {:mappings {:go_in_plus :<CR>}}
  (keymap :n "<Space>e" #(MiniFiles.open)))
(setup :mini.extra)
(setup :mini.pick {:mappings {:toggle_info "<C-/>"}}
  (set MiniPick.config.source.show MiniPick.default_show)
  (keymap :n "<Space>f" MiniPick.builtin.files)
  (keymap :n "<Space>/" MiniPick.builtin.grep_live)
  (keymap :n "<Space>b" MiniPick.builtin.buffers)
  (keymap :n "<M-S-/>" MiniPick.builtin.help)

  (when MiniExtra
    (keymap :n "<Space>r" MiniExtra.pickers.visit_paths)
    (keymap :n "<Space>g" #(MiniExtra.pickers.diagnostic {:get_opts {:severity {:min vim.diagnostic.severity.WARN}}}))
    (augroup mini#
      (autocmd :LspAttach "*" #(keymap :n "<Space>s" #(MiniExtra.pickers.lsp {:scope :workspace_symbol}) {:buffer (. $1 :buf)}))
      (autocmd :LspAttach "*" #(vim.keymap.del :n "<Space>s" {:buffer (. $1 :buf)})))))
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
