if exists('g:loaded_git_zeal') || &cp
  finish
endif
let g:loaded_git_zeal = 1

let s:status_pattern = '^\s\+\([A-Z_\*]\{2\}\)\s\+\(\x\{4,16\}\)\s\+\(.*\)$'

function! s:selected_commit()
  return substitute(getline("."), s:status_pattern, '\2', '')
endfunction

function! s:clear_build(commit) abort
  execute "silent !git zeal clear-build-result " . a:commit
endfunction

function! s:ZealSplit() abort
  split term://git zeal run
  7wincmd _
  set winfixheight
  nnoremap <buffer> <silent> dd :<C-U>exe <SID>clear_build(<SID>selected_commit())<CR>
endfunction

command! ZealSplit :execute s:ZealSplit()
