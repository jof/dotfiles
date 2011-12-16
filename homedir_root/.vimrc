syntax on

if has("autocmd")
  filetype plugin indent on

  autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \  exe "normal g`\"" |
   \ endif

endif

set cindent
set autoindent
set copyindent
set number
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set bs=2
set hidden
set showmatch

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch
set incsearch
set title

set cursorline
set mouse=n

" change the mapleader from \ to ,
let mapleader=","
let g:netrw_liststyle=3

colorscheme desert

" vim-pathogen: load everything under ~/.vim/bundle
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

