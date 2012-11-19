" Regular Expressions:
let s:regex = '\v\s+%#@<!$'
let s:regex_all = '\v\s+$'


" Whether or not to care about trailing whitespace.
" @param {string?} The filetype to check. Default &ft.
function! trailguide#cares(...)
	let l:ft = a:0 > 0 ? a:1 : &ft
	return !&readonly && index(g:trailguide_exceptions, l:ft) == -1
endfunction


" Finds whether or not a file has trailing  whitespace.
" @param {string?} The filetype to check. Default &ft.
" @return {boolean} Whether there is trailing whitespace.
function! trailguide#detected(...)
	return call('trailguide#cares', a:000) ? search(s:regex, 'nw') != 0 : 0
endfunction


" Jump to the next trailing whitespace.
function! trailguide#next()
	call search(s:regex_all, 'w')
endfunction


" Jump to the previous trailing whitespace.
function! trailguide#prev()
	call search(s:regex_all, 'wb')
endfunction


" Removes all trailing whitespace in a range.
" @param {number} line1 Where to start.
" @param {number} line2 Where to end.
function! trailguide#fix(line1, line2)
	if !trailguide#detected() | return | endif
	exe a:line1.','a:line2.'s/'.s:regex_all.'//e'
	norm ''
endfunction


" Shows trailing whitespace.
function! trailguide#show()
	let b:trailguide_showing = matchadd(g:trailguide_matchgroup, s:regex)
endfunction


" Hides trailing whitespace
function! trailguide#hide()
	call s:trailmatch('NONE')
	if exists('b:trailguide_showing')
		call matchdelete(b:trailguide_showing)
		unlet b:trailguide_showing
	endif
endfunction


" Toggles trailing whitespace
function! trailguide#toggle()
	if exists('b:trailguide_showing')
		call trailguide#hide()
	else
		call trailguide#show()
	endif
endfunction
