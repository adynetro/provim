if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
" set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set mouse=a

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
"
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype plugin indent on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

""""""""""""""""""""""""" My customizations
syntax enable

" file type
filetype on
filetype plugin on

" set the leader key
 let mapleader="\\"

"set background=light
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_visibility="high"
set background=dark
colorscheme solarized

set hlsearch
set incsearch
set ignorecase
set smartcase
nmap \q :nohlsearch<CR>
set undolevels=50
set pastetoggle=<F2>
set number

"tcommenter map
map <leader>c <c-_><c-_>

"PowerLine
set encoding=utf-8
set nocompatible
set laststatus=2
set t_Co=256

"let g:Powerline_symbols = 'utf-8'
let g:Powerline_symbols = 'unicode'

" Prompt for a command to run
map rp :VimuxPromptCommand

" " Run last command executed by RunVimTmuxCommand
map rl :VimuxRunLastCommand

" " Inspect runner pane
map ri :VimuxInspectRunner

" " Close all other tmux panes in current window
map rx :VimuxCloseRunner

" " Interrupt any command running in the runner pane
map rs :VimuxInterruptRunner

" turn on command line completition wild style
set wildmenu

" turn on spell
set spell

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=8

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" hightlight cursor line
" set highlight cursorline

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Python Checker for Syntastic
let g:syntastic_python_checkers=['flake8']
map <C-e> :NERDTreeToggle<CR>
