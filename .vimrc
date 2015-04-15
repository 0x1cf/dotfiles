""" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required

""" End of Vundle setup


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

" map
" run Python
au Filetype c,cpp  nn <buffer> <F5> :up<Bar>exe '!make '.shellescape(expand('%:r'), 1)<CR>
au Filetype python nn <buffer> <F5> :up<Bar>exe '!python '.shellescape(@%, 1)<CR>
au Filetype java   nn <buffer> <F5> :up<Bar>exe '!javac '.shellescape(@%, 1)<CR>

