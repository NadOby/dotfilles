set nocompatible
if &cp | set nocp | endif
syntax on
filetype off

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Active plugins
call plug#begin('~/.vim/plugged')
Plug 'JuliaLang/julia-vim'
Plug 'burner/vim-svelte'
Plug 'derekwyatt/vim-scala'
Plug 'fatih/vim-go'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'wsdjeg/FlyGrep.vim'
" Plug 'elixir-lang/vim-elixir'
" Plug 'jelera/vim-javascript-syntax'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'raichoo/purescript-vim'
call plug#end()

" Generic configuration options
filetype plugin indent on
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set nomodeline
set number
set ruler

" Spelling
set spell spelllang=en
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl

" Set indentation and tabulation behaviour
set ts=4 sw=4 sts=4 expandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
autocmd BufRead scp://* :set bt=acwrite

" Directories to use for tmp and backup files
set directory-=$HOME/tmp
set directory^=$HOME/tmp//
set backupdir-=$HOME/tmp
set backupdir^=$HOME/tmp//

" Status line configurations
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

let g:ale_linter_aliases = {'svelte': ['css', 'javascript']}
let g:ale_linters = {'svelte': ['stylelint', 'eslint']}

let g:syntastic_sh_shellcheck_args="-x"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" vim: set ft=vim :
" vim -b : edit binary using xxd-format!
let g:go_version_warning = 0
