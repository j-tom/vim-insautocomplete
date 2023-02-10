let s:separator = (has("win64") || has("win32") || has("win16")) ? '[/\\]' : '[/]'
let s:sequence = [
\ {'trigger': "\<C-X>\<C-F>", 'Match': {text -> (text =~# '\v^%(%(\.{1,2}|\~|\w+)' ..s:separator ..'|' ..s:separator ..'{1,2}\w+).*') && (!empty(globpath(fnamemodify(text, ":p:h"), fnamemodify(text, ":p:t") .."*")))}},
\ {'trigger': "\<C-X>\<C-O>", 'Match': {text -> (text =~# get(b:, 'insautocomplete_omni_pattern', get(g:, 'insautocomplete_omni_pattern', '\v\k+%(\.|\-\>|\:\:|'')$'))) && !empty(&omnifunc)}},
\ {'trigger': "\<C-X>\<C-U>", 'Match': {text -> (text =~# get(b:, 'insautocomplete_user_pattern', get(g:, 'insautocomplete_user_pattern', '\v\k+%(\.|\-\>|\:\:|'')$'))) && !empty(&omnifunc)}},
\ {'trigger': "\<C-N>"      , 'Match': {text -> text =~# '\v\k+$'}},
\]

function! s:trigger() abort
  let text = fnameescape(matchstr(getline('.'), '\S\+\%' ..virtcol('.') ..'v') ..v:char)
  for s in s:sequence
    if s.Match(text)
      return s.trigger
    endif
  endfor
  return ""
endfunction

function! insautocomplete#automatic() abort
  if !pumvisible()
    call timer_start(0, feedkeys(s:trigger(), 'n'))
  endif
  return ''
endfunction
