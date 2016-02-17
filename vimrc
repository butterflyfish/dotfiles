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

" ctags
"
" ctags -R --exclude=.git --tag-relative --fields=+l --langmap=c:.c.h -f .git/tags
" git ls-files | ctags --tag-relative -L - --fields=+l --langmap=c:.c.h -f .git/tags
" I stick the tags file in .git because if fugitive.vim is installed, Vim will be configured
" to look for tags there automatically, regardless of your current working directory
"
" hitting g] or CTRL-] will jump to the place where that method is defined or implemented.
" :CtrlPTag will let you search through your tags file and jump to where tags are defined

" built-in solution to the problem of mismatches when using the jump commands
" (f, t, F, T) is the use of ; and, Semicolon will repeat the last jump command,
" and comma will repeat it in the opposite direction. t: till before
"
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

" display incomplete commands
set showcmd

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Intuitive backspacing in insert mode
set backspace=indent,eol,start


" key map {{{1
"TIP: check what's mapped to the key
":verbose imap <tab>
"
" don't use Arrow to navigator
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

nnoremap <Leader>q :q!<cr>
nnoremap <Leader>w :w<cr>

" Resize Window
nnoremap <Leader>- 2<C-w>-
nnoremap <Leader>= 2<C-w>+

" switch between last two files
nnoremap <leader><Tab> <c-^>

" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap <silent> j gj
vnoremap <silent> k gk

" Typing 'a will jump to the line marked with ma. However, `a will jump to the
" line and column marked with ma. "swap them.
nnoremap ' `
nnoremap ` '

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" select last changed/pasted text
" similar to the standard 'gv': select the last visually-selected text.
" http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" press <Enter> to toggle fold
" foldmethod: indent, syntax, marker, manual etc
nnoremap <expr> <CR> foldlevel(line('.'))  ? "za" : "\<CR>"

" Find merge conflict markers
nnoremap <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" An alternative for the esc key is CTRL+[ combination
inoremap jk <Esc>

if has('nvim')

" keymap for neovim terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

endif

" }}}

" visual style {{{1

"always show the status line
set laststatus=2

if has("gui_running")

    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    set gfn=Anonymice\ Powerline:h14

    " colorscheme
    colorscheme molokai
else
    colorscheme gruvbox
endif

set background=dark


" enable syntax highlight
syntax enable

" must after loading theme related
" Font used by gvim/Terminal must support italic typeface
highlight Comment cterm=italic
highlight Comment gui=italic

" highlight SCM merge conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" highlight current line
set cursorline

" show matching bractes
set showmatch

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

" set textwidth=80
" set cc=+1

" }}}

" clipboard {{{1
" make all yanking/deleting operations automatically copy to the system clipboard
"
" since the version of vim that comes with OSX does not support using the system
" clipboard, mvim is used. This command will also alias vim, vi, view, vimdiff,
" etc. brew install macvim --override-system-vim && brew linkapps
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
    "directory must be existed first
    set undodir="~/.undodir"
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
set tabstop=4 shiftwidth=4 softtabstop=4

"help smarttab
"set smarttab
" }}}

" autocmd {{{1
augroup vimrc
    autocmd!

    " Auto jump to last edit place when opening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    endif

    " Instead of reverting the cursor to the last position in the buffer, set it to
    " the first line when editing a git commit message
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
augroup END


" cause the quickfix window to open after any grep invocation:
autocmd QuickFixCmdPost *grep* cwindow


" }}}

if filereadable('./.vimrc.local')
    so ./.vimrc.local
endif

" set grepprg=ag\ --nogroup\ --nocolor
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" nnoremap <leader>/ :Ag<SPACE>

" vim: set foldlevel=0 foldmethod=marker:
