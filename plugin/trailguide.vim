" trailguide.vim - Avoid trailing whitespace.
" Author:       Nate Soares <http://so8r.es>
" Version:      3.0.1
" License:      The same as vim itself. (See |license|)

let g:loaded_trailguide = 1


" Whether or not to highlight trailing whitespace automatically.
if !exists('g:trailguide_autohl')
	let g:trailguide_autohl = 1
endif


" Whether or not to make the default key mappings.
if !exists('g:trailguide_automap')
	let g:trailguide_automap = 0
endif


" Whether or not to make the default key mappings.
if !exists('g:trailguide_defcmds')
	let g:trailguide_defcmds = 1
endif


" The matchgroup to use for trailing whitespace.
if !exists('g:trailguide_matchgroup')
	let g:trailguide_matchgroup = 'ErrorMsg'
endif


if g:trailguide_defcmds > 0
  function! s:run(arg, line1, line2)
    if a:arg ==# 'fix'
      call trailguide#fix(a:line1, a:line2)
    elseif a:arg ==# 'prev' || a:arg ==# 'previous'
      call trailguide#prev()
    elseif a:arg ==# 'next'
      call trailguide#next()
    elseif a:arg ==# 'show'
      call trailguide#show()
    elseif a:arg ==# 'hide'
      call trailguide#hide()
    elseif a:arg ==# 'toggle' || a:arg ==# ''
      call trailguide#toggle()
    else
      echohl ErrorMsg
      echo "Unknown TrailGuide command:" a:arg
      echohl None
    endif
  endfunction
  if exists(':TrailGuide') == 2
    echomsg 'overwriting command :TrailGuide'
  endif
  " The arg may be any of: fix, prev(ious), next, show, hide, toggle, and may be
  " empty. If it is empty, 'toggle' is used.
	command! -nargs=? -range=% TrailGuide call s:run(<q-args>, <line1>, <line2>)
elseif g:trailguide_defcmds < 0
  if exists(':TrailGuide') == 2
    echomsg 'deleting command :TrailGuide'
    delcommand TrailGuide
  endif
endif


" Automatically highlight trailing whitespace. Default: 0.
if g:trailguide_autohl
	augroup trailguide
		autocmd!
		autocmd BufEnter ?*
				\	if trailguide#cares()
				\|		call trailguide#show()
				\|	endif
	augroup end
endif

noremap <silent> <Plug>trailguide#fix :call trailguide#fix()<CR>
noremap <silent> <Plug>trailguide#next :call trailguide#next()<CR>
noremap <silent> <Plug>trailguide#prev :call trailguide#prev()<CR>
noremap <silent> <Plug>trailguide#show :call trailguide#show()<CR>
noremap <silent> <Plug>trailguide#hide :call trailguide#hide()<CR>
noremap <silent> <Plug>trailguide#toggle :call trailguide#toggle()<CR>

" Make the default key mappings under <leader>w. Mnemonic: 'whitespace'.
" The leader letter can be configured via g:trailguide_automap.
if !empty(g:trailguide_automap)
	noremap <silent> <leader>ww <Plug>trailguide#fix
	noremap <silent> <leader>wn <Plug>trailguide#next
	noremap <silent> <leader>wp <Plug>trailguide#prev
	noremap <silent> <leader>ws <Plug>trailguide#show
	noremap <silent> <leader>wh <Plug>trailguide#hide
	noremap <silent> <leader>wt <Plug>trailguide#toggle
endif
