" Tips {{{1
"
" When using a put command like p or P in Visual mode, Vim will try to replace
" the selected text with the contents of the register.

" <C-R>=, or Ctrl+R= is used to insert the result of an expression at the cursor.
" :help i_ctrl_r
" = is the "expression register". See :help "=

" q: — Open with a command history from normal mode
" q/ — Open with a search history from normal mode (to search forward)
" q? — Open with a search history from normal mode (to search backward)
" Ctrl+F — Open with a command history from command mode

" you can yank, delete or change forward or backward to a search result:
" y/search<Enter>
" y?search<Enter>
" d/search<Enter>
" d?search<Enter>
" c/search<Enter>
" c?search<Enter>

" }}}

" Use Vim settings, rather then Vi settings.
set nocompatible

let mapleader   = "\<Space>"
let g:mapleader = "\<Space>"


if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif
filetype plugin indent on

" No audible bell
set vb

" improves redrawing for newer computers
set ttyfast

" will not redraw the screen while running macros (goes faster)
set lazyredraw

set mouse=a

" display incomplete commands
set showcmd

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" complete options
set completeopt+=noinsert
set completeopt+=noselect
set completeopt+=menuone
set completeopt-=preview

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>


" key map {{{1
"TIP: check what's mapped to the key
":verbose imap <tab>

" use  ⌘s  to save file in iTerm2
" iTerm2 -> Preferences -> Keys -> +: add new key map
"     Keyboard Shortcut: ⌘s
"     Action: Send Text with "vim" Specia Chars
"     :w\n
"

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" don't use Arrow to navigator
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" don't use q as recording
function Quit()
    if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        exec "q!"
    else
        exec "bdelete!"
    endif
endfunction
nnoremap q :call Quit()<cr>

" next buffer
nnoremap <Tab> :bnext<CR>

" Resize Window
nnoremap <Leader>- 2<C-w>-
nnoremap <Leader>= 2<C-w>+

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

" quickfix
nnoremap ]q :cn<cr>
nnoremap [q :cp<cr>

" Typing 'a will jump to the line marked with ma. However, `a will jump to the
" line and column marked with ma. "swap them.
nnoremap ' `
nnoremap ` '

" select last changed/pasted text
" similar to the standard 'gv': select the last visually-selected text.
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" press <Enter> to toggle fold
" foldmethod: indent, syntax, marker, manual etc
nnoremap <expr> <CR> foldlevel(line('.'))  ? "za" : "\<CR>"

" An alternative for the esc key is CTRL+[ combination
inoremap jk <Esc>

" Set working directory
nnoremap <silent> <leader>. :lcd %:p:h<CR>:pwd<CR>

" Clean search (highlight)
nnoremap <silent> <leader>h :nohlsearch<CR>

if has('nvim')

" keymap for neovim terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

augroup Terminal
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

function! Tig()
    let s:callback = {}

    if finddir('.git') != ".git"
        return
    endif

    function! s:callback.on_exit(id, status, event)
      exec 'bw!'
    endfunction

    exec 'enew'
    call termopen('tig', s:callback)
    startinsert
endfunction
nnoremap <silent> <leader>g :call Tig()<cr>

endif

" }}}

" visual style {{{1


" using 24-bit color. Requires a ISO-8613-3 compatible terminal
set termguicolors

"always show the status line
set laststatus=2

colorscheme gruvbox
set background=dark

" enable syntax highlight
syntax enable

" must be after loading color theme related
" Font used by GUI VIM/Terminal must support italic typeface
highlight Comment cterm=italic
highlight Comment gui=italic

" highlight SCM merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" highlight current line
set cursorline

" show matching bractes
set showmatch

set ruler
set number


" 'list' is to visualise tabs, spaces, and line endings
" eol: the character to show at the end of each line
" tab: the characters to show a tab. Two characters are used, 2nd will be
"      repeated for each space
" trail: character to show for trailling spaces
" vim-better-space is installed, only set tab here
set listchars=tab:▸\ ,
" it is convenient to use :set list! to toggle the option 'list' on
set list

" }}}

" clipboard {{{1
" make all yanking/deleting operations automatically copy to the system clipboard
if has("clipboard")
    " on Mac and Windows, use * register for copy-paste
    if has("macunix")||has("win32")||has("win64")
        set clipboard=unnamed
    else " on Linux, use + register for copy-paste
        set clipboard=unnamedplus
    endif
endif

" }}}

" backup {{{1
set nobackup
set noswapfile

if has("persistent_undo")
    " nvim'undodir' defaults to ~/.local/share/nvim/undo that's auto-created
    set undofile
    set undolevels=1000     " Maximum number of changes that can be undone
    set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
endif
" }}}

" search {{{1
" highlight search
set hlsearch
" start searching when you type the first character
set incsearch

" these two options, when set together, will make /-style searchs
" case-sensitive only if there is a capital letter in the search expression.
" *-style searchs continue to be consistently case-sensitive
set ignorecase
set smartcase
" }}}

" file {{{1
" Allow buffer switching without saving
set hidden

set wildmode=list:longest,list:full
set wildignore+=*.o,*.so,*.ko,*.swp,*.zip,*.pyc

set formatoptions+=mM
set encoding=utf-8
set fileencodings=ucs-bom,utf8,gbk
set fileformats=unix,dos,mac

" set to auto read when a file is changed from tht outside
set autoread

" automatically save before running command
set autowrite

" }}}

" indent {{{1

" to insert a real tab when 'expandtab' is on, use CTRL-V<Tab>
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=0

"help smarttab
"set smarttab
" }}}

" autocmd {{{1
augroup vimrc-gitcommit
    autocmd!
    " Instead of reverting the cursor to the last position in the buffer, set it to
    " the first line when editing a git commit message
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END


"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" cause the quickfix window to open after any grep invocation:
autocmd QuickFixCmdPost *grep* cwindow


" }}}

" neovim {{{1
if has("nvim")

" Neovim inside terminal palette: gruvbox -- dark mode
" https://github.com/morhetz/gruvbox#dark-mode-1
let g:terminal_color_0  = '#282828'
let g:terminal_color_1  = '#cc241d'
let g:terminal_color_2  = '#98971a'
let g:terminal_color_3  = '#d79921'
let g:terminal_color_4  = '#458588'
let g:terminal_color_5  = '#b16286'
let g:terminal_color_6  = '#689d6a'
let g:terminal_color_7  = '#a89984'
let g:terminal_color_8  = '#928374'
let g:terminal_color_9  = '#fb4934'
let g:terminal_color_10 = '#b8bb26'
let g:terminal_color_11 = '#fabd2f'
let g:terminal_color_12 = '#83a598'
let g:terminal_color_13 = '#d3869b'
let g:terminal_color_14 = '#8ec07c'
let g:terminal_color_15 = '#ebdbb2'

set inccommand=nosplit
endif

" }}}

" Settings for language {{{1

let g:tex_flavor = "context"

augroup vimrc-language
  autocmd!
  autocmd FileType javascript set tabstop=4|set shiftwidth=4|set expandtab softtabstop=4
  autocmd Filetype html setlocal ts=2 sw=2 expandtab
  autocmd Filetype go setlocal noexpandtab
augroup END


" }}}

if filereadable('./.vimrc.local')
    so ./.vimrc.local
endif

" vim: set foldlevel=0 foldmethod=marker:
