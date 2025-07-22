" ################################
" ##                            ##
" ##   Marcy's Neovim Config    ##
" ##                            ##
" ################################


" ################################
" ##          Options           ##
" ################################

colorscheme kanagawa

set breakindent
set cinoptions=l1,:0,g0,E-s,N-s,t0,(s,J1,j1
set completeopt=menu,menuone,popup,noselect
set confirm
set cursorline
set cursorlineopt=number
set expandtab
set foldlevelstart=99
set foldtext=
set hlsearch
set ignorecase
set linebreak
set list
set number
set relativenumber
set shiftwidth=4
set smartcase
set smoothscroll
set softtabstop=4
set splitright
set statusline=%{%v:lua.require'statusline'.statusline()%}
set tabline=%!v:lua.require'statusline'.tabline()
set tabstop=4
set undofile
set updatetime=250
set wildignore+=*.pyc,__pycache__,.DS_Store,*~,#*#,*.o
set wildignorecase
set wildmode=longest:full,full
set winborder=rounded

" ################################
" ##          Mappings          ##
" ################################

let mapleader="\<Space>"

nnoremap <leader>w <Cmd>update<CR>
nnoremap gy "+y
nnoremap gp "+p

" ################################
" ##          Autocmds          ##
" ################################

augroup init
	autocmd!

	" highlight yanked text
	autocmd TextYankPost * lua vim.hl.on_yank {higroup="Visual", timeout=150, on_visual=true}

	" hide cursorline when the current window doesn't have focus
	autocmd WinLeave,FocusLost * if !&diff && !&cursorbind | setlocal nocursorline | endif
	autocmd WinEnter,FocusGained * setlocal cursorline

	" don't show trailing spaces in insert mode	
	autocmd InsertEnter * setlocal listchars-=trail:-
	autocmd InsertLeave * setlocal listchars<

	" for some filetypes, completion based on syntax is better than nothing
	autocmd FileType cmake setlocal omnifunc=syntaxcomplete#Complete
augroup END

" ################################
" ##          Globals           ##
" ################################

lua<<
vim.loader.enable()

_G.nvim = vim.defaulttable(function(k)
	return vim.api[("nvim_%s"):format(k)]
end)

require'nvim-treesitter.configs'.setup{highlight={enable=true}}
.
