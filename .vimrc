set nocompatible
if &cp | set nocp | endif
syntax on
" colorscheme molokai
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'JuliaLang/julia-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'vim-syntastic/syntastic'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'raichoo/purescript-vim'
call vundle#end()
filetype plugin indent on
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set nomodeline
set tabstop=4
set shiftwidth=4
set expandtab
set number
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
set ruler
set directory-=$HOME/tmp
set directory^=$HOME/tmp//
set backupdir-=$HOME/tmp
set backupdir^=$HOME/tmp//
set statusline=%F
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
if &history < 1000
  set history=1000
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
let g:evervim_devtoken='S=s75:U=7f1416:E=1463d30fecf:C=13ee57fd2d3:P=1cd:A=en-devtoken:V=2:H=60f6da2e54a678a16721461ea7725d70'
" vim -b : edit binary using xxd-format!
set gfn=Monospace\ 11
let g:go_version_warning = 0