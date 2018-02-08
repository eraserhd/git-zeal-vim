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

function! s:show_build_result(commit) abort
  let l:tempfile = resolve(tempname()).'.zeal-result'
  silent! execute "!git zeal show-build-result " . a:commit . " > " . l:tempfile
  if v:shell_error
    return
  endif
  execute "split " . l:tempfile
  setlocal nomodifiable nomodified
  if exists('+relativenumber')
    setlocal norelativenumber
  endif
endfunction

function! s:ZealSplit() abort
  split term://git zeal run
  resize 7
  setlocal winfixheight
  nnoremap <buffer> <silent> dd      :<C-U>exe <SID>clear_build(<SID>selected_commit())<CR>
  nnoremap <buffer> <silent> <Enter> :<C-U>exe <SID>show_build_result(<SID>selected_commit())<CR>
endfunction

command! ZealSplit :execute s:ZealSplit()
