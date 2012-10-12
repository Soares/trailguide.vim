if exists('g:trailguide#autoload') || &cp || v:version < 700
	finish
endif
let g:trailguide#autoload = 1


" Regular Expressions:
let s:regex = '\m\s\+$'


" Highlights trailing whitespace a certain color.
" @param {string} type The syntax group to highlight with.
function! s:trailmatch(type)
	exe 'match '.a:type.' "'.s:regex.'"'
endfunction


" Whether or not to care about trailing whitespace.
" @param {string?} The filetype to check. Default &ft.
function! trailguide#cares(...)
	let l:ft = a:0 > 0 ? a:1 : &ft
	return get(g:trailguide_exceptions, l:ft) == 0
endfunction


" Finds whether or not a file has trailing  whitespace.
" @param {string?} The filetype to check. Default &ft.
" @return {boolean} Whether there is trailing whitespace.
function! trailguide#warns(...)
	return call('trailguide#cares', a:000) ? search(s:regex, 'nw') != 0 : 0
endfunction


" Legacy wrapper from before function name normalization.
" @param {string?} The filetype to check. Default &ft.
" @return {boolean} Whether there is trailing whitespace.
function! trailguide#HasTrailing(...)
	return call('trailguide#warns', a:000)
endfunction


" Makes a statusline flag about trailing whitespace.
" @return {string}
function! trailguide#statusline()
	return trailguide#warns() ? '[$]' : ''
endfunction


" Jump to the next trailing whitespace.
function! trailguide#next()
	call search(s:regex, 'w')
endfunction


" Jump to the previous trailing whitespace.
function! trailguide#prev()
	call search(s:regex, 'wb')
endfunction


" Removes all trailing whitespace in a range.
" @param {number} line1 Where to start.
" @param {number} line2 Where to end.
function! trailguide#fix(line1, line2)
	if !trailguide#warns() | return | endif
	exe a:line1.','a:line2.'s/'.s:regex.'//e'
	norm ''
endfunction


" Shows trailing whitespace.
function! trailguide#show()
	let b:trailguide_showing = 1
	call s:trailmatch(g:trailguide_matchgroup)
endfunction


" Hides trailing whitespace
function! trailguide#hide()
	call s:trailmatch('NONE')
	if exists('b:trailguide_showing')
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
