
" Jump to the component declaration associated with HTML element asdfasdf asfd
map <M-r> :execute '/"#": "' . substitute(getline('.'), '^.*mid="*\(.*\)".*$', '\1', 'g') . '"' <cr>:noh<cr>

" Autocomplete MontageJS prototype values in component declaration
imap <M-p> <Esc>:set omnifunc=montageprotocomplete#Complete<cr>a<C-x><C-o>
