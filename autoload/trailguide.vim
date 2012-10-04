if exists('g:trailguide#autoload') || &cp || v:version < 700
	finish
endif
let g:trailguide#autoload = 1

let s:regex = '\m\s\+$'

" Highlights trailing whitespace a certain color.
function! s:TrailMatch(type)
	exe 'match '.a:type.' "'.s:regex.'"'
endfunction


" Whether or not to care about trailing whitespace.
" Args:
"   {string} filetype the filetype to check. Defaults to &ft.
function! trailguide#Cares(...)
	let l:ft = a:0 > 0 ? a:1 : &ft
	return get(g:trailguide_exceptions, l:ft) == 0
endfunction


" Finds whether or not a file has trailing  whitespace.
" Returns:
"   0 if the file is clean of trailing whitespace, non-zero otherwise.
function! trailguide#HasTrailing()
	return call('trailguide#Cares', a:000) ? search(s:regex, 'nw') != 0 : 0
endfunction


" Jump to the next trailing whitespace.
function! trailguide#Next()
	call search(s:regex, 'w')
endfunction

" Jump to the previous trailing whitespace.
function! trailguide#Prev()
	call search(s:regex, 'wb')
endfunction

" Removes all trailing whitespace in a range.
" Args:
"   {string} start the beginning of the range.
"   {string} end the end of the range.
function! trailguide#Fix(start, end)
	if !trailguide#HasTrailing() | return | endif
	exe a:start.','a:end.'s/'.s:regex.'//e'
	norm ''
endfunction


" Shows trailing whitespace.
function! trailguide#Show()
	let b:trailguide_showing = 1
	call s:TrailMatch(g:trailguide_matchgroup)
endfunction
command! ShowTrailingWhitespace call trailguide#Show()

" Hides trailing whitespace
function! trailguide#Hide()
	call s:TrailMatch('NONE')
	if exists('b:trailguide_showing')
		unlet b:trailguide_showing
	endif
endfunction
command! HideTrailingWhitespace call trailguide#Hide()

" Toggles trailing whitespace
function! trailguide#Toggle()
	if exists('b:trailguide_showing')
		call trailguide#Hide()
	else
		call trailguide#Show()
	endif
endfunction
command! ToggleTrailingWhitespace call trailguide#Toggle()
