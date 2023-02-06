if exists("g:loaded_insautocomplete")
  finish
endif
let g:loaded_insautocomplete=1

if !has('autocmd')
  echoerr "Autocommand feature is required to run 'insautocomplete'"
  finish
endif

set completeopt-=menu
set completeopt+=menuone
set completeopt+=noinsert
set completeopt+=noselect
set complete+=.
set complete+=b

if (has("win64") || has("win32") || has("win16"))
  set completeslash="slash"
endif

augroup augroup_insautocomplete
  autocmd!
  autocmd InsertCharPre * silent! call insautocomplete#automatic()
  autocmd InsertEnter   * silent! call insautocomplete#automatic()
augroup end
