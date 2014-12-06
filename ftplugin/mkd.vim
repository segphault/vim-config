set wrap lbr
set spell

" Normalize vertical line navigation for wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

imap <C-n> <esc>gja
imap <C-p> <esc>gka

" Spelling correction shortcuts
imap <m-s> <c-x>s<esc>$a
imap <m-c> <c-x><c-k>

" User interface adjustments
if has('gui_running')
  set lines=59 columns=75
  let &guifont=g:fontname . g:fontlarge
endif

" Display a running word count in the ruler
function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count
endfunction

set ruler
set rulerformat=%20(%l,%c%V\ [%{WordCount()}]\ %=%P%)

if has('gui_macvim')
  " Open current file in Marked
  command! Marked :!open -a /Applications/Marked.app "%"
  imap <D-e> <esc>:Marked<cr><cr>
  map <D-e> :Marked<cr><cr>

  " Convenient dictionary autocompletion
  set dictionary=/usr/share/dict/words
  imap <C-Space> <C-x><C-k>
endif

" Insert and remove markdown links
map <leader>yd F[xf]df)
map <leader>yp bi[<esc>ea](<esc>"+pa)<esc>
vmap <leader>yp xi[<esc>pa](<esc>"+pa)<esc>

" Disable excessive default folding for markdown files
let g:vim_markdown_initial_foldlevel=500
