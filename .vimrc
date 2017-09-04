call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'tomasr/molokai'
Plug 'fugalh/desert.vim'
Plug 'dracula/vim'
Plug 'romainl/Apprentice'
Plug 'mhartington/oceanic-next'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-surround'
Plug 'Townk/vim-autoclose'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

call plug#end()

color solarized
set background=dark
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1
set laststatus=2
syntax enable
set backspace=indent,eol,start
set ruler
set showcmd
set mouse=a
set tabstop=4
set softtabstop=4
set expandtab
set number
set cursorline
set showmatch
set incsearch
set hlsearch
set pastetoggle=<F2>
set clipboard=unnamed

if $TERM_PROGRAM =~ "iTerm"
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

