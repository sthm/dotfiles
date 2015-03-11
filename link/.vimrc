" Change mapleader
let mapleader=","

" Move more naturally up/down when wrapping is enabled.
"nnoremap j gj
"nnoremap k gk

" Local dirs
if !has('win32')
  set backupdir=$DOTFILES/caches/vim
  set directory=$DOTFILES/caches/vim
  set undodir=$DOTFILES/caches/vim
  let g:netrw_home = expand('$DOTFILES/caches/vim')
endif

" Create vimrc autocmd group and remove any existing vimrc autocmds,
" in case .vimrc is re-sourced.
augroup vimrc
  autocmd!
augroup END

" Theme / Syntax highlighting

" Make invisible chars less visible in terminal.
autocmd vimrc ColorScheme * :hi NonText ctermfg=236
autocmd vimrc ColorScheme * :hi SpecialKey ctermfg=236
" Show trailing whitespace.
autocmd vimrc ColorScheme * :hi ExtraWhitespace ctermbg=red guibg=red
" Make selection more visible.
autocmd vimrc ColorScheme * :hi Visual guibg=#00588A
autocmd vimrc ColorScheme * :hi link multiple_cursors_cursor Search
autocmd vimrc ColorScheme * :hi link multiple_cursors_visual Visual

"let g:molokai_italic=0
"colorscheme molokai
set background=light

" Visual settings
"set cursorline " Highlight current line
"set number " Enable line numbers.
"set showtabline=2 " Always show tab bar.
"set relativenumber " Use relative line numbers. Current line is still in status bar.
"set title " Show the filename in the window titlebar.
"set nowrap " Do not wrap lines.
"set noshowmode " Don't show the current mode (airline.vim takes care of us)
set laststatus=2 " Always show status line

" Show absolute numbers in insert mode, otherwise relative line numbers.
"autocmd vimrc InsertEnter * :set norelativenumber
"autocmd vimrc InsertLeave * :set relativenumber

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Scrolling
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.

" Indentation
set autoindent " Copy indent from last line when starting new line.
set shiftwidth=2 " The # of spaces for indenting.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set softtabstop=2 " Tab key results in 2 spaces
set tabstop=2 " Tabs indent only 2 spaces
set expandtab " Expand tabs to spaces

" Reformatting
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.

" Toggle show tabs and trailing spaces (,v)
if has('win32')
  set listchars=tab:>\ ,trail:.,eol:$,nbsp:_,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<
endif
"set listchars=tab:>\ ,trail:.,eol:$,nbsp:_,extends:>,precedes:<
"set fillchars=fold:-
nnoremap <silent> <leader>v :call ToggleInvisibles()<CR>

" Extra whitespace
autocmd vimrc BufWinEnter * :2match ExtraWhitespaceMatch /\s\+$/
autocmd vimrc InsertEnter * :2match ExtraWhitespaceMatch /\s\+\%#\@<!$/
autocmd vimrc InsertLeave * :2match ExtraWhitespaceMatch /\s\+$/

" Toggle Invisibles / Show extra whitespace
function! ToggleInvisibles()
  set nolist!
  if &list
    hi! link ExtraWhitespaceMatch ExtraWhitespace
  else
    hi! link ExtraWhitespaceMatch NONE
  endif
endfunction

set list
call ToggleInvisibles()

" Search / replace
" set gdefault " By default add g flag to search/replace. Add g to toggle.
set hlsearch " Highlight searches
set incsearch " Highlight dynamically as pattern is typed.
set ignorecase " Ignore case of searches.
set smartcase " Ignore 'ignorecase' if search pattern contains uppercase characters.

" Clear last search
map <silent> <leader>/ <Esc>:nohlsearch<CR>

" Ignore things
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/log/*,*/tmp/*

" Vim commands
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set report=0 " Show all changes.
"set mouse=a " Enable mouse in all modes.
set shortmess+=I " Hide intro menu.

" Splits
set splitbelow " New split goes below
set splitright " New split goes right

" Ctrl-J/K/L/H select split
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Buffer navigation
"nnoremap <leader>b :CtrlPBuffer<CR> " List other buffers
"map <leader><leader> :b#<CR> " Switch between the last two files
"map gb :bnext<CR> " Next buffer
"map gB :bprev<CR> " Prev buffer

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

" When editing a file, always jump to the last known cursor position. Don't do
" it for commit messages, when the position is invalid, or when inside an event
" handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

"" FILE TYPES

" vim
autocmd vimrc BufRead .vimrc,*.vim set keywordprg=:help


" PLUGINS

" Airline
"let g:airline_powerline_fonts = 1 " TODO: detect this?
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#buffer_nr_format = '%s '
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#fnamecollapse = 0
"let g:airline#extensions#tabline#fnamemod = ':t'

" Signify
"let g:signify_vcs_list = ['git', 'hg', 'svn']

" CtrlP.vim
"map <leader>p <C-P>
"map <leader>r :CtrlPMRUFiles<CR>
"let g:ctrlp_match_window_bottom = 0 " Show at top of window


" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
"Plug 'bling/vim-airline'
"Plug 'tpope/vim-sensible'
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-vinegar'
"Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-unimpaired'
"Plug 'tpope/vim-eunuch'
"Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'fatih/vim-go', {'for': 'go'}
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'pangloss/vim-javascript', {'for': 'javascript'}
"Plug 'mhinz/vim-signify'
"Plug 'mattn/emmet-vim'
"Plug 'mustache/vim-mustache-handlebars'
"Plug 'chase/vim-ansible-yaml'
"Plug 'wavded/vim-stylus'
"Plug 'klen/python-mode', {'for': 'python'}
"Plug 'terryma/vim-multiple-cursors'
"Plug 'wting/rust.vim', {'for': 'rust'}
call plug#end()
