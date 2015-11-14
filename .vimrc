" -----------------------------------------------------------
" Fz84's ultimate vimrc, good for C/C++ developer
"                           ,---.-,                
"                          '   ,'  '.         ,--, 
"     ,---,.              /   /      \      ,--.'| 
"   ,'  .' |             .   ;  ,/.  :   ,--,  | : 
" ,---.'   |       ,----,'   |  | :  ;,---.'|  : ' 
" |   |   .'     .'   .`|'   |  ./   :;   : |  | ; 
" :   :  :    .'   .'  .'|   :       ,|   | : _' | 
" :   |  |-,,---, '   ./  \   \     / :   : |.'  | 
" |   :  ;/|;   | .'  /    ;   ,   '\ |   ' '  ; : 
" |   |   .'`---' /  ;--, /   /      \\   \  .'. | 
" '   :  '    /  /  / .`|.   ;  ,/.  : `---`:  | ' 
" |   |  |  ./__;     .' '   |  | :  ;      '  ; | 
" |   :  \  ;   |  .'    '   |  ./   :      |  : ; 
" |   | ,'  `---'        |   :      /       '  ,/  
" `----'                  \   \   .'        '--'   
"                          `---`-'                 
" Based on: Amir Salihefendic (https://github.com/amix/vimrc)
" -----------------------------------------------------------


" -----------------------------------------------------------
"  Configuration for Vundle
" -----------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
"
" Autocomplete
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs.git'
Plugin 'klen/python-mode'
" 
" Ack
Plugin 'mileszs/ack.vim'
"
" Look and Feel
Plugin 'godlygeek/tabular'
Plugin 'bling/vim-airline'
Plugin 'morhetz/gruvbox'
"
" Code browsing
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/taglist.vim'
Plugin 'scrooloose/nerdtree'
" 
" Git 
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
call vundle#end()            " required

filetype plugin on
filetype indent on

set history=700
set autoread " autoread when a file is changed from the outside

" set <leader> to comma
let mapleader=","
let g:mapleader=","

nmap <leader>w :w!<CR>
nmap <leader>q :x<CR>
inoremap <leader>q :wq<CR>

" -----------------------------------------------------------
" user interface
" -----------------------------------------------------------

set so=5 " screen offset

set wildmenu
set wildignore=*.o,*~,*.pyc
set wildignore+=.git\*,.hg\*,.svn\*

set ruler "Always show current position
set cmdheight=1 " Height of the command bar
set hid " A buffer becomes hidden when it is abandoned

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" make search modern and usable
set ignorecase
set smartcase
set hlsearch
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" -----------------------------------------------------------
" Colors and Fonts
" -----------------------------------------------------------
" Font (patched with Powerline support) can be downloaded at
" https://github.com/powerline/fonts/

syntax enable 
colorscheme gruvbox

if has("gui_running")
    " solarized scheme works better with GUI
    " see https://github.com/altercation/vim-colors-solarized
    let g:solarized_termcolors=256
    let g:solarized_underline=0
    set background=dark

    " Set extra options when running in GUI mode
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t

    if has('gui_macvim')
        set guifont=Inconsolata\ for\ Powerline:h13
    else
        set guifont=Inconsolata\ Medium\ 12

    endif
endif

set encoding=utf8
set ffs=unix,dos,mac

" -----------------------------------------------------------
" Files, backups and undo
" -----------------------------------------------------------
set nobackup
set nowb
set noswapfile


" -----------------------------------------------------------
" Text, tab and indent related
" -----------------------------------------------------------
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Linebreak on 80 characters
set linebreak
set breakat=80

" disable automatic wrapping
" as suggested by http://blog.ezyang.com/2010/03/vim-textwidth/
set textwidth=0
set fo-=t

" also comes from by http://blog.ezyang.com/2010/03/vim-textwidth/
augroup vimrc_autocmds
  autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter * match OverLength /\%80v.*/
augroup END

set autoindent "Auto indent
set smartindent "Smart indent
set wrap 


" -----------------------------------------------------------
" Moving around, tabs, windows and buffers
" -----------------------------------------------------------

" Treat long lines as break lines (useful when moving around in them)
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
nnoremap ^ g^


" Disable search highlight when <leader><CR> is pressed
map <silent> <leader><CR> :noh<CR>

" mappings for managing tabs
" tab navigation like firefox
nnoremap <silent> <leader>, :tabprevious<CR>
nnoremap <silent> <leader>. :tabnext<CR>
inoremap <silent> <leader>, <Esc>:tabprevious<CR>i
inoremap <silent> <leader>. <Esc>:tabnext<CR>i
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" CS style window navigation
nnoremap <silent> <leader>ww <C-w>k
nnoremap <silent> <leader>ss <C-w>j
nnoremap <silent> <leader>aa <C-w>h
nnoremap <silent> <leader>dd <C-w>l

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Remember last edit position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" -----------------------------------------------------------
" Editing mappings
" -----------------------------------------------------------

map 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


" -----------------------------------------------------------
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
" -----------------------------------------------------------
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ack, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


" *Spell checking*
" use <leader>ss to trigger spell check
if v:version >= 700
    setlocal spell spelllang=en
    set nospell " don't check until I ask you so
    nmap <silent> <leader>s :set spell!<cr>
endif


" -----------------------------------------------------------
" Misc
" -----------------------------------------------------------

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" display lineno
set nu


" -----------------------------------------------------------
" Helper functions
" -----------------------------------------------------------
"
"

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Settings for YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_server_keep_logfiles = 1

if executable('python2')
    let g:ycm_path_to_python_interpreter = 
                \ substitute(system('which python2'), "\n", '', '')
endif

map <F9> :YcmCompleter FixIt<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" AutoPairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}

" Make
nnoremap <leader>m :silent make\|redraw!\|cc<CR>

" Ctags
set tags=tags;

" Airline
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline_powerline_fonts = 1

" Auto-wrap at will
set sr
set tw=80
imap <leader>b <C-O>:call AutoWrapToggle()<CR>
function! AutoWrapToggle()
  if &formatoptions =~ 't'
    set fo-=t
  else
    set fo+=t
  endif
endfunction
