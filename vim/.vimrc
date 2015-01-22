"""
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray


set nocompatible
syntax enable
set encoding=utf-8
set showcmd
filetype plugin indent on

"" whitespace
set nowrap
set tabstop=4 shiftwidth=4
set expandtab
set backspace=indent,eol,start

"" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" line number
set nu

"" NASM support
autocmd BufRead,BufNewFile *.asm set ft=nasm
