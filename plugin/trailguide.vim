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


" Make the default key mappings under <leader>w. Mnemonic: 'whitespace'.
" The leader letter can be configured via g:trailguide_automap.
if !empty(g:trailguide_automap)
	function! s:coerce(target, default)
		return type(a:target) == type(a:default) ? a:target : a:default
	endfunction
	let s:map = 'noremap <unique> <silent>'
	let s:prefix = '<leader>' . s:coerce(g:trailguide_automap, 'w')

	execute s:map s:prefix.'n :call trailguide#next()<CR>'
	execute s:map s:prefix.'p :call trailguide#prev()<CR>'
	execute s:map s:prefix.'w :call trailguide#fix()<CR>'
	execute s:map s:prefix.'s :call trailguide#show()<CR>'
	execute s:map s:prefix.'h :call trailguide#hide()<CR>'
	execute s:map s:prefix.'t :call trailguide#toggle()<CR>'
endif
