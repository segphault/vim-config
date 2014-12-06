
"
" Vundle Configuration
"

set nocompatible
filetype off

set runtimepath+=~/Dropbox/Settings/Vim/bundle/Vundle.vim
call vundle#begin('~/Dropbox/Settings/Vim/bundle')

Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'EasyMotion'
Plugin 'Syntastic'
Plugin 'ctrlp.vim'
Plugin 'rosenfeld/conque-term'
Plugin 'surround.vim'
Plugin 'matchit.zip'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'MultipleSearch2.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'bling/vim-airline'
Plugin 'plasticboy/vim-markdown'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" File types
Plugin 'tpope/vim-haml'
Plugin 'othree/html5.vim'
Plugin 'vim-coffee-script'
Plugin 'vim-stylus'
Plugin 'jade.vim'

" Color Schemes
Plugin 'baycomb'
Plugin 'w0ng/vim-hybrid'

call vundle#end()
filetype plugin indent on

"
" Plugin Settings
"

" Enable airline's special tab bar
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Add my snippets folder to UltiSnips
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']

" Shortcut for toggling syntastic
" Credit: http://stackoverflow.com/a/21434697
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Hide annoying stuff from the Ctrl+P listing
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

"
" Custom Settings
"

" Use syntax highlighting
syntax on

" Swap files are more annoying than useful
set noswapfile

" Incremental search with highlighting
set incsearch
set hlsearch

" Tabs are actually two spaces
set softtabstop=2
set shiftwidth=2
set expandtab

" Hide the superfluous mode notification
set noshowmode

" Don't wrap content by default
set nowrap

" Enable automatic indentation
set autoindent
filetype indent on

"
" Custom Key Bindings
"

let mapleader = ','

" Avoid having to hit escape for mode changes
imap <M-;> <Esc>
map <M-;> a

map <M-v> v
imap <M-v> <Esc>v

" Convenient buffer rotation
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bprev<cr>

" Convenient tab rotation
map <M-j> :tabnext<cr>
map <M-k> :tabprev<cr>

" Fast save
imap <C-S> <Esc>:w<cr>a

" Quick new line in insert mode
imap <C-L> <Esc>$a<Return>

" Readline shortcuts for insert mode
imap <M-f> <Esc>ea
imap <M-b> <Esc>bi
imap <C-a> <Esc>^i
imap <C-e> <Esc>$a
imap <C-n> <Esc>ja
imap <C-p> <Esc>ka
imap <C-b> <Esc>i
imap <C-f> <Esc>la

" Conque term commands
map <M-T> :ConqueTermTab bash --rcfile ~/.bash_profile<cr>
map <M-t> :ConqueTermSplit bash --rcfile ~/.bash_profile<cr>
map <M-c> :ConqueTermSplit coffee<cr>
map <M-d> :bdelete<cr>

" Fast pane switching
imap <M-h> <esc><C-w>ha
imap <M-l> <esc><C-w>la
imap <M-j> <esc><C-w>ja
imap <M-k> <esc><C-w>ka

" Clear search pattern
map <M-/> :noh<cr>

" Get command prompt without shift
nnoremap ; :

"
" User Interface Settings
"

" Platform-specific font settings
if has('gui_macvim')
  let g:fontname = 'Menlo'
  let g:fontsize = ':h13'
  let g:fontlarge = ':h17'
  " Make the meta key behave itself in MacVim
  set macmeta
elseif has('gui_win32')
  let g:fontname = 'Consolas'
  let g:fontsize = ':h10'
  let g:fontlarge = ':h14'
else
  let g:fontname = 'Ubuntu Mono'
  let g:fontsize = ' 12'
  let g:fontlarge = ' 14'
endif

if has('gui_running')
  " Hide user interface crap in MacVim or GVim
  set guioptions=e

  " Apply the font settings for the platform
  let &guifont=g:fontname . g:fontsize
endif

set background=dark
colorscheme hybrid

"
" My convenience functions
"

" Execute contents of current buffer and put output in new scratch buffer
function! SetupBufferExec()
  command! ExecBuffer let cmd='.!' . &filetype . ' "' . expand("%") . '"'
    \| below new | set buftype=nofile | execute cmd
  " Shortcuts for executing current buffer
  map <D-r> :ExecBuffer<cr>
  imap <D-r> <Esc>:ExecBuffer<cr>
endfunction

autocmd FileType python,ruby,coffee call SetupBufferExec()

" Abbreviations

abbrev slava Slava Akhmechet
