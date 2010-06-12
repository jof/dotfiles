syntax on

if has("autocmd")
  filetype plugin indent on

  autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \  exe "normal g`\"" |
   \ endif

endif

set number

set cindent
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

set cursorline

colorscheme desert
