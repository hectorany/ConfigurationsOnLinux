" General

set nocompatible " get out of horrible vi-compatible mode
set ignorecase

filetype on " detect the type of file
set history=1000 " How many lines of history to remember
set cf " enable error files and error jumping
set clipboard+=unnamed " turns out I do like is sharing windows clipboard
set ffs=unix,dos,mac " support all three, in this order
filetype plugin on " load filetype plugins
set viminfo+=! " make sure it can save viminfo
set isk+=_,$,@,%,#,- " none of these should be word dividers, so make them not be
runtime ftplugin/man.vim " enable :Man (\K)

" Theme/Colors
colorscheme tolerable
"set background=dark " we are using a dark background
syntax enable
syntax on
"colorscheme molokai

" Files/Backups
                                                                                                                                                       
" set backup " make backup file
" set backupdir=$VIM\vimfiles\backup " where to put backup file
" set directory=$VIM\vimfiles\temp " directory is the directory for temp file
" set makeef=error.err " When using make, where should it dump the file

" Vim UI

"set mouse=a " use mouse everywhere. Doesn't work well with tmux
set wildmenu " turn on wild menu
set wildmode=list:longest,full " list all completions for wild menu
set lsp=0 " space it out a little more (easier to read)
set ruler " Always show current positions along the bottom
set number " turn on line numbers
set lz " do not redraw while running macros (much faster) (LazyRedraw)
set hid " you can change buffer without saving
set backspace=2 " make backspace work normal
set whichwrap+=<,>,h,l  " backspace and cursor keys wrap to
set shortmess=atI " shortens messages to avoid 'press a key' prompt
set report=0 " tell us when anything is changed via :...
set noerrorbells " don't make noise
" make the splitters between windows be blank
set fillchars=vert:\ ,stl:\ ,stlnc:\
set tags=tags
" Visual Cues

set showmatch " show matching brackets
set mat=1 " how many tenths of a second to blink matching brackets for
"set nohlsearch " do not highlight searched for phrases
set incsearch " BUT do highlight as you type you search phrase
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ " what to show when I hit :set list
set so=10 " Keep 10 lines (top/bottom) for scope
set novisualbell " don't blink
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]
set laststatus=2 " always show the status line

"
""cursor line
set cursorline
highlight cursorline  guibg=lightblue

" Text Formatting/Layout

set fo=tcrqn " See Help (complex)
set ai " autoindent
set si " smartindent
set cindent " do c-style indenting
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify
"set expandtab " tab to space. use ctrl-v<Tab> to insert tab
set noexpandtab 
set smarttab " use tabs at the start of a line, spaces elsewhere
set nowrap " do not wrap lines

" Minibuf

let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
let g:miniBufExplModSelTarget = 1

" Matchit

let b:match_ignorecase = 1

" C-support

let  g:pydiction_location='~/.vim/complete-dict/complete-dict'
let  g:C_SourceCodeExtensions='c cc cp cxx cpp CPP c++ C i ii'
let  g:C_UseTool_cmake='yes' 
let  g:C_UseTool_doxygen='yes'

" Tlist
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=0
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=30
let Tlist_Use_SingleClick=0
let Tlist_Auto_Open=0
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Process_File_Always=1
let Tlist_WinHeight=10
let Tlist_WinWidth=24
let Tlist_Use_Horiz_Window=0


" Autocommands

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
au BufNewFile,BufRead *.x :set ft=c " all my .x files are .h files
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

" Commands Ref
" :split [file] split window, C-ww switch window, :close close current window
" C-^ switch buffer, :bd close buffer(buffer delete)
" :ls list buffers, :bn switch to buffer n, :sbn split and bn
" In editing mode, C-n/C-p auto-completion
" vim -d file1 file2 [file3]  diff files
" see man page: K or \K or :Man
" go to file at point: gf
" format code: select text in visual mode, then "="
" Column-edit: C-v

" Thanks for .vimrc template from http://www.vi-improved.org/vimrc.php
