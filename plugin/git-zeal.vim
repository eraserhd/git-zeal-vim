if exists('g:loaded_git_zeal') || &cp
  finish
endif
let g:loaded_git_zeal = 1

function! s:ZealSplit() abort
  split term://git zeal run
  7wincmd _
  set winfixheight
endfunction

command! ZealSplit :execute s:ZealSplit()
